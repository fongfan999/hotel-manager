CREATE TABLE "schema_migrations" ("version" varchar NOT NULL);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
CREATE TABLE "customer_types" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "discount" float DEFAULT 0.0, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "customers" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "identity_card" varchar, "address" text, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "type_id" integer, "phone_number" varchar, "utf_name" varchar);
CREATE INDEX "index_customers_on_type_id" ON "customers" ("type_id");
CREATE TABLE "room_types" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "cost" decimal, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "rooms" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "annotation" text, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "type_id" integer, "max_quantity" integer DEFAULT 1, "archived_at" date);
CREATE INDEX "index_rooms_on_type_id" ON "rooms" ("type_id");
CREATE TABLE "services" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "unit" varchar, "price" decimal DEFAULT 0.0, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "archived_at" date);
CREATE TABLE "statistics" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "start_date" date, "end_date" date, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "email" varchar DEFAULT '' NOT NULL, "encrypted_password" varchar DEFAULT '' NOT NULL, "reset_password_token" varchar, "reset_password_sent_at" datetime, "remember_created_at" datetime, "sign_in_count" integer DEFAULT 0 NOT NULL, "current_sign_in_at" datetime, "last_sign_in_at" datetime, "current_sign_in_ip" varchar, "last_sign_in_ip" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "admin" boolean DEFAULT 'f', "customer_id" integer, "role" varchar DEFAULT '', "employee_id" integer, "archived_at" datetime);
CREATE INDEX "index_users_on_customer_id" ON "users" ("customer_id");
CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email");
CREATE UNIQUE INDEX "index_users_on_reset_password_token" ON "users" ("reset_password_token");
CREATE TABLE "employees" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "gender" boolean DEFAULT 0, "date_of_birth" date, "phone" varchar, "address" text, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE INDEX "index_users_on_employee_id" ON "users" ("employee_id");
CREATE TABLE "bills" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "receipt_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "employee_id" integer, "customer_type" integer);
CREATE INDEX "index_bills_on_employee_id" ON "bills" ("employee_id");
CREATE INDEX "index_bills_on_receipt_id" ON "bills" ("receipt_id");
CREATE TABLE "receipts" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "customer_id" integer, "room_id" integer, "quantity" integer DEFAULT 1, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "employee_id" integer);
CREATE INDEX "index_receipts_on_customer_id" ON "receipts" ("customer_id");
CREATE INDEX "index_receipts_on_employee_id" ON "receipts" ("employee_id");
CREATE INDEX "index_receipts_on_room_id" ON "receipts" ("room_id");
CREATE TABLE "receipt_services" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "receipt_id" integer, "service_id" integer, "quantity" integer DEFAULT 0);
CREATE INDEX "index_receipt_services_on_receipt_id" ON "receipt_services" ("receipt_id");
CREATE INDEX "index_receipt_services_on_service_id" ON "receipt_services" ("service_id");
INSERT INTO schema_migrations (version) VALUES ('20160519075741');

INSERT INTO schema_migrations (version) VALUES ('20160519093314');

INSERT INTO schema_migrations (version) VALUES ('20160519094610');

INSERT INTO schema_migrations (version) VALUES ('20160519100906');

INSERT INTO schema_migrations (version) VALUES ('20160519104554');

INSERT INTO schema_migrations (version) VALUES ('20160519105627');

INSERT INTO schema_migrations (version) VALUES ('20160519140019');

INSERT INTO schema_migrations (version) VALUES ('20160520021833');

INSERT INTO schema_migrations (version) VALUES ('20160520033906');

INSERT INTO schema_migrations (version) VALUES ('20160520034334');

INSERT INTO schema_migrations (version) VALUES ('20160520143023');

INSERT INTO schema_migrations (version) VALUES ('20160520144531');

INSERT INTO schema_migrations (version) VALUES ('20160520231058');

INSERT INTO schema_migrations (version) VALUES ('20160521001001');

INSERT INTO schema_migrations (version) VALUES ('20160521010129');

INSERT INTO schema_migrations (version) VALUES ('20160521014204');

INSERT INTO schema_migrations (version) VALUES ('20160522081007');

INSERT INTO schema_migrations (version) VALUES ('20160524032019');

INSERT INTO schema_migrations (version) VALUES ('20160524065922');

INSERT INTO schema_migrations (version) VALUES ('20160524091844');

INSERT INTO schema_migrations (version) VALUES ('20160524155110');

INSERT INTO schema_migrations (version) VALUES ('20160606081941');

INSERT INTO schema_migrations (version) VALUES ('20160606110204');

INSERT INTO schema_migrations (version) VALUES ('20160606110401');

INSERT INTO schema_migrations (version) VALUES ('20160608044230');

INSERT INTO schema_migrations (version) VALUES ('20160608073535');

INSERT INTO schema_migrations (version) VALUES ('20160608075838');

INSERT INTO schema_migrations (version) VALUES ('20160609023132');

INSERT INTO schema_migrations (version) VALUES ('20160614015945');

INSERT INTO schema_migrations (version) VALUES ('20160615014636');

INSERT INTO schema_migrations (version) VALUES ('20160615015015');

