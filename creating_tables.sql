CREATE TABLE if not exists "jobs" (
  "id" SERIAL PRIMARY KEY,
  "type" varchar(50),
  "price" numeric(8, 2)
);

CREATE TABLE if not exists "car_marks" (
  "id" SERIAL PRIMARY KEY,
  "mark_name" varchar(50)
);

CREATE TABLE if not exists "town" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar(50)
);

CREATE TABLE if not exists "clients" (
  "id" SERIAL PRIMARY KEY,
  "first_name" varchar(50),
  "last_name" varchar(50),
  "phone" smallint,
  "town_id" smallint REFERENCES "town"(id)
);

CREATE TABLE if not exists "cars" (
  "id" SERIAL PRIMARY KEY,
  "car_marks_id" smallint REFERENCES "car_marks"(id),
  "car_owner" smallint REFERENCES "clients"(id)
);

CREATE TABLE if not exists "orders" (
  "id" SERIAL PRIMARY KEY,
  "job_id" smallint REFERENCES "jobs"(id),
  "car_id" smallint REFERENCES "cars"(id),
  "client_id" smallint REFERENCES "clients"(id)
  "order_date" timestamp
);