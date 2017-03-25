dist/main.js: assets/* dist/elm.js
	rsync -ai assets/* dist/


dist/elm.js: src/* elm-package.json
	elm make src/Main.elm --output dist/elm.js


.PHONY: watch
watch: dist/main.js
	node_modules/.bin/chokidar 'src/**' 'assets/**' -c "$(MAKE) | grep -v '^make\['"


.PHONY: clean
clean:
	rm -rf elm-stuff/build-artifacts/*/user
	rm -rf dist/*
