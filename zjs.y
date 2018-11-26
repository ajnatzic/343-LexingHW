%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "zoomjoystrong.h"
	int  yyerror(const char* err);
	int yylex();
	extern char* yytext;
%}
/**
* specifies what types of values can be used for a specific token
**/
%union	{
	int intVal;
	float floatVal;
}


%token END
%token END_STATEMENT
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token <intVal>  INT
%token <floatVal> FLOAT
%token ERROR



%%

/**
* this defines the grammar of our language. Only proper statements will be accepted according to rules below
**/
program: statement_list end;
       ;

statement_list: statement
	      | statement statement_list
	;

statement: line
	 | point
	 | circle
	 | rectangle
	 | set_color 
	 ;

/**
* definition of a line, requires 2 pairs of x and y values to make a valid line
**/

line: LINE INT INT INT INT END_STATEMENT
{
  if($2 >= 0 && $2 <= WIDTH &&  $3 >= 0 && $3 <= HEIGHT) {
    line($2,$3,$4,$5);
  } else {
    printf("ERROR: Points must be between 0 and %d for width and 0 and %d for height", WIDTH, HEIGHT);
  }
};

/**
* definition of a point, requires a pair of x and y values to make a valid point
**/
point: POINT INT INT END_STATEMENT
{
  if ($2 >= 0 && $2 <= WIDTH && $3 >= 0 && $3 <= HEIGHT) {
    point($2, $3);
  } else {
    printf("ERROR: Points must be between 0 and %d for width and 0 and %d for height\n", WIDTH, HEIGHT);
  }
};

/**
* definition of a circle, requires a pair of x and y values for the center point, 
* then a value for the length of the radius
**/
circle: CIRCLE INT INT INT END_STATEMENT
{
  if($2 >= 0 && $2 <= WIDTH && $3 >= 0 && $3 <= HEIGHT && $4 >= 0){
    circle($2,$3,$4);
  } else {
    printf("ERROR: Points must be between 0 and %d for width and 0 and %d for height and positive for radius\n", WIDTH, HEIGHT);
  }
};

/**
* definition of a rectangle, requires a pair of x and y values, width and height
**/
rectangle: RECTANGLE INT INT INT INT END_STATEMENT
{
  if ($2 >= 0 && $2 <= WIDTH && $3 >= 0 && $3 <= HEIGHT) {
    rectangle($2, $3, $4, $5);
  } else {
    printf("ERROR: Points must be between 0 and %d for width and 0 and %d for height\n", WIDTH, HEIGHT);
  }
};

/**
* definition of set_color, requires 3 integers corresponding to an RGB code
**/
set_color: SET_COLOR INT INT INT END_STATEMENT
{
  if ($2 >= 0 && $2 <= 255 && $3 >= 0 && $3 <= 255 && $4 >= 0 && $4 <= 255) {
    set_color($2, $3, $4);
  } else {
    printf("ERROR: RGB Values must be betweem 0 - 255\n");
  }
};

/**
* ends the program when END token is emitted
**/
end: END END_STATEMENT
{
  finish();
  return 0;
};
%%

extern FILE* yyin;

int main(int argc, char** argv){
	setup();
	yyin = fopen(argv[1], "r");
	yyparse();	// start parsing
	return 0;
}
int yyerror(const char* err){
	printf("%s\n", err);
	return 1;
}
