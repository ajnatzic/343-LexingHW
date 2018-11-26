%{
    #include <stdio.h>
    #include "zjs.tab.h" // Must be included so that the lexer will return correct tokens to parser
%}
%option yylineno
%option noyywrap
%%

end	{return END;}	// This statement exits the interpreter
;	{return END_STATEMENT;}	// All commands should end with a semicolon
point	{return POINT;}	// When we match the command to plot a point
line	{return LINE;}	// When we match the command to draw a line
circle	{return CIRCLE;}	// When we match the command to draw a circle
rectangle	{return RECTANGLE;}	// When we match the command to draw a rectangle
set_color	{return SET_COLOR;}	// When we match the command to draw a rectangle 
[0-9]+		{yylval.intVal = atoi(yytext); return INT;}	// Matches an integer value
[0-9]+\.[0-9]+	{yylval.floatVal = atof(yytext);  return FLOAT;}	// Matches a floating-point value
[\n\t ]         			; // Ignore these chars!
.	{printf("ERROR: Unknown character '%s' on line %d\n", yytext,  yylineno);}	// Tells the user they messed up and on which line
%%
 
