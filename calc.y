%{
    #include<stdio.h>
    int yylex(void);
    void yyerror(char *);
%}

%token INTEGER

%%
program:
        program expr '\n'   {printf("%d\n",$2);}
        |
        ;

statement:
        expr                { printf("%d\n", $1); }
        | VARIABLE '=' expr { sym[$1] = $3; }
        ;

expr:
        INTEGER             {$$=$1;}
        | expr '+' expr     {$$=$1+$3;}
        | expr '-' expr     {$$=$1-$3;}
        | expr '*' expr     {$$=$1*$3;}
        | expr '/' expr     {$$=$1/$3;}
        | '(' expr ')'      {$$=$2;}
        ;

%%

void yyerror(char *s){
    fprintf(stderr, "%s\n", s);
    return 0;
}

int main (void){
    yparse();
    return 0;
}

