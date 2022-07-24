%{
#include <stdio.h>
#include <string.h>
#define YYSTYPE char*
extern int yylex();
extern int yyparse();
FILE * yyin;
FILE * yyout;
FILE * yyout1;
void yyerror(char* s) {
	fprintf(yyout1,"\nSnytax Error!\n");
}
int yywrap()
{
return 1;
}
int main(int argc, char *argv[])
{
    if(argc!=2)
    {
        printf("usage: cucu Sample.cu");
        return 0;
    }
    FILE * p = fopen(argv[1],"r");
    yyin = p;
    yyout = fopen("Lexer.txt","w");
    yyout1 = fopen("Parser.txt","w");
    yyparse();
    yylex();
}
%}
%token GREATER GREATEREQUAL LESSER LESSEREQUAL TYPE_INT TYPE_CHARPOINTER RETURN_KEYWORD IF_KEYWORD ELSE_KEYWORD WHILE_KEYWORD ID SEMI OPENING_PAREN CLOSING_PAREN COMMA OPEN_BRACE CLOSE_BRACE OPEN_SQUAREBRACKET CLOSE_SQUAREBRACKET NUM PLUS SUB MUL DIV ASSIGN NOTEQ EQUAL

%%
program : var_decl program 
        | func_decl {fprintf(yyout1," <- FUNC-DECLARATION \n");} program 
        | func_def program 
        |   
var_decl : type iden ASSIGN {fprintf(yyout1," = ");} expr SEMI {fprintf(yyout1," <- VAR-DECLARATION (Declaration and Initialisation) \n");}
          | iden ASSIGN {fprintf(yyout1," = ");} expr SEMI {fprintf(yyout1," <- VAR-DECLARATION (Assignment only) \n");}
          | type iden SEMI {fprintf(yyout1," <- VAR-DECLARATION (Declaration only) \n");}          
func_decl : type iden OPENING_PAREN func_args CLOSING_PAREN SEMI
func_def :  type iden OPENING_PAREN func_args CLOSING_PAREN func_body   
func_args : COMMA type iden func_args | type iden func_args |  {fprintf(yyout1," <-FORMAL-FUNC-ARGUMENTS \n");} 
func_body : {fprintf(yyout1,"FUNC-DEF -> \n");} {fprintf(yyout1,"FUNC-BODY -> \n");} OPEN_BRACE statementblock CLOSE_BRACE
statementblock : statement statementblock |
statement : type iden ASSIGN {fprintf(yyout1," = ");} expr SEMI {fprintf(yyout1," <- ASSIGNMENT STATEMENT \n");}
          | iden ASSIGN {fprintf(yyout1," = ");} expr SEMI {fprintf(yyout1," <- ASSIGNMENT STATEMENT \n");}
          | type iden SEMI {fprintf(yyout1," <- ASSIGNMENT STATEMENT \n");}
          | RETURN_KEYWORD expr SEMI {fprintf(yyout1," <- RETURN STATEMENT\n");} 
          | IF_KEYWORD OPENING_PAREN bool_expr CLOSING_PAREN OPEN_BRACE statementblock CLOSE_BRACE ELSE_KEYWORD {fprintf(yyout1,"ELSE STATEMENTS- \n");} OPEN_BRACE statementblock CLOSE_BRACE {fprintf(yyout1," <- END IF \n");} 
          | IF_KEYWORD OPENING_PAREN bool_expr CLOSING_PAREN OPEN_BRACE statementblock CLOSE_BRACE {fprintf(yyout1," <- END IF \n");} 
          | WHILE_KEYWORD {fprintf(yyout1,"WHILE STATEMENT -> \n");} OPENING_PAREN bool_expr CLOSING_PAREN OPEN_BRACE statementblock CLOSE_BRACE 
          | expr SEMI {fprintf(yyout1,"<- EXPRESSION STATEMENT \n");}
          | iden OPENING_PAREN func_args_pass CLOSING_PAREN SEMI   {fprintf(yyout1," <- FUNCTION CALL \n");}
func_args_pass : COMMA expr func_args_pass | expr func_args_pass |   {fprintf(yyout1," <- ACTUAL-FUNC-ARGUMENTS\n");}
type : TYPE_INT {fprintf(yyout1,"TYPE NAME- int ");} | TYPE_CHARPOINTER {fprintf(yyout1,"TYPE NAME- char * ");}     
bool_expr : expr {fprintf(yyout1," <- BOOLEAN EXPRESSION \n");}
          | expr EQUAL {fprintf(yyout1,"OPERATOR -> == ");} expr {fprintf(yyout1," <- BOOLEAN EXPRESSION \n");}
          | expr NOTEQ {fprintf(yyout1,"OPERATOR -> != ");} expr {fprintf(yyout1," <- BOOLEAN EXPRESSION \n");}
          | expr GREATER {fprintf(yyout1,"OPERATOR -> > ");} expr {fprintf(yyout1," <- BOOLEAN EXPRESSION \n");}
          | expr LESSER {fprintf(yyout1,"OPERATOR -> < ");} expr {fprintf(yyout1," <- BOOLEAN EXPRESSION \n");}
          | expr GREATEREQUAL {fprintf(yyout1,"OPERATOR -> >= ");} expr {fprintf(yyout1," <- BOOLEAN EXPRESSION \n");}
          | expr LESSEREQUAL {fprintf(yyout1,"OPERATOR -> <= ");} expr {fprintf(yyout1," <- BOOLEAN EXPRESSION \n");}
          |                                      {fprintf(yyout1," <- BOOLEAN EXPRESSION \n");}
expr : term  
term : term ASSIGN {fprintf(yyout1,"OPERATOR -> = ");}term
     | term EQUAL {fprintf(yyout1,"OPERATOR -> == ");} term
     | term NOTEQ {fprintf(yyout1,"OPERATOR -> != ");}term
     | term PLUS {fprintf(yyout1,"OPERATOR -> + ");} term
     | term SUB {fprintf(yyout1,"OPERATOR -> - ");}term
     | term MUL {fprintf(yyout1,"OPERATOR -> * ");}term
     | term DIV {fprintf(yyout1,"OPERATOR -> / ");}term
     | SUB NUM {fprintf(yyout1,"CONST -> - %s ",yylval);}
     | OPENING_PAREN {fprintf(yyout1," ( ");} term CLOSING_PAREN {fprintf(yyout1," ) ");}
     | NUM {fprintf(yyout1,"CONST -> %s ",yylval);}
     | iden 
iden : ID {fprintf(yyout1,"VAR -> %s ",yylval);}
%%
