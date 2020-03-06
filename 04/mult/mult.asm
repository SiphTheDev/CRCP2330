// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.
	@R15
	M=1
	@sum
	M=0
(LOOP)
	@R15
	D=M
	@R1
	D=D-M
	@END
	D;JGT
	@R0
	D=M
	@sum
	M=D+M
	@R15
	M=M+1
	@sum
	D=M
	@R2
	M=D
	@LOOP
	0;JMP //Goto Loop
(END)
	@END
	0;JMP //Infini-loop