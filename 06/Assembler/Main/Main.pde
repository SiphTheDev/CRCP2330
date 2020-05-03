//Assembler
Parser myParser;
Code myCodes;

void setup(){
  size(500,500);
  myParser = new Parser();
  myCodes = new Code();
  myCodes.loadTables();
}

void draw(){
  myParser.run(myCodes);
}
//This should just be a super minimalistic Main file, like in the previous program

//potentially call phase2 here.


//Don't forget to include file on how to use it - see proj 6 assignment