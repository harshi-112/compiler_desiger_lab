%{
#include <stdio.h>
#include <stdlib.h>

int COMMENT = 0;
%}

identifier [a-zA-Z][a-zA-Z0-9]*
keywords   int|float|char|double|while|for|struct|typedef|do|if|break|continue|void|switch|return|else|goto
%%
#.*                        { printf("\n%s is a preprocessor directive", yytext); }
{keywords}                 { printf("\n%s is a keyword", yytext); }

"/*"                      { COMMENT = 1; printf("\n%s is a COMMENT", yytext); }
"*/"                      { COMMENT = 0; printf("\n%s is the end of COMMENT", yytext); }
{identifier}               { if (!COMMENT) printf("\n%s is an IDENTIFIER", yytext); }
[0-9]+                    { if (!COMMENT) printf("\n%s is a NUMBER", yytext); }
\".*\"                    { if (!COMMENT) printf("\n%s is a STRING", yytext); }
"="                       { if (!COMMENT) printf("\n%s is an ASSIGNMENT OPERATOR", yytext); }
"<="                      { if (!COMMENT) printf("\n%s is a RELATIONAL OPERATOR", yytext); }
">="                      { if (!COMMENT) printf("\n%s is a RELATIONAL OPERATOR", yytext); }
"<"                       { if (!COMMENT) printf("\n%s is a RELATIONAL OPERATOR", yytext); }
"=="                      { if (!COMMENT) printf("\n%s is a RELATIONAL OPERATOR", yytext); }
">"                       { if (!COMMENT) printf("\n%s is a RELATIONAL OPERATOR", yytext); }
"("                       { if (!COMMENT) printf("\n%s is an OPEN PARENTHESIS", yytext); }
")"                       { if (!COMMENT) printf("\n%s is a CLOSE PARENTHESIS", yytext); }
","                       { if (!COMMENT) printf("\n%s is a COMMA", yytext); }
"+"                       { if (!COMMENT) printf("\n%s is an ADDITION OPERATOR", yytext); }
"-"                       { if (!COMMENT) printf("\n%s is a SUBTRACTION OPERATOR", yytext); }
"*"                       { if (!COMMENT) printf("\n%s is a MULTIPLICATION OPERATOR", yytext); }
"/"                       { if (!COMMENT) printf("\n%s is a DIVISION OPERATOR", yytext); }
";"                       { if (!COMMENT) printf("\n%s is a SEMICOLON", yytext); }
"{"                       { if (!COMMENT) printf("\n%s is an OPEN CURLY BRACE", yytext); }
"}"                       { if (!COMMENT) printf("\n%s is a CLOSE CURLY BRACE", yytext); }
%%
int main(int argc, char **argv) {
    FILE *file;
    if (argc < 2) {
        printf("Usage: %s <source file>\n", argv[0]);
        return 1;
    }

    file = fopen(argv[1], "r");
    if (!file) {
        printf("Could not open the file %s\n", argv[1]);
        return 1;
    }

    yyin = file;
    yylex();
    printf("\n");
    fclose(file); // Make sure to close the file
    return 0;
}

int yywrap() {
    return 1;
}
