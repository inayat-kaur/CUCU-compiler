Inayat Kaur
2020csb1088
Lab-8

Compilation and running:
flex cucu.l
bison -d cucu.y
g++ cucu.tab.c lex.yy.c -lfl -o cucu    (In case it shows error, use gcc instead)
./cucu Sample1.cu (for Sample1.cu file which contains correct code)
./cucu Sample2.cu (for Sample1.cu file which contains code with error)

ASSUMPTIONS:
1. Variable declaration is only Global as Local not asked for in assignment.
2. Function returns either int or char * , void function is not allowed.
3. Nested if-else Statements are not allowed.
4. Only a boolean expression containing == and != is part of if condition to be checked.
5. Comments are only within /**/ and they are ignored.