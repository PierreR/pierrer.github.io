.PHONY: build clean scraper preview indices

pi3r_dir := ~/projects/pi3r
mount_dir ?= ${SHARED_DIR}

build: clean site tar

gulp := ./node_modules/.bin/gulp
mount_dir ?= ${SHARED_DIR}

site:
	antora generate --pull site.yml

node_modules:
	npm install gulp gulp-cli gulp-connect @antora/site-generator-default

preview: node_modules
	@$(gulp)

ui-bundle.zip: ../antora-ui/build/ui-bundle.zip
	cp $^ .

local:
	antora generate --fetch site_local.yml

tar:
	@pushd build/site ; tar -zcvf ../../pi3r-site.tar.gz * >/dev/null 2>&1 ; popd; cp pi3r-site.tar.gz $(mount_dir)
	@echo "Check the new pi3r-site.tar.gz in the $(mount_dir) folder"

publish:
	echo "todo: automate the pushing of the tar to pi3r.be"

indices:
	docker run -it --env-file=.env-algolia -e "CONFIG=$$(cat ./config.json | jq -r tostring)" algolia/docsearch-scraper

clean:
	@rm -rf build/site
