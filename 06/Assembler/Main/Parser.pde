class Parser {
  BufferedReader fileReader;
  PrintWriter output;
  String currentLine;
  String currentBinary;
  String[] fileForSecondLoop;
  //int i = 0;

  Parser() {
    fileReader = createReader("PongL.asm");
    output = createWriter("PongL.hack");
  }

  void phase1(SymbolTable symbolTable){
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
        else if(cmdTyp == 0){output.println("111" + comp(currentLine, codeTables) + dest(currentLine, codeTables) + jump(currentLine, codeTables));}    //TODO NEXT: Have this output into a file.
      }
  }

  int commandType(String line) {    
    if(line.length() == 0){ return 3;}   //skip empty lines
    
    char cType = line.charAt(0);
  
    if (cType == '@') { return 1; }      //A Commands    
    else if(cType == '/' | cType == ' '){return 3;}     //ignore comments & whitespace lines
    else {return 0;}  //C Commands            
  }

  String symbol(String line) {
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