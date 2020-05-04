//Assembler
Parser myParser;
//Code myCodes;
//SymbolTable mySymbols;

void setup(){
  size(500,500);
  myParser = new Parser();
  
//  myCodes = new Code();
//  myCodes.loadTables();
  
//  mySymbols = new SymbolTable();
//  mySymbols.loadDefaultSymbols();
}

void draw(){
  myParser.run(); 
}

//TODO next: Get tables to actually pre-load defaults properly.
//TODO then: reformat comments & such for readability
//TODO after: re-test to make sure everything still works.
//TODO later: include text file on how to use this - see proj 6 assignment page.