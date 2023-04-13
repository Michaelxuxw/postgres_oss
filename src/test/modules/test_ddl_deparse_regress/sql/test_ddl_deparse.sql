CREATE ROLE ddl_testing_role SUPERUSER;
SET ROLE ddl_testing_role;

CREATE EXTENSION test_ddl_deparse_regress;

CREATE OR REPLACE FUNCTION test_ddl_deparse()
  RETURNS event_trigger LANGUAGE plpgsql AS
$$
DECLARE
	r record;
	deparsed_json text;
BEGIN
	FOR r IN SELECT * FROM pg_event_trigger_ddl_commands()
		-- Some TABLE commands generate sequence-related commands, also deparse them.
		WHERE command_tag in ('ALTER FOREIGN TABLE', 'ALTER TABLE',
							  'CREATE FOREIGN TABLE', 'CREATE TABLE',
							  'CREATE TABLE AS', 'DROP FOREIGN TABLE',
							  'DROP TABLE', 'ALTER SEQUENCE',
							  'CREATE SEQUENCE', 'DROP SEQUENCE',
							  'ALTER INDEX', 'CREATE INDEX', 'DROP INDEX')
	LOOP
		deparsed_json = pg_catalog.ddl_deparse_to_json(r.command);
		RAISE NOTICE 'deparsed json: %', deparsed_json;
		RAISE NOTICE 're-formed command: %', pg_catalog.ddl_deparse_expand_command(deparsed_json);
	END LOOP;
END;
$$;

CREATE EVENT TRIGGER test_ddl_deparse
ON ddl_command_end EXECUTE PROCEDURE test_ddl_deparse();
