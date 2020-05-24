%{
  #include "grammar.tab.h"
  char *remove_marks(char *str);
%}


%option noyywrap

DIGITS [0-9]
ALPHABET [a-zA-Z]
CHARACTERTOKENS [\+\-\*\/\(\)]
GIVEVALUE [:]
COMMA [,]
WHITESPACE [ ]
DOT [.]
AT [@]


%%
[ \t]*       /* whitespace skip */

\n          return '\n';

{GIVEVALUE}                 printf("LOOKAHEAD: GIVEVALUE: ':' \n"); return *yytext;
{COMMA}                     printf("LOOKAHEAD: ANOTHER ITEM: ',' \n"); return *yytext;
\"Name\"                    yylval.a = strdup(yytext); printf("LOOKAHEAD: NAME VARIABLE: %s\n", yylval.a); return NAME;
\"Address\"                 yylval.a = strdup(yytext); printf("LOOKAHEAD: ADDRESS VARIABLE: %s\n", yylval.a); return ADDRESS;
\"Email\"                   yylval.a = strdup(yytext); printf("LOOKAHEAD: EMAIL VARIABLE: %s\n", yylval.a); return EMAIL;
\"Phone\"                   yylval.a = strdup(yytext); printf("LOOKAHEAD: PHONE VARIABLE: %s\n", yylval.a); return PHONE;
\"Company\"                 yylval.a = strdup(yytext); printf("LOOKAHEAD: Company VARIABLE: %s\n", yylval.a); return COMPANY;
\"CompanyAddress\"          yylval.a = strdup(yytext); printf("LOOKAHEAD: CompanyAddress VARIABLE: %s\n", yylval.a); return COMPANY_ADDRESS;
\"CompanyPhone\"            yylval.a = strdup(yytext); printf("LOOKAHEAD: CompanyPhone VARIABLE: %s\n", yylval.a); return COMPANY_PHONE;
\"CompanyEmail\"            yylval.a = strdup(yytext); printf("LOOKAHEAD: CompanyEmail VARIABLE: %s\n", yylval.a); return COMPANY_EMAIL;
\"CompanyPost\"             yylval.a = strdup(yytext); printf("LOOKAHEAD: CompanyPost VARIABLE: %s\n", yylval.a); return COMPANY_POST;
\[                          return ARRAY_BEGIN;
\]                          return ARRAY_END;
\{                          return OBJECT_BEGIN;
\}                          return OBJECT_END;


\"({ALPHABET}|{WHITESPACE}|{DOT})*\"                    yylval.a = remove_marks(yytext); printf("LOOKAHEAD: NAME STORE VARIABLE: %s\n", yylval.a); return NAME_VALUE;
\"({DIGITS}|{CHARACTERTOKENS}|\(|\))*\"                 yylval.a = remove_marks(yytext); printf("LOOKAHEAD: PHONE STORE VARIABLE: %s\n", yylval.a); return PHONE_VALUE;
\"({ALPHABET}|{WHITESPACE}|{COMMA}|{DOT}|{DIGITS})*\"   yylval.a = remove_marks(yytext); printf("LOOKAHEAD: STORE ADDRESS VARIABLE: %s\n", yylval.a); return ADDRESS_VALUE;
\"({ALPHABET}|{DIGITS}|{DOT}|{AT})*\"                   yylval.a = remove_marks(yytext); printf("LOOKAHEAD: EMAIL STORE VARIABLE: %s\n", yylval.a); return EMAIL_VALUE;



%%
char *remove_marks(char *str)
{
    int len = strlen(str)-1;
    char *clone = (char *)malloc(sizeof(char)*(len));
    int i;
    for (i=0; i<len-1; i++)
    {
      clone[i] = str[i+1];
    }

    return clone;
}
