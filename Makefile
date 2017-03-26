dist/main.js: assets/*
	rsync -ai assets/* dist/
	elm make $(elm_options) src/Main.elm --output dist/elm.js


.PHONY: debug
debug:
	$(MAKE) elm_options=--debug


.PHONY: launch
launch: dist/main.js
	electron dist/main.js &


.PHONY: watch
watch: launch
	node_modules/.bin/chokidar 'src/**' 'assets/**' -c "$(MAKE) | grep -v '^make\['"


.PHONY: clean
clean:
	rm -rf elm-stuff/build-artifacts/*/user
	rm -rf dist/*
