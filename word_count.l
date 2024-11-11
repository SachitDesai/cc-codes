%{
    // Flex program to count occurrences of a specific word from the input file
    #include <stdio.h>
    #include <string.h>

    int word_count = 0;
    char target_word[100];
    extern FILE *yyin;
%}

// Define a rule to match any word
word [a-zA-Z]+

%% 
{word} {
    if (strcmp(yytext, target_word) == 0) {
        word_count++;
    }
}

.|\n ; // Ignore everything else

%% 
// Subroutines  
int yywrap(){
    return 1;
} 

int main(int argc, char *argv[]) {
    if (argc < 3) {
        fprintf(stderr, "Usage: %s <input_file> <word_to_count>\n", argv[0]);
        return 1;
    }

    // Set the target word from the command-line argument
    strcpy(target_word, argv[2]);

    // Open the input file
    FILE *fp = fopen(argv[1], "r");
    if (!fp) {
        perror("Failed to open file");
        return 1;
    }
    yyin = fp;

    // Run the lexer
    yylex();

    // Print the result
    printf("The word '%s' occurred %d times\n", target_word, word_count);

    fclose(fp);    
    return 0;
}
