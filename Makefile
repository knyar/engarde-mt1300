.PHONY: dist
dist:
	mkdir -p dist
	docker build -t engarde_mt1300 .
	docker run --rm -v $(PWD)/dist:/dist engarde_mt1300