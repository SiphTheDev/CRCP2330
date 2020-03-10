// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.
	@R15 //establish an incrementer/de-incrementer
	M=0
(STARTLOOP)
	@KBD
	D=M
	@SCREENONLOOP // if keypressed, go to ScreenONloop
	D;JNE
	@STARTLOOP
	0;JMP //restart startloop
(SCREENONLOOP)
	@KBD
	D=M
	@SCREENOFFLOOP // if key not pressed, go to ScreenOFFloop
	D;JEQ
	//@R15 //Go to the correct address after screen to deal with each set of pixels
	//D=M
	@SCREEN	
	//D=D+M
	//@D
	M=-1
	@R15 //increment incrementer
	M=M+1
	@SCREENONLOOP //BUG THIS IS INCREMENTING MEM ADD 14
	0;JMP
(SCREENOFFLOOP)
	@KBD
	D=M
	@SCREENONLOOP // if keypressed, go to ScreenONloop
	D;JNE
	//@R15
	//D=M
	@SCREEN	//LOOP Through all the offs
	//D=D-M
	//@D
	M=0
	@R15 //increment incrementer
	M=M-1
	@SCREENOFFLOOP
	0;JMP


