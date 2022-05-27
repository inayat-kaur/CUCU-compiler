# CUCU Compiler

Compilation and running:  

flex cucu.l  
bison -d cucu.y  
g++ cucu.tab.c lex.yy.c -lfl -o cucu (In case it shows error, use gcc instead)  
./cucu Sample1.cu (for Sample1.cu file which contains correct code)  
./cucu Sample2.cu (for Sample1.cu file which contains code with error)  
