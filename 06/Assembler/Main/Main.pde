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

//TODO next: tweak symbol method in Parser to deal with variable symbols in A commands. - only have to check if first char is a digit. if it isn't, then it is a var nam.
//TODO then: reformat comments & such for readability
//TODO after: re-test to make sure everything still works.
//TODO later: include text file on how to use this - see proj 6 assignment page.