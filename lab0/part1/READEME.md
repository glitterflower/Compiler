1.完整的编译过程
clang -ccc-print-phases main.c

2.预处理器
gcc main.c -E -o main.i

3.编译器
（1）词法分析
clang -E -Xclang -dump-tokens main.c > main.tokens 2>&1

（2）语法分析
clang -E -Xclang -ast-dump main.c > main.ast 2>&1

（3）语义分析

（4）中间代码生成
GCC控制流图
gcc -O0 -fdump-tree-cfg-graph main.c
dot -Tpng a-main.c.015t.cfg.dot -o cfg_O0.png

gcc -O2 -fdump-tree-cfg-graph main.c
dot -Tpng a-main.c.015t.cfg.dot -o cfg_O2.png

gcc -O0 -fdump-rtl-expand-graph main.c
dot -Tpng a-main.c.245r.expand.dot -o expand.png
gcc -O0 -fdump-rtl-final-graph main.c

LLVM IR
clang -S -emit-llvm main.c

（5）代码优化
llc -print-before-all -print-after-all main.ll > a.log 2>&1
ll 转换为 bc
llvm-as main.ll -o main.bc
优化
opt -S -O1 main.bc -o main_O1.ll
opt -S -O2 main.bc -o main_O2.ll
opt -S -O3 main.bc -o main_O3.ll

（6）代码生成   
gcc main.i -S -o main_x86.S
aarch64-linux-gnu-gcc main.i -S -o main_arm.S
llc main.ll -o main_llvm.S

4.汇编器
gcc main_x86.S -c -o main_x86.o
aarch64-linux-gnu-gcc main_arm.S -c -o main_arm.o
llc main.bc -filetype=obj -o main_llvm.o
反汇编
objdump -d main_x86.o

5.链接器/加载器
gcc main_x86.o -o main_x86
反汇编
objdump -d main_x86