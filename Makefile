.PHONY: build clean

pi3r_dir := ~/projects/pi3r

build: site

site:
	docker run --user $$UID -v `pwd`:/antora --rm antora/antora site.yml --cache-dir /antora/.cache --pull

local:
	@docker run --user $$UID -v `pwd`:/antora -v $(pi3r_dir)/notebook:/notebook -v $(pi3r_dir)/devbox:/devbox --rm antora/antora generate --cache-dir /antora/.cache --pull site_local.yml

debug:
	@docker run -it --entrypoint ash --user $$UID -v `pwd`:/antora -v $(pi3r_dir)/notebook:/notebook --rm antora/antora

preview:
	docker run  -p 80:80 --rm ${docker_name}

publish: promote deploy

promote: .latest_tag
	docker push ${docker_name}:$$(cat .latest_tag)
	docker push ${docker_name}:latest

deploy:
	ansible-playbook ansible/deploy.yml --extra-vars "docker_name='cicd-docker.repository.irisnet.be/cicd-docs'" -i docs.cicd.cirb.lan,

clean:
	rm -rf build
