-- Currently, ddl deparse only supports the TABLE command. Therefore, this
-- test file is only prepared for testing the TABLE command.

-- Command prepared for alter_table.sql.
-- For "ADD table_constraint_using_index"
CREATE TABLE test_add_constraint_using_index(
    id1 int,
    id2 int,
    id3 int,
    id4 int,
    id5 int,
    id6 int,
    id7 int
);
CREATE UNIQUE INDEX test_add_constraint_used_index1 ON test_add_constraint_using_index (id1);
CREATE UNIQUE INDEX test_add_constraint_used_index2 ON test_add_constraint_using_index (id2);
CREATE UNIQUE INDEX test_add_constraint_used_index3 ON test_add_constraint_using_index (id3);
CREATE UNIQUE INDEX test_add_constraint_used_index4 ON test_add_constraint_using_index (id4);
CREATE UNIQUE INDEX test_add_constraint_used_index5 ON test_add_constraint_using_index (id5);
CREATE UNIQUE INDEX test_add_constraint_used_index6 ON test_add_constraint_using_index (id6);
CREATE UNIQUE INDEX test_add_constraint_used_index7 ON test_add_constraint_using_index (id7);
