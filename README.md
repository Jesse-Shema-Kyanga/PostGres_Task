# PostGres_Task
# Makefile
.PHONY: postgres-start postgres-stop

# PostgreSQL configuration
DB_NAME=postgresmtn
DB_PORT=3109
POSTGRES_PASSWORD=your_password_here
VOLUME_NAME=postgres_data

postgres-start:
	docker run --name $(DB_NAME) \
		-e POSTGRES_PASSWORD=$(POSTGRES_PASSWORD) \
		-p $(DB_PORT):5432 \
		-v $(VOLUME_NAME):/var/lib/postgresql/data \
		-d postgres:latest

postgres-stop:
	docker stop $(DB_NAME)
	docker rm $(DB_NAME)

# Create volume if it doesn't exist
volume-create:
	docker volume create $(VOLUME_NAME)




then i checked for data persistence


i accessed postgres

"docker exec -it postgresmtn psql -U postgres"

created a database and added data

"-- Create a test database
CREATE DATABASE testdb;

-- Connect to it
\c testdb

-- Create a test table
CREATE TABLE persistence_test (
    id SERIAL PRIMARY KEY,
    test_text VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert some data
INSERT INTO persistence_test (test_text) VALUES ('Test Entry 1');
INSERT INTO persistence_test (test_text) VALUES ('Test Entry 2');

-- View the data
SELECT * FROM persistence_test;"


then i quit the database 
"\q"

then i stopped the container completely
"make postgres-stop"

then restarted the container
"make postgres-start"

accessed the db again and checked for persistance
"docker exec -it postgresmtn psql -U postgres
\c testdb;
SELECT * FROM persistence_test; "
