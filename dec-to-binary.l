%{ 
    //Global definitions
	#include<stdio.h> 
	extern FILE *yyin;
	int num, r, digit=0, count = 0, pcount = 0, i; 
	char a[50]; 
%} 
    //Character classes

DIGIT [0-9] 
%% 
    // Rules 

{DIGIT}+ { 
		num = atoi(yytext); 
		count = 0;  // Reset count for each new number

		// Convert decimal to binary
		while (num != 0) { 
			r = num % 2; 
			digit = '0' + r; 
			a[count++] = digit; 
			num = num / 2; 
		} 

		// Print binary digits in reverse order
		for (i = count - 1; i >= pcount; --i) 
			printf("%c", a[i]); 
		printf("\n");
		pcount = count;  // Update pcount to keep track of the current position
} 
		
%% 
 // Subroutines  

int yywrap(){
    return 1;
} 

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Usage: %s <input_file>\n", argv[0]);
        return 1;
    }
    FILE *fp = fopen(argv[1], "r");
    if (!fp) {
        perror("Error opening input file");
        return 1;
    }
    yyin = fp;
    yylex();
    fclose(fp);    
    return 0;
}
