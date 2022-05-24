%{
    #include <cstdlib>
    #include <cstdio>
    #include <iostream>

    #define YYDEBUG 1

    int yylex(void);
    void yyerror(const char *);
%}

%error-verbose

/* WRITEME: List all your tokens here */

%token T_CHARTOKEN
%token T_INTTOKEN
%token T_FLOATTOKEN
%token T_BOOLEANTOKEN
%token T_DOUBLETOKEN
%token T_IFTOKEN
%token T_ELSETOKEN
%token T_WHILETOKEN
%token T_DOTOKEN
%token T_FORTOKEN
%token T_CONTTOKEN
%token T_BREAKTOKEN
%token T_VOIDTOKEN
%token T_RETURNTOKEN
%token T_ANDTOKEN
%token T_EXTENDSTOKEN
%token T_ADDTOKEN
%token T_MINUSTOKEN
%token T_MULTOKEN
%token T_DIVTOKEN
%token T_INCRTOKEN
%token T_DECRTOKEN
%token T_LOGORTOKEN
%token T_LOGANDTOKEN
%token T_NOTTOKEN
%token T_EQUIVTOKEN
%token T_NOTEQUIVTOKEN
%token T_GREATTOKEN
%token T_LESSTOKEN
%token T_GREATEQUALTOKEN
%token T_LESSEQUALTOKEN
%token T_RPARENTOKEN
%token T_LPARENTOKEN
%token T_RBRACKTOKEN
%token T_LBRACKTOKEN
%token T_RBRACETOKEN
%token T_LBRACETOKEN
%token T_SEMITOKEN
%token T_DOTTOKEN
%token T_COMMATOKEN
%token T_ASSIGNTOKEN
%token T_REFERTOKEN
%token T_FUNCRETRNTOKEN

/* WRITEME: Specify precedence here */

%left T_ASSIGNTOKEN
%left T_ADDTOKEN T_MINUSTOKEN
%left T_MULTOKEN T_DIVTOKEN
%left T_RPARENTOKEN T_LPARENTOKEN
%%

/* WRITEME: This rule is a placeholder, since Bison requires
            at least one rule to run successfully. Replace
            this with your appropriate start rules. */
Start :
      ;

/* WRITME: Write your Bison grammar specification here */

decls: decls decl | decl;
decl: type names ';' ;
type: INT | CHAR | FLOAT | BOOLEAN | DOUBLE | VOID;
names: variable | names ',' variable;
variable: ID |
    ('*')+ID |
    ID('['IN']')+
;

statements: statements statement | statement;
statement:
if_statement | for_statement | while_statement | dowhile_statement | assign | CONTINUE | BREAK | T_RETURNTOKEN
;

if_statement:
IF '(' expression ')' tail
ELSE IF '(' expression ')' tail*
(ELSE tail)?
;

for_statement: FOR '(' expression ';' expression ';' expression ')';

while_statement: WHILE '(' bool_expression ')' tail;
dowhile_statement: DO '{' statements '}'
                    WHILE '(' bool_expression ')' ';'
;
tail: statement | '{' statements '}';

expression:
    expression '+' expression |
    expression '-' expression |
    expression '*' expression |
    expression '/' expression |
    expression '++' |
    expression '--' |
    '++' expression |
    '--' expression |
    expression '||' expression |
    expression '&&' expression |
    '!' expression |
    expression '==' expression |
    expression '!=' expression |
    expression '>' expression |
    expression '<' expression |
    expression '>=' expression |
    expression '<=' expression |
    '(' expression ')' |
    variable |
    '-'? constant
;

constant: IN | FLT;
assign: '&'? variable '=' expression ';' ;
%%

extern int yylineno;

void yyerror(const char *s) {
  fprintf(stderr, "%s at line %d\n", s, yylineno);
  exit(1);
}
