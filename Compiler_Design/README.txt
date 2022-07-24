Commands in the terminal for running the CUCU compiler:
bison -d cucu.y
flex cucu.l
gcc cucu.tab.c lex.yy.c -lfl -o cucu
./cucu Sample.cu
ASSUMPTIONS:
1. Arrays are not allowed as part of data type.
2. Accessing any array element like s[i] is not allowed in expression as arrays are not defined for CUCU language.
3. It only supports char *(space is must) and int (i.e. char**,char and char* etc. are not allowed)
4. Control and loop statements body must be enclosed in braces.
5. &,|,&&,||,! are not allowed as part of boolean expressions operators.
6. Only +,-,*,/,>,<,>=,<=,==,!=,=,() are allowed as part of expression in control statements.
7. Only +,-,*,/,=,==,!=,() are allowed as part of expression in arithmetic statements.
8. In Lexer.txt there will be an empty line for each \n character.
9. It is not checking for declaration before assignment i.e. A variable can be used without declaring it.
10. No Type Checking.
11. Only Identifiers and Numbers are allowed as a part of expressions(i.e. Floating point number etc. are not allowed.)
12. No Argument matching is done while func call(i.e. Any no. of arguments can be passed during func call either the function is declared for that type and number of arguments or not)
13. No check for function declaration during function call.
14. Single line comments starting with // in any part of line are also considered.
15. Multi line comments /*..*/ are also considered. 
16. Parser.txt is successfully parsing expression in infix order.  
TECHNICALITIES:
1. Sample.cu should be present in the same Directory.
2. Program should be compiled with gcc instead of g++.
3. Lexer.txt and Parser.txt are hardcoded.
4. Lexer is going to tokenize until parser demands i.e. if syntax error comes then both parser and lexer are going to terminate their execution.
SUBMITTED WORK:
I am submitting cucu.l and cucu.y along with README.txt Sample1.cu Sample2.cu in 2020CSB1100 Directory. 
Sample1.cu is a lexically and syntactically correct program and therefore Lexer and Parser are successfully tokenising and parsing it.
Sample2.cu is not including if statement's body in braces(Line 24 and Line 26).Therefore , the syntax error is coming at that time and Syntax Error is written in Parser.txt 
and both Parser and Lexer are terminating their execution after that.
