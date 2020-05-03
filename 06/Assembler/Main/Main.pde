//Assembler
Parser myParser;
Code myCodes;
SymbolTable mySymbols;

void setup(){
  size(500,500);
  myParser = new Parser();
  myCodes = new Code();
  myCodes.loadTables();
  mySymbols = new SymbolTable();
  mySymbols.loadDefaultSymbols();
  myParser.phase1(mySymbols);
}

void draw(){
  myParser.phase2(myCodes); 
}
//TODO: Then, work on Phase 2





//potentially call phase2 here.

//Don't forget to include file on how to use it - see proj 6 assignment