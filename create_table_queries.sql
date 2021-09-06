-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.
CREATE TABLE "makes" (
    "id" INT   NOT NULL,
    "make" VARCHAR   NOT NULL,
    "origin" VARCHAR   NOT NULL,
    "car_count" INT   NOT NULL,
    CONSTRAINT "pk_makes" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "pricing_spec" (
    "id" INT   NOT NULL,
    "min_msrp" FLOAT   NOT NULL,
    "avg_msrp" FLOAT   NOT NULL,
    "max_msrp" FLOAT   NOT NULL,
    CONSTRAINT "pk_pricing_spec" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "engine_spec" (
    "id" INT   NOT NULL,
    "min_engine_size" FLOAT   NOT NULL,
    "avg_engine_size" FLOAT   NOT NULL,
    "max_engine_size" FLOAT   NOT NULL,
    "min_cylinders" FLOAT   NOT NULL,
    "avg_cylinders" FLOAT   NOT NULL,
    "max_cylinders" FLOAT   NOT NULL,
    "min_horsepower" FLOAT   NOT NULL,
    "avg_horsepower" FLOAT   NOT NULL,
    "max_horsepower" FLOAT   NOT NULL,
    CONSTRAINT "pk_engine_spec" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "fuel_spec" (
    "id" INT   NOT NULL,
    "min_mpg_city" FLOAT   NOT NULL,
    "avg_mpg_city" FLOAT   NOT NULL,
    "max_mpg_city" FLOAT   NOT NULL,
    "min_mpg_highway" FLOAT   NOT NULL,
    "avg_mpg_highway" FLOAT   NOT NULL,
    "max_mpg_highway" FLOAT   NOT NULL,
    CONSTRAINT "pk_fuel_spec" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "chassis_spec" (
    "id" INT   NOT NULL,
    "min_weight" FLOAT   NOT NULL,
    "avg_weight" FLOAT   NOT NULL,
    "max_weight" FLOAT   NOT NULL,
    "min_wheelbase" FLOAT   NOT NULL,
    "avg_wheelbase" FLOAT   NOT NULL,
    "max_wheelbase" FLOAT   NOT NULL,
    "min_length" FLOAT   NOT NULL,
    "avg_length" FLOAT   NOT NULL,
    "max_length" FLOAT   NOT NULL,
    CONSTRAINT "pk_chassis_spec" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "sales_data" (
    "id" INT   NOT NULL,
    "passenger_vol" INT   NOT NULL,
    "suv_vol" INT   NOT NULL,
    "total_vol" INT   NOT NULL,
    CONSTRAINT "pk_sales_data" PRIMARY KEY (
        "id"
     )
);

ALTER TABLE "pricing_spec" ADD CONSTRAINT "fk_pricing_spec_id" FOREIGN KEY("id")
REFERENCES "makes" ("id");

ALTER TABLE "engine_spec" ADD CONSTRAINT "fk_engine_spec_id" FOREIGN KEY("id")
REFERENCES "makes" ("id");

ALTER TABLE "fuel_spec" ADD CONSTRAINT "fk_fuel_spec_id" FOREIGN KEY("id")
REFERENCES "makes" ("id");

ALTER TABLE "chassis_spec" ADD CONSTRAINT "fk_chassis_spec_id" FOREIGN KEY("id")
REFERENCES "makes" ("id");

ALTER TABLE "sales_data" ADD CONSTRAINT "fk_sales_data_id" FOREIGN KEY("id")
REFERENCES "makes" ("id");

