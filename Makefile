start:
	@tools/start_local_api.sh

test:
	@tools/runtest.sh $(filename)

test_coverage:
	@tools/runtest.sh coverage $(filename)

migrate:
	@tools/migrate.sh

generate_api:
	@tools/generate_api.sh $(apiName)
