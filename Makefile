install:
	bundle install
verify:
	bundle exec jekyll --version
build:
	bundle exec jekyll build
serve:
	bundle exec jekyll serve --host 0.0.0.0 --port 4000 --livereload