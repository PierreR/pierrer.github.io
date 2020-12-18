.PHONY: build clean scraper

pi3r_dir := ~/projects/pi3r
mount_dir ?= ${SHARED_DIR}

build: clean site tar

site:
	antora generate --pull site.yml

ui-bundle.zip: ../antora-ui/build/ui-bundle.zip
	cp $^ .

local:
	antora generate --fetch site_local.yml

preview: ## Preview the documentation site locally
	http-server build/site -r -c-1 -g
tar:
	@pushd build/site ; tar -zcvf ../../pi3r-site.tar.gz * >/dev/null 2>&1 ; popd; cp pi3r-site.tar.gz $(mount_dir)
	@echo "Check the new pi3r-site.tar.gz in the $(mount_dir) folder"

publish:
	echo "todo: automate the pushing of the tar to pi3r.be"

requirements.nix:
	pypi2nix -r requirements.txt

scraper: requirements.nix docsearch-scraper/.env
	nix-shell requirements.nix -A interpreter --run "pushd docsearch-scraper; ./docsearch docker:build; popd"

indices: requirements.nix docsearch-scraper/.env
	nix-shell requirements.nix -A interpreter --run "pushd docsearch-scraper; ./docsearch docker:run ../config.json; popd"

clean:
	@rm -rf build/site
