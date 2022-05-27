%{
    #include <stdio.h>
    #include <string.h> 
    #define YYSTYPE char*
    int yylex(void);
    void yyerror(char *s);
%}
%token NUM PLUS MUL DIV SUB STRING FOR INCREMENT LESSTHAN OPENPARANTHESIS CLOSEPARANTHESIS OPENSQUARE CLOSESQUARE OPENBRACES CLOSEBRACES ASSIGN EQUALS NOTEQUALS TYPE IF ELSE WHILE RETURN ID SEMI COMMA 
%%
program:
    program vardec  {fprintf(stdout," Variable declaration\n");}
    |
    program funcdec {fprintf(stdout," Function declaration\n");}
    |
    program funcdef {fprintf(stdout," Function definition\n");}
    |
    vardec      {fprintf(stdout," Variable declaration\n");}
    |
    funcdec     {fprintf(stdout," Function declaration\n");}
    |
    funcdef     {fprintf(stdout," Function definition\n");}
    ;
vardec:
    TYPE ID SEMI        {fprintf(stdout,"Global Variable: %s ",$2);}
    ;
funcdec:
    TYPE ID OPENPARANTHESIS funcargs CLOSEPARANTHESIS SEMI  {fprintf(stdout,"Identifier:%s ",$2);}
    |
    TYPE ID OPENPARANTHESIS CLOSEPARANTHESIS SEMI   {fprintf(stdout,"Identifier: %s ",$2);}
    ;
funcargs:
    funcargs COMMA TYPE ID  {fprintf(stdout,"Argument:%s ",$4);}
    |
    TYPE ID {fprintf(stdout,"Argument:%s ",$2);}
    ;
funcdef:
    TYPE ID OPENPARANTHESIS funcargs CLOSEPARANTHESIS OPENBRACES stmts CLOSEBRACES  {fprintf(stdout,"Identifier: %s ",$2);}
    |
    TYPE ID OPENPARANTHESIS CLOSEPARANTHESIS OPENBRACES stmts CLOSEBRACES       {fprintf(stdout,"Identifier: %s ",$2);}
    |
    ID OPENPARANTHESIS CLOSEPARANTHESIS OPENBRACES stmts CLOSEBRACES       {fprintf(stdout,"Identifier: %s ",$1);}
    |
    ID OPENPARANTHESIS funcargs CLOSEPARANTHESIS OPENBRACES stmts CLOSEBRACES  {fprintf(stdout,"Identifier: %s ",$1);}
    ;
stmts:
    stmts stmt
    |
    stmt
    ;
stmt:
    assignment  {fprintf(stdout,"  Assignment Statement\n");}
    |
    returnstmt  {fprintf(stdout,"  Return Statement\n");}
    |
    ifstmt  {fprintf(stdout,"  If-Else Statement\n");}
    |
    whilestmt   {fprintf(stdout,"  While Statement\n");}
    |
    funccall    {fprintf(stdout,"  Function Call\n");}
    |
    vardec2     {fprintf(stdout,"  Local Variable Declaration\n");}
    |
    forstmt     {fprintf(stdout,"  For Statement\n");}
    |
    incrementstmt {fprintf(stdout,"  Increment Statement\n");}
    ;
assignment:
    ID ASSIGN expr SEMI     {fprintf(stdout," = %s ",$1);}
    |
    TYPE ID ASSIGN expr SEMI    {fprintf(stdout," = %s ",$2);}
    ;
returnstmt:
    RETURN expr SEMI 
    ;
ifstmt:
    IF OPENPARANTHESIS boolexpr CLOSEPARANTHESIS OPENBRACES stmts CLOSEBRACES ELSE OPENBRACES stmts CLOSEBRACES
    ;
whilestmt:
    WHILE OPENPARANTHESIS boolexpr CLOSEPARANTHESIS OPENBRACES stmts CLOSEBRACES
    ;
forstmt:
    FOR OPENPARANTHESIS vardec2 SEMI boolexpr SEMI incrementstmt CLOSEPARANTHESIS OPENBRACES stmts CLOSEBRACES
    ;
funccall:
    TYPE ID ASSIGN ID OPENPARANTHESIS funcargs2 CLOSEPARANTHESIS SEMI   {fprintf(stdout,"Identifier: %s ",$2);}
    |
    ID ASSIGN ID OPENPARANTHESIS funcargs2 CLOSEPARANTHESIS SEMI   {fprintf(stdout,"Identifier: %s ",$2);}
;
incrementstmt:
    ID INCREMENT SEMI
;
vardec2:
    TYPE ID ASSIGN expr COMMA expr SEMI {fprintf(stdout,"Local Variable: %s %s",$4 $6);}
;
funcargs2:
    expr COMMA funcargs2 {fprintf(stdout,"Argument  ");}
    |
    expr    {fprintf(stdout,"Argument  ");}
    |
    STRING COMMA funcargs2  {fprintf(stdout,"Argument  ");}
    |
    STRING  {fprintf(stdout,"Argument  ");}
;
boolexpr:
    expr EQUALS expr  {fprintf(stdout,"Operator:== ");}
    |
    expr NOTEQUALS expr  {fprintf(stdout,"Operator:!= ");}
    |
    expr LESSTHAN expr  {fprintf(stdout,"Operator:!= ");}
    ;
expr:
expr PLUS term      {fprintf(stdout,"Operator:+ ");} 
|
expr SUB term       {fprintf(stdout,"Operator:- ");}
|
term                
;
term:
term MUL factor     {fprintf(stdout,"Operator:* ");}
|
term DIV factor     {fprintf(stdout,"Operator:/ ");}
|
factor              
;
factor:
OPENPARANTHESIS expr CLOSEPARANTHESIS     
|
NUM          {fprintf(stdout,"Constant:%s ",$1);}  
|
ID       {fprintf(stdout,"Variable:%s ",$1);}
;
%%

void yyerror(char *s) {
    fprintf(stdout,"%s \n", s);
}

int main(int argc, char * argv[])
{
    extern FILE *yyin, *yyout, *stdout;
    yyin=fopen(argv[1],"r");
    yyout=fopen("lexer.txt","w");
    stdout=fopen("parser.txt","w");
    yyparse();
    return 0;
}