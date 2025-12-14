install:
	bundle install
verify:
	bundle exec jekyll --version
build: install 
	bundle exec jekyll build
serve: build
	bundle exec jekyll serve --host 0.0.0.0 --port 4000 --livereload