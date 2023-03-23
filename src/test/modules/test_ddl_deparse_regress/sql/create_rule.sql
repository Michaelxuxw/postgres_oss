-- Currently, ddl deparse only supports the TABLE command. Therefore, this
-- test file is only prepared for testing the TABLE command.

-- Command prepared for alter_table.sql.
-- For "DISABLE RULE rewrite_rule_name"
CREATE TABLE test_disable_rule(
    id int,
    name varchar,
    description text,
    price float4,
    quantity int,
    purchase_date date
);
CREATE RULE sample_rule1 AS
    ON UPDATE TO test_disable_rule
    DO INSTEAD
        SELECT * FROM test_disable_rule;
-- For "ENABLE RULE rewrite_rule_name"
CREATE TABLE test_enable_rule(
    LIKE test_disable_rule
);
CREATE RULE sample_rule2 AS
    ON UPDATE TO test_enable_rule
    DO INSTEAD
        SELECT * FROM test_enable_rule;
-- For "ENABLE REPLICA RULE rewrite_rule_name"
CREATE TABLE test_enable_replica_rule(
    LIKE test_disable_rule
);
CREATE RULE sample_rule_enable_replica AS
    ON UPDATE TO test_enable_replica_rule
    DO INSTEAD
        SELECT * FROM test_enable_replica_rule;
-- For "ENABLE ALWAYS RULE rewrite_rule_name"
CREATE TABLE test_enable_always_rule(
    LIKE test_disable_rule
);
CREATE RULE sample_rule_enable_always AS
    ON UPDATE TO test_enable_always_rule
    DO INSTEAD
        SELECT * FROM test_enable_always_rule;
