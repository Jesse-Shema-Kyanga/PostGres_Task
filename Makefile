# Makefile
# Important: Ensure this file uses LF (Unix) line endings, not CRLF
.PHONY: postgres-start postgres-stop

# PostgreSQL configuration
DB_NAME=postgresmtn
DB_PORT=3109
POSTGRES_PASSWORD=Onthemoon29!
VOLUME_NAME=postgres_data

# Note: Using double quotes for Windows compatibility
postgres-start:
	docker run --name $(DB_NAME) \
		-e POSTGRES_PASSWORD=$(POSTGRES_PASSWORD) \
		-p $(DB_PORT):5432 \
		-v $(VOLUME_NAME):/var/lib/postgresql/data \
		-d postgres:latest

postgres-stop:
	docker stop $(DB_NAME) || true
	docker rm $(DB_NAME) || true

volume-create:
	docker volume create $(VOLUME_NAME)

# Additional Windows-specific commands
ps:
	docker ps

logs:
	docker logs $(DB_NAME)