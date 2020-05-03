class Parser {
  BufferedReader firstLoopReader;
  BufferedReader fileReader;
  PrintWriter output;
  String firstLoopCurrentLine;
  String currentLine;
  String currentBinary;
  String[] fileForSecondLoop;
  int memAdr = 0;

  Parser() {
    firstLoopReader = createReader("PongL.asm");
    fileReader = createReader("PongL.asm");
    output = createWriter("PongL.hack");
  }

  void phase1(SymbolTable symbolTable){
    while(firstLoopCurrentLine != null){
    try {
        firstLoopCurrentLine = firstLoopReader.readLine();
      }
      catch (IOException e) {
        e.printStackTrace();
        firstLoopCurrentLine = null;
      }
      if(firstLoopCurrentLine != null){
        int cmdType = commandType(currentLine);
        if(cmdType == 0 || cmdType == 1){ //if A or C cmd
          memAdr ++;
        }
        else if(cmdType == 3){  
              //consider moving this to the symbol method later.
          String label = firstLoopCurrentLine.substring(1,firstLoopCurrentLine.length()-1);
          String binAdr = binary(memAdr+1, 16);
          symbolTable.addEntry(label, binAdr);
        }        
      }
    }
  }

  void phase2(Code codeTables) {
      try {
        currentLine = fileReader.readLine();
      }
      catch (IOException e) {
        e.printStackTrace();
        currentLine = null;
      }
      if (currentLine == null) {
        output.flush();
        output.close();
        noLoop();                    //BE WARY - this might prevent phase 2 by accident.
        println("Done!"); 
      } 
      else {
        int cmdTyp = commandType(currentLine);
        if(cmdTyp == 1) {output.println("0" + symbol(currentLine));} 
        else if(cmdTyp == 0){output.println("111" + comp(currentLine, codeTables) + dest(currentLine, codeTables) + jump(currentLine, codeTables));}
      }
  }

  int commandType(String line) {    
    if(line.length() == 0){ return 3;}   //skip empty lines
    
    char cType = line.charAt(0);
  
    if (cType == '@') { return 1; }      //A Commands    
    else if(cType == '/' | cType == ' '){return 3;}     //ignore comments & whitespace lines
    else if(cType == '('){return 2;}    //Labels
    else {return 0;}  //C Commands            
  }

  String symbol(String line,){// int cmdTyp) {
    //later, add an if statement to account for labels.
    String value = line.substring(1, line.length());
    
    Integer num = parseInt(value);
    return binary(num,15);
  }

 String comp(String line, Code codeTables) {
   int indexOfEq = line.indexOf("=");
   int indexOfSc = line.indexOf(";");
   String compBits;
   
    if(indexOfEq == -1){
      compBits = line.substring(0,indexOfSc);
    }
    else if(indexOfSc == -1){
      compBits = line.substring(indexOfEq+1, line.length());
    }    
    else{
      compBits = line.substring(indexOfEq+1, indexOfSc);
    }
    return codeTables.comp(compBits);
    
  }
  
  String dest(String line, Code codeTables) {
    int indexOfEq = line.indexOf("=");
    String destBits;
    
    if(indexOfEq == -1){
      return "000";
    }
    else{
      destBits = line.substring(0,indexOfEq);
    }
    return codeTables.dest(destBits);
  }

  String jump(String line, Code codeTables) {
    int indexOfSc = line.indexOf(";");
    String jumpBits;
    
    if(indexOfSc == -1){
      return "000";
    }
    else{
      jumpBits = line.substring(indexOfSc+1, line.length());
    }
    return codeTables.jump(jumpBits);
  }




  //do the tests & stuff on it
  //if it is a label, add it to symbolsTable (do this later).
  //if it isn't a label, add it to the stringArray
  //get next line

  //second loop, go through and actually translate the thing, symbols & all.
}