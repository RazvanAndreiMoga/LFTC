%{
#include <stdio.h>
#include <stdlib.h>
#define _XOPEN_SOURCE_EXTENDED 1
#include <strings.h>

#define YYDEBUG 1
%}

%token MAIN
%token READ
%token WRITE
%token IF
%token ELSE
%token WHILE
%token FOR
%token IN
%token RANGE
%token INTEGER
%token STRING
%token CHAR
%token READ_SYMBOL
%token WRITE_SYMBOL
%token SEMICOLON
%token COLON
%token COMMA
%token OPEN_ROUND_BRACKET
%token CLOSED_ROUND_BRACKET
%token OPEN_SQUARE_BRACKET
%token CLOSED_SQUARE_BRACKET
%token OPEN_CURLY_BRACKET
%token CLOSED_CURLY_BRACKET
%token PLUS
%token MINUS
%token MULTIPLICATION
%token DIVISION
%token MODULO
%token ASSIGNMENT
%token GT
%token GTE
%token LT
%token LTE
%token EQ
%token NOT_EQ
%token INT_CONSTANT
%token STRING_CONSTANT
%token CHAR_CONSTANT
%token IDENTIFIER
%start program

%%

program : MAIN OPEN_ROUND_BRACKET CLOSED_ROUND_BRACKET OPEN_CURLY_BRACKET statement CLOSED_CURLY_BRACKET {printf("program -> main ( ) { statement }\n");}
	;
statement : declaration_statement {printf("statement -> declaration_statement\n");}
	| assignment_statement {printf("statement -> assignment_statement\n");}
	| if_statement {printf("statement -> if_statement\n");}
	| for_statement {printf("statement -> for_statement\n");}
	| while_statement {printf("statement -> while_statement\n");}
	| read_statement {printf("statement -> read_statement\n");}
	| write_statement {printf("statement -> write_statement\n");}
	| declaration_statement statement {printf("statement -> declaration_statement statement\n");}
	| assignment_statement statement {printf("statement -> assignment_statement statement\n");}
	| if_statement statement {printf("statement -> if_statement statement\n");}
	| for_statement statement {printf("statement -> for_statement statement\n");}
	| while_statement statement {printf("statement -> while_statement statement\n");}
	| read_statement statement {printf("statement -> read_statement statement\n");}
	| write_statement statement {printf("statement -> write_statement statement\n");}
	;
declaration_statement : variable_declaration_statement {printf("declaration_statement -> variable_declaration_statement\n");}
	| array_declaration_statement {printf("declaration_statement -> array_declaration_statement\n");}
	;
variable_declaration_statement : identifier_list COLON type SEMICOLON {printf("variable_declaration_statement -> identifier_list : type ;\n");}
	| identifier_list COLON type ASSIGNMENT expression SEMICOLON {printf("variable_declaration_statement -> identifier_list : type = expression ;\n");}
	;
array_declaration_statement : identifier_list COLON type OPEN_SQUARE_BRACKET CLOSED_SQUARE_BRACKET SEMICOLON {printf("array_declaration_statement -> identifier_list : type [ ] ;\n");}
	;
identifier_list : IDENTIFIER {printf("identifier_list -> identifier\n");}
	| IDENTIFIER COMMA identifier_list {printf("identifier_list -> identifier , identifier_list\n");}
	;
type : INTEGER {printf("type -> Integer\n");}
	| STRING {printf("type -> String\n");}
	| CHAR {printf("type -> Char\n");}
	;
expression : int_expression {printf("expression -> int_expression\n");}
	| string_expression {printf("expression -> string_expression\n");}
	| char_expression {printf("expression -> char_expression\n");}
	;
int_expression : INT_CONSTANT {printf("int_expression -> constant\n");}
	| INT_CONSTANT PLUS int_expression {printf("int_expression -> constant + int_expression\n");}
	| INT_CONSTANT MINUS int_expression {printf("int_expression -> constant - int_expression\n");}
	| INT_CONSTANT MULTIPLICATION int_expression {printf("int_expression -> constant * int_expression\n");}
	| INT_CONSTANT DIVISION int_expression {printf("int_expression -> constant / int_expression\n");}
	| INT_CONSTANT MODULO int_expression {printf("int_expression -> constant % int_expression\n");}
	| IDENTIFIER {printf("int_expression -> identifier\n");}
	| IDENTIFIER PLUS int_expression {printf("int_expression -> identifier + int_expression\n");}
	| IDENTIFIER MINUS int_expression {printf("int_expression -> identifier - int_expression\n");}
	| IDENTIFIER MULTIPLICATION int_expression {printf("int_expression -> identifier * int_expression\n");}
	| IDENTIFIER DIVISION int_expression {printf("int_expression -> identifier / int_expression\n");}
	| IDENTIFIER MODULO int_expression {printf("int_expression -> identifier % int_expression\n");}
	;
string_expression : STRING_CONSTANT {printf("string_expression -> constant\n");}
	| IDENTIFIER {printf("string_expression -> identifier\n");}
	;
char_expression : CHAR_CONSTANT {printf("char_expression -> constant\n");}
	| IDENTIFIER {printf("char_expression -> identifier\n");}
	;
assignment_statement : IDENTIFIER ASSIGNMENT IDENTIFIER SEMICOLON {printf("assignment_statement -> identifier = identifier ;\n");}
	| IDENTIFIER ASSIGNMENT expression SEMICOLON {printf("assignment_statement -> identifier = expression ;\n");}
	;
if_statement : IF OPEN_ROUND_BRACKET condition CLOSED_ROUND_BRACKET OPEN_CURLY_BRACKET statement CLOSED_CURLY_BRACKET {printf("if_statement -> if ( condition ) { statement }\n");}
	| IF OPEN_ROUND_BRACKET condition CLOSED_ROUND_BRACKET OPEN_CURLY_BRACKET statement CLOSED_CURLY_BRACKET ELSE OPEN_CURLY_BRACKET statement CLOSED_CURLY_BRACKET {printf("if_statement -> if ( condition ) { statement } else { statement }\n");}
	;
condition : expression relation expression {printf("condition -> expression relation expression\n");}
	;
relation : GT {printf("relation -> >\n");}
	| GTE {printf("relation -> >=\n");}
	| LT {printf("relation -> <\n");}
	| LTE {printf("relation -> <=\n");}
	| EQ {printf("relation -> ==\n");}
	| NOT_EQ {printf("relation -> !=\n");}
	;
while_statement : WHILE OPEN_ROUND_BRACKET condition CLOSED_ROUND_BRACKET OPEN_CURLY_BRACKET statement CLOSED_CURLY_BRACKET {printf("while_statement -> while ( condition ) { statement }\n");}
	;
for_statement : FOR IDENTIFIER IN IDENTIFIER OPEN_CURLY_BRACKET statement CLOSED_CURLY_BRACKET {printf("for_statement -> for identifier in identifier { statement }\n");}
	| FOR IDENTIFIER IN RANGE OPEN_ROUND_BRACKET range_list CLOSED_ROUND_BRACKET OPEN_CURLY_BRACKET statement CLOSED_CURLY_BRACKET {printf("for_statement -> for identifier in range ( range_list ) { statement }\n");}
	;
range_list : INT_CONSTANT {printf("range_list -> constant\n");}
	| IDENTIFIER {printf("range_list -> identifier\n");}
	| INT_CONSTANT COMMA INT_CONSTANT {printf("range_list -> constant , constant\n");}
	| INT_CONSTANT COMMA INT_CONSTANT COMMA INT_CONSTANT {printf("range_list -> constant , constant , constant\n");}
	;
read_statement : READ read_helper SEMICOLON {printf("read_statement -> read read_helper ;\n");}
	;
read_helper : READ_SYMBOL IDENTIFIER {printf("read_helper -> >> identifier\n");}
	| READ_SYMBOL IDENTIFIER OPEN_SQUARE_BRACKET IDENTIFIER CLOSED_SQUARE_BRACKET {printf("read_helper -> >> identifier [ identifier ]\n");}
	| READ_SYMBOL IDENTIFIER read_helper {printf("read_helper -> >> identifier read_helper\n");}
	;
write_statement : WRITE write_helper SEMICOLON {printf("write_statement -> write write_helper ;\n");}
	;
write_helper : WRITE_SYMBOL IDENTIFIER {printf("write_helper -> << identifier\n");}
	| WRITE_SYMBOL IDENTIFIER write_helper {printf("write_helper -> << identifier write_helper\n");}
	| WRITE_SYMBOL INT_CONSTANT {printf("write_helper -> << constant\n");}
	| WRITE_SYMBOL INT_CONSTANT write_helper {printf("write_helper -> << constant write_helper\n");}
	| WRITE_SYMBOL STRING_CONSTANT {printf("write_helper -> << constant\n");}
	| WRITE_SYMBOL STRING_CONSTANT write_helper {printf("write_helper -> << constant write_helper\n");}
	| WRITE_SYMBOL CHAR_CONSTANT {printf("write_helper -> << constant\n");}
	| WRITE_SYMBOL CHAR_CONSTANT write_helper {printf("write_helper -> << constant write_helper\n");}
	;

%%

yyerror(char *s)
{	
	printf("%s\n",s);
}

extern FILE *yyin;

main(int argc, char **argv)
{
	if(argc>1) yyin :  fopen(argv[1],"r");
	if(argc>2 && !strcmp(argv[2],"-d")) yydebug: 1;
	if(!yyparse()) fprintf(stderr, "\tO.K.\n");
}