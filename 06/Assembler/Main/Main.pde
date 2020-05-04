//Assembler
Parser myParser;
//Code myCodes;
//SymbolTable mySymbols;

void setup(){
  size(500,500);
  myParser = new Parser("Pong");
}

void draw(){
  myParser.run(); 
}

//TODO after: re-test to make sure everything still works.
//TODO later: include text file on how to use this - see proj 6 assignment page.