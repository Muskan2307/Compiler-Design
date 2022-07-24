%{
#include <stdio.h>
#include <string.h>
#define YYSTYPE char*
#include "cucu.tab.h"
%}
%%
"/"[*]([^*]|([*][^/]))*[*]+"/" {fprintf(yyout,"COMMENT : %s\n",yytext);}
"//"[^\n]* {fprintf(yyout,"COMMENT : %s\n",yytext);}
(^int|int) {fprintf(yyout,"TYPE : %s\n",yytext);return TYPE_INT;}
"char *" {fprintf(yyout,"TYPE : %s\n",yytext);return TYPE_CHARPOINTER;}
(^return|return) {fprintf(yyout,"RETURN_KEYWORD : %s\n",yytext);return RETURN_KEYWORD;}
(^if|if) {fprintf(yyout,"IF_KEYWORD : %s\n",yytext);return IF_KEYWORD;}
(^else|else) {fprintf(yyout,"ELSE_KEYWORD : %s\n",yytext);return ELSE_KEYWORD;}
(^while|while) {fprintf(yyout,"WHILE_KEYWORD : %s\n",yytext);return WHILE_KEYWORD;}
[A-Za-z]+[A-Za-z0-9_]* {fprintf(yyout,"ID : %s\n",yytext);yylval = strdup(yytext);return ID;}
(\;$|\;) {fprintf(yyout,"SEMI : %s\n",yytext);return SEMI;}
(^\(|\() {fprintf(yyout,"OPENING_PAREN : %s\n",yytext);return OPENING_PAREN;}
")" {fprintf(yyout,"CLOSING_PAREN : %s\n",yytext);return CLOSING_PAREN;}
"," {fprintf(yyout,"COMMA : %s\n",yytext);return COMMA;}
(^\{|\{) {fprintf(yyout,"OPEN_BRACE : %s\n",yytext);return OPEN_BRACE;}
"}" {fprintf(yyout,"CLOSE_BRACE : %s\n",yytext);return CLOSE_BRACE;}
(^\[|\[) {fprintf(yyout,"OPEN_SQUAREBRACKET : %s\n",yytext);return OPEN_SQUAREBRACKET;}
"]" {fprintf(yyout,"CLOSE_SQUAREBRACKET : %s\n",yytext);return CLOSE_SQUAREBRACKET;}
[0-9]+ {fprintf(yyout,"CONST : %s\n",yytext);yylval = yytext;return NUM;}
"+" {fprintf(yyout,"PLUS : %s\n",yytext);return PLUS;}
">=" {fprintf(yyout,"GREATERTHANEQUALTO : %s\n",yytext);return GREATEREQUAL;}
">" {fprintf(yyout,"GREATERTHAN : %s\n",yytext);return GREATER;}
"<=" {fprintf(yyout,"LESSERTHANEQUALTO : %s\n",yytext);return LESSEREQUAL;}
"<" {fprintf(yyout,"LESSERTHAN : %s\n",yytext);return LESSER;}
"-" {fprintf(yyout,"SUB : %s\n",yytext);return SUB;}
"*" {fprintf(yyout,"MUL : %s\n",yytext);return MUL;}
"/" {fprintf(yyout,"DIV : %s\n",yytext);return DIV;}
"=" {fprintf(yyout,"ASSIGN : %s\n",yytext);return ASSIGN;}
"!=" {fprintf(yyout,"NOTEQ : %s\n",yytext);return NOTEQ;}
"==" {fprintf(yyout,"EQUAL : %s\n",yytext);return EQUAL;}
[ \t\n]+ ;
[\S]+ {fprintf(yyout,"UNRECOGNIZED INPUT! %s \n",yytext);}
%%