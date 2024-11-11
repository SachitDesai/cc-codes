%{
#include<stdio.h>
int words = 0;
%}

// Match words that start and end with "A" or "a"
word_with_a [Aa][A-Za-z]*[Aa]

%%

{word_with_a} { words++; }
[^ \t\n]+     // Match any other sequence but ignore it for counting

%%

int main(int argc, char* argv[]) {
    if (argc != 2) {
        printf("Usage: %s <input_file>\n", argv[0]);
        return 1;
    }
    FILE* input_file = fopen(argv[1], "r");
    if (!input_file) {
        perror("Error opening input file");
        return 1;
    }
    yyin = input_file;
    yylex();
    fclose(input_file);
    printf("Words starting and ending with 'A': %d\n", words);
    return 0;
}

int yywrap() {
    return 1;
}
