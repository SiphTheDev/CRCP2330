class Parser {
  BufferedReader fileReader;
  String currentLine;
  String currentBinary;
  String[] fileForSecondLoop;

  Parser() {
    fileReader = createReader("TestText.asm");
  }

  void run(Code codeTables) {
    //while (currentLine != null) {
      try {
        currentLine = fileReader.readLine();
      }
      catch (IOException e) {
        e.printStackTrace();
        currentLine = null;
      }
      if (currentLine == null) {
        noLoop();                    //BE WARY - this might prevent phase 2 by accident.
      } 
      else {
        int cmdTyp = commandType(currentLine);
        if(cmdTyp == 1) {println("_" + symbol(currentLine));} //_ = 0
        else if(cmdTyp == 0){println("___" + comp(currentLine, codeTables) + dest(currentLine) + jump(currentLine));} //___ = 111
      }
    //}
  }

  int commandType(String line) {
    char cType = line.charAt(0);
    if (cType == '@') {
      return 1;  //A Commands
    }    
    else {
      return 0;  //C Commands
    }               
  }

  String symbol(String line) {
    //later, add an if statement to account for labels.
    String value = line.substring(1, line.length());
    return value;
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
  
  String dest(String line) {
    return "___";
  }

  String jump(String line) {
    return "___";
  }




  //do the tests & stuff on it
  //if it is a label, add it to symbolsTable (do this later).
  //if it isn't a label, add it to the stringArray
  //get next line

  //second loop, go through and actually translate the thing, symbols & all.
}