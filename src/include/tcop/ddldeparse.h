/*-------------------------------------------------------------------------
 *
 * ddldeparse.h
 *
 * Portions Copyright (c) 1996-2023, PostgreSQL Global Development Group
 * Portions Copyright (c) 1994, Regents of the University of California
 *
 * src/include/tcop/ddldeparse.h
 *
 *-------------------------------------------------------------------------
 */
#ifndef DDL_DEPARSE_H
#define DDL_DEPARSE_H

#include "tcop/deparse_utility.h"

/* Context info needed for deparsing ddl command */
typedef struct
{
	bool		verbose_mode;
	/* provolatile flag of the function contained in the command */
	char		func_volatile;
} ddl_deparse_context;

extern char *deparse_utility_command(CollectedCommand *cmd, ddl_deparse_context *context);
extern char *deparse_ddl_json_to_string(char *jsonb);
extern char *deparse_drop_command(const char *objidentity, const char *objecttype,
								  Node *parsetree);

#endif							/* DDL_DEPARSE_H */
