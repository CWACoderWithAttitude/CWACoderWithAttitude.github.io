bundler:
	gem install bundler:4.0.1
install: bundler
	bundle install
verify:
	bundle exec jekyll --version
serve: install
	bundle exec jekyll serve --host 0.0.0.0 --port 4000 --livereload
# these targets can be used to test the running setup
curl_local:
	curl http://localhost:4000
curl_host:
	curl http://host.docker.internal:4040
.PHONY: bundler install verify serve curl_local curl_host
