%{
#include <stdio.h>
#include <string.h>

void yyerror(const char *s);
%}

%%

[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.(com|in|net)  {
    printf("Valid email: %s\n", yytext);
}

.+  {
    printf("Invalid email: %s\n", yytext);
}

\n   { /* Ignore new lines */ }

%%

// Main function
int main(void) {
    printf("Enter email addresses (Ctrl+D to end):\n");
    yylex(); // Start the lexer
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}