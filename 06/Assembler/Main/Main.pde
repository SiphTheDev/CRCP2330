//Assembler
Parser myParser;

void setup(){
  size(500,500);
  myParser = new Parser();
}

void draw(){
  myParser.run();
}
//This should just be a super minimalistic Main file, like in the previous program

//potentially call phase2 here.


//Don't forget to include file on how to use it - see proj 6 assignment