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
//TODO: Next, have results save to a file rather than printlining.
//TODO: Then, work on Phase 2





//potentially call phase2 here.

//Don't forget to include file on how to use it - see proj 6 assignment