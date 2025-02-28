.PHONY: clean build publish

clean:
	# Remove build artifacts
	rm -rf dist/
	rm -rf build/
	rm -rf *.egg-info
	find . -type d -name __pycache__ -exec rm -rf {} +

build: clean
	# Build the package
	poetry build

publish: build
	# Publish to PyPI
	twine upload dist/*
