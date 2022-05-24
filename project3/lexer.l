%option yylineno
%pointer

%{
    #include <cstdlib>
    #include <cerrno>
    #include <climits>
    #include <limits>
    #include "parser.hpp"
  int linenum = 1;  
	void yyerror(const char *);
%}

/* WRITEME: Write any definitions here. You can find information on
            definitions here:
            ftp://ftp.gnu.org/old-gnu/Manuals/flex-2.5.4/html_mono/flex.html#SEC10 */
digit    [0-9]
alpha    [a-zA-Z]
alnum    {alpha}|{digit}
print    [ -~]


ID        {alpha}+{alnum}*
IN        "0"|[0-9]{digit}*
FLT       "0"|{digit}*"."{digit}+
STRING        \"{print}*\"

/* WRITEME: If you are going to use start conditions, write them here.
            You can find more information on start conditions here:
            ftp://ftp.gnu.org/old-gnu/Manuals/flex-2.5.4/html_mono/flex.html#SEC11
            You will probably want to use exclusive conditions rather
            than inclusive conditions (use the %x instead of the %s). */

%%

  /* WRITEME: Write your Flex token rules here */
"char"|"CHAR"                 {return T_CHARTOKEN}
"int"|"INT"                 {return T_INTTOKEN}
"float"|"FLOAT"                 {return T_FLOATTOKEN}
"double"|"DOUBLE"                 {return T_DOUBLETOKEN}
"boolean"|"BOOLEAN"                 {return T_BOOLEANTOKEN}
"if"|"IF"                 {return T_IFTOKEN}
"else"|"ELSE"                 {return T_ELSETOKEN}
"while"|"WHILE"                 {return T_WHILETOKEN}
"do"|"DO"                 {return T_DOTOKEN}
"for"|"FOR"                 {return T_FORTOKEN}
"continue"|"CONTINUE"                 {return T_CONTTOKEN}
"break"|"BREAK"                 {return T_BREAKTOKEN}
"void"|"VOID"                 {return T_VOIDTOKEN}
"return"|"RETURN"                 {return T_RETURNTOKEN}
"extends"|"EXTENDS"                 {return T_EXTENDSTOKEN}
"and"|"AND"                 {return T_ANDTOKEN}

"+"                 {return T_ADDTOKEN}
"-"                 {return T_MINUSTOKEN}
"*"                 {return T_MULTOKEN}
"/"                 {return T_DIVTOKEN}
"++"                 {return T_INCRTOKEN}
"--"                 {return T_DECTOKEN}
"||"                 {return T_LOGORTOKEN}
"&&"                 {return T_LOGANDTOKEN}
"!"                 {return T_NOTTOKEN}
"=="                 {return T_EQUIVTOKEN}
"!="                 {return T_NOTEQUIVTOKEN}
">"                 {return T_GREATTOKEN}
"<"                 {return T_LESSTOKEN}
">="                 {return T_GREATEQUALTOKEN}
"<="                 {return T_LESSEQUALTOKEN}

"("                 {return T_RPARENTOKEN}
")"                 {return T_LPARENTOKEN}
"["                 {return T_RBRACKTOKEN}
"]"                 {return T_LBRACKTOKEN}
"{"                 {return T_RBRACETOKEN}
"}"                 {return T_LBRACETOKEN}
";"                 {return T_SEMITOKEN}
"."                 {return T_DOTTOKEN}
","                 {return T_COMMATOKEN}
"="                 {return T_ASSIGNTOKEN}
"&"                 {return T_REFERTOKEN}
"->"                 {return T_FUNCRETRNTOKEN}

{ID}                 {return "ID"}
{IN}                 {return "INT"}
{STRING}                 {return "STRING"}

[ \t\r\f]+                 /* remove the whitespace */
.                 { yyerror("invalid character"); }

%%

int yywrap(void) {
  return 1;
}
