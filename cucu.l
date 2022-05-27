%{
#include <stdlib.h>
#include<string.h>
#define YYSTYPE char*
void yyerror(char *);
#include "cucu.tab.h"
%}
%%
\/\*[^\*\/]*\*\/            ;
[0-9]+                      {
                               yylval=strdup(yytext);
                               fprintf(yyout,"NUM : %s\n",yytext);
                               return NUM;
                            } 
for                         {fprintf(yyout,"KEYWORD : %s\n",yytext);return FOR;}
int                         {fprintf(yyout,"TYPE : %s\n",yytext);return TYPE;}
char[ \t]*\*                {fprintf(yyout,"TYPE : %s\n",yytext);return TYPE;}
return                      {fprintf(yyout,"KEYWORD : %s\n",yytext);return RETURN;}
if                          {fprintf(yyout,"KEYWORD : %s\n",yytext);return IF;}
else                        {fprintf(yyout,"KEYWORD : %s\n",yytext);return ELSE;}
while                       {fprintf(yyout,"KEYWORD : %s\n",yytext);return WHILE;}
[a-zA-Z][a-zA-Z0-9_]*       {
                                yylval=strdup(yytext);
                                fprintf(yyout,"ID : %s\n",yytext);
                                return ID;
                            }
\"[^\"]*\"                    {
                                yylval=strdup(yytext);
                                fprintf(yyout,"STRING : %s\n",yytext);
                                return STRING;
                            }        
\+               {fprintf(yyout,"ARITHEMATIC OPERATOR : %s\n",yytext);return PLUS;}
\*               {fprintf(yyout,"ARITHEMATIC OPERATOR : %s\n",yytext);return MUL;}
\/               {fprintf(yyout,"ARITHEMATIC OPERATOR : %s\n",yytext);return DIV;}
-                {fprintf(yyout,"ARITHEMATIC OPERATOR : %s\n",yytext);return SUB;} 
\(               {fprintf(yyout,"PARANTHESIS : %s\n",yytext);return OPENPARANTHESIS;}
\)               {fprintf(yyout,"PARANTHESIS : %s\n",yytext);return CLOSEPARANTHESIS;}
\[               {fprintf(yyout,"SQUARE BRACKET : %s\n",yytext);return OPENSQUARE;}
\]               {fprintf(yyout,"SQUARE BRACKET : %s\n",yytext);return CLOSESQUARE;}
\+\+            {fprintf(yyout,"INCREMENT : %s\n",yytext);return INCREMENT;}
\<=              {fprintf(yyout,"LESS THAN EQUAL TO : %s\n",yytext);return LESSTHAN;}
,                {fprintf(yyout,"COMMA : %s\n",yytext);return COMMA;}
=                {fprintf(yyout,"ASSIGN : %s\n",yytext);return ASSIGN;}
;                {fprintf(yyout,"SEMI : %s\n",yytext);return SEMI;}
==               {fprintf(yyout,"RELATIONAL OPERATOR : %s\n",yytext);return EQUALS;}
\!=              {fprintf(yyout,"RELATIONAL OPERATOR : %s\n",yytext);return NOTEQUALS;}
\{                {fprintf(yyout,"BRACES : %s\n",yytext);return OPENBRACES;}
\}                {fprintf(yyout,"BRACES : %s\n",yytext);return CLOSEBRACES;}
[   \n\r]+             ;
.               {fprintf(yyout,"'ERROR' INVALID CHARACTER : %s\n",yytext);}
%%

int yywrap(void) {
    return 1;
}