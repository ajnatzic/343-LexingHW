%{
    #include <stdio.h>
%}
%option yylineno
%%

END	{printf("END\n");return yytext[0];}	// This statement exits the interpreter
;	{printf("END_STATEMENT\n");}	// All commands should end with a semicolon
POINT	{printf("POINT\n");}	// When we match the command to plot a point
LINE	{printf("LINE\n");}	// When we match the command to draw a line
CIRCLE	{printf("CIRCLE\n");}	// When we match the command to draw a circle
RECTANGLE	{printf("RECTANGLE\n");}	// When we match the command to draw a rectangle
SET_COLOR	{printf("SET_COLOR\n");}	// When we match the command to draw a rectangle 
[0-9]+	{printf("INT\n"); }	// Matches an integer value
[0-9]+\.[0-9]+	{printf("FLOAT\n");}	// Matches a floating-point value
[\n\t ]         			; // Ignore these chars!
.	{printf("ERROR: Unknown character '%s' on line %d\n", yytext,  yylineno);}	// Tells the user they messed up and on which line
%%
 
int main(int argc, char** argv){
  yylex();    // Start lexing!
  return 0;
}
