.PHONY: build clean

pi3r_dir := ~/projects/pi3r

build: clean site tar

site:
	docker run --user $$UID -v `pwd`:/antora --rm antora/antora site.yml --cache-dir /antora/.cache --pull

debug:
	@docker run -it --entrypoint ash --user $$UID -v `pwd`:/antora -v $(pi3r_dir)/notebook:/notebook --rm antora/antora

local:
	@docker run --user $$UID -v `pwd`:/antora -v $(pi3r_dir)/notebook:/notebook -v $(pi3r_dir)/devbox:/devbox --rm antora/antora generate --cache-dir /antora/.cache --pull site_local.yml

preview:
	@pushd build/site ; nohup python -m SimpleHTTPServer >/dev/null 2>&1 & echo  "$$!" >/tmp/pierrer-preview-python.pid ; popd
	echo "Server running"

tar:
	@pushd build/site ; tar -zcvf ../../pi3r-site.tar.gz * >/dev/null 2>&1 ; popd; cp pi3r-site.tar.gz /vagrant
	echo "Check the new pi3r-site.tar.gz in the /vagrant folder"

publish:
	echo "todo: automate the pushing of the tar to pi3r.be"

kill:
	kill -9 `cat /tmp/pierrer-preview-python.pid`

clean:
	rm -rf build/site
