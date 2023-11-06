postgres:
	docker run --name postgres16 -p 5433:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=test123 -d postgres:16-alpine

createdb:
	docker exec -it postgres16 createdb --username=postgres --owner=postgres simple_bank

dropdb:
	docker exec -it postgres16 dropdb --username=postgres simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://postgres:test123@localhost:5433/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://postgres:test123@localhost:5433/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

.PHONY: postgres createdb dropdb migrateup migratedown sqlc