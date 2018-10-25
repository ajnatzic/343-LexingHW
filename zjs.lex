%{
    #include <stdio.h>
%}
 
%%

END		{printf("END\n");return yytext[0];}	// This statement exits the interpreter
;		{printf("END_STATEMENT\n");}	// All commands should end with a semicolon
POINT 		{printf("POINT\n");}	// When we match the command to plot a point
LINE		{printf("LINE\n");}	// When we match the command to draw a line
CIRCLE 		{printf("CIRCLE\n");}	// When we match the command to draw a circle 
[0-9]+         { printf("INT\n"); }	// Matches an integer value
[\n\t ]         			; // Ignore these chars!
.		{printf("ERROR: Unknown character on line ");}	// Tells the user they messed up and on which line
%%
 
int main(int argc, char** argv){
  yylex();    // Start lexing!
  return 0;
}
