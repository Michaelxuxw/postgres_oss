/*----------------------------------------------------------------------
 * test_ddl_deparse_regress.c
 *		Support functions for the test_ddl_deparse_regress module
 *
 * Copyright (c) 2014-2023, PostgreSQL Global Development Group
 *
 * IDENTIFICATION
 *	  src/test/modules/test_ddl_deparse_regress/test_ddl_deparse_regress.c
 *----------------------------------------------------------------------
 */
#include "postgres.h"

#include "catalog/pg_type.h"
#include "funcapi.h"
#include "nodes/execnodes.h"
#include "tcop/deparse_utility.h"
#include "tcop/utility.h"
#include "utils/builtins.h"
#include "tcop/ddldeparse.h"

PG_MODULE_MAGIC;

PG_FUNCTION_INFO_V1(deparse_drop_ddl);

/*
 * Given object_identity and object_type of dropped object, return a JSON representation of DROP command.
 */
Datum
deparse_drop_ddl(PG_FUNCTION_ARGS)
{
	text	   *objidentity = PG_GETARG_TEXT_P(0);
	const char	   *objidentity_str = text_to_cstring(objidentity);
	text	   *objecttype = PG_GETARG_TEXT_P(1);
	const char	   *objecttype_str = text_to_cstring(objecttype);
	DropStmt	   fake_node;
	char		   *command;

	/*
	 * XXX We can't get these three actions from
	 * pg_event_trigger_dropped_objects, so we use fake options here.
	 */
	fake_node.behavior = DROP_CASCADE;
	fake_node.missing_ok = true;
	fake_node.concurrent = false;

	// constraint is part of alter table command, no need to drop in DROP command
	if (strcmp(objecttype_str, "table constraint") == 0) {
		PG_RETURN_NULL();
	} else if (strcmp(objecttype_str, "toast table") == 0) {
		objecttype_str = "table";
	}  else if (strcmp(objecttype_str, "default value") == 0) {
		PG_RETURN_NULL();
	} else if (strcmp(objecttype_str, "operator of access method") == 0) {
		PG_RETURN_NULL();
	} else if (strcmp(objecttype_str, "function of access method") == 0) {
		PG_RETURN_NULL();
	} else if (strcmp(objecttype_str, "table column") == 0) {
		PG_RETURN_NULL();
	}

	command = deparse_drop_command(objidentity_str, objecttype_str, (Node *)&fake_node);

	if (command)
		PG_RETURN_TEXT_P(cstring_to_text(command));

	PG_RETURN_NULL();
}