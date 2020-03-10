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
	@incrementer //establish an incrementer/de-incrementer
	M=0
	@maxfillcompare //how do I assign this a value?
	M=24576
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
	@incrementer //add incrementer to SCREEN's mem add to get next mem add to adjust
	D=M
	@SCREEN	
	D=D+A
	@currentscreenaddress
	M=D
	A=M 
	M=-1
	@currentAcompare
	currentAcompare=D
	D=maxfillcompare-currentAcompare
	@END
	0;JLE
	@incrementer //increment incrementer
	M=M+1
	@SCREENONLOOP 
	0;JMP
(SCREENOFFLOOP) //Adapt everything from SCREENONLOOP for this.
	@KBD
	D=M
	@SCREENONLOOP // if keypressed, go to ScreenONloop
	D;JNE
	@incrementer
	D=M
	@SCREEN	//LOOP Through all the offs
	D=A-D
	@D
	M=0
	@incrementer //increment incrementer
	M=M-1
	@SCREENOFFLOOP
	0;JMP
(END) //may need a way to jump back from this to each loop. If keypressed, go to onloop, and it will just bounce you back here if full automatically. If notpressed, go to offloop, and it will just bounce you back here if empty automatically.
	@END
	0;JMP


