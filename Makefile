.DEFAULT_GOAL := help

help:
	@echo Usage:
	@echo make clean
	@echo make build
	@echo make trace

clean:
	@rm -rf build
	@mkdir -p build

build: FORCE
	@echo -- Configuring project
	@cmake --profiling-output=build/trace_config.json --profiling-format=google-trace -GNinja -S . -B build
	@echo -- Configuring project - done
	@echo -- Building project
	@cmake --build build -t ninjaproject
	@echo -- Building project - done
	@echo -- Converting Ninja Log to Google Trace JSON
	@python external/ninjatracing/ninjatracing build/.ninja_log > build/trace_build.json
	@echo -- Converting Ninja Log to Google Trace JSON - done
	@echo -- Creating dependency graph
	@ninja -C build -t graph ninjaproject > build/ninjaproject.gv
	@dot -Tpng -o build/ninjaproject.png build/ninjaproject.gv
	@echo -- Creating dependency graph - done

trace:
	@echo -- Creating trace visualizations
	@trace2html build/trace_config.json
	@trace2html build/trace_build.json
	@echo -- Creating trace visualizations - done

FORCE: ;