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
}

void draw(){
myParser.run(mySymbols, myCodes); 
}



//Don't forget to include file on how to use it - see proj 6 assignment