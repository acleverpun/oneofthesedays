all: run

clean:
	scripts/clean.sh

build: clean
	scripts/build.sh

watch: clean
	scripts/watch.sh

run: build
	scripts/run.sh

lint:
	scripts/lint.sh
