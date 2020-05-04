class SymbolTable{
  HashMap<String,String> symbols;
  
  SymbolTable(){
    symbols = new HashMap<String,String>();
  }
  
  void loadDefaultSymbols(){
    symbols.put("SP", "000000000000000");
    symbols.put("LCL", "000000000000001");
    symbols.put("ARG", "000000000000010");
    symbols.put("THIS", "000000000000011");
    symbols.put("THAT", "000000000000100");
    symbols.put("R0", "000000000000000");
    symbols.put("R1", "000000000000001");
    symbols.put("R2", "000000000000010");
    symbols.put("R3", "000000000000011");
    symbols.put("R4", "000000000000100");
    symbols.put("R5", "000000000000101");
    symbols.put("R6", "000000000000110");
    symbols.put("R7", "000000000000111");
    symbols.put("R8", "000000000001000");
    symbols.put("R9", "000000000001001");
    symbols.put("R10", "000000000001010");
    symbols.put("R11", "000000000001011");
    symbols.put("R12", "000000000001100");
    symbols.put("R13", "000000000001101");
    symbols.put("R14", "000000000001110");
    symbols.put("R15", "000000000001111");   
    symbols.put("SCREEN", "100000000000000");
    symbols.put("KBD", "110000000000000");
    println("loaded symbols");
  }
  
  void addEntry(String name, String memAdr){
    symbols.put(name, memAdr);
  }
  
  boolean contains(String symbolToCheck){
    println("is symbol here?" + symbols.containsKey(symbolToCheck));
    return(symbols.containsKey(symbolToCheck));   
  }
  
  String getAddress(String symbolToGet){ //If bugs remain after fixing code table issues, look to see if the reason this is failing is because it is recreated R0 for some reason.
    return(symbols.get(symbolToGet));
  }
}