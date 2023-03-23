-- Currently, ddl deparse only supports the TABLE command. Therefore, this
-- test file is only prepared for testing the TABLE command.

-- Command prepared for create_table.sql.
CREATE TYPE part8_people_type AS (
    id int,
    name varchar,
    height float4,
    weight float4
);

-- Command prepared for alter_table.sql.
-- For "OF type_name"
CREATE TYPE test_type_product_type AS (
    id int,
    name varchar
);
