class Parser {
  SymbolTable mySymbols;
  Code myCode;
  BufferedReader fileReader;
  PrintWriter output;
  String readingLine;
  String currentBinary;
  StringList fileContents;
  boolean finished = false;
  int newVarMemAdr = 16;
  int memAdr = 0; //consider making this local to l1

  Parser() {
    mySymbols = new SymbolTable();
    myCode = new Code();
    mySymbols.loadDefaultSymbols();
    myCode.loadTables();

    fileContents = new StringList();
    fileReader = createReader("Pong.asm");
    output = createWriter("Pong.hack");
  }

  void run() {//SymbolTable symbols, Code codeTables) {    
    while (finished == false) {
      readFile();
    }
    phase1(mySymbols);
    phase2(mySymbols, myCode);
    noLoop();
  }

  void readFile() {
    try {
      readingLine = fileReader.readLine();
      fileContents.append(readingLine);
      //println("readingLine");
    }
    catch (IOException e) {
      e.printStackTrace();
      readingLine = null;
    }
    if (readingLine == null) {
      finished = true;
    }
  }

  void phase1(SymbolTable symbolTable) {
    String currentLine = null;
    for (int i = 0; i < fileContents.size()-1; i++) {
      currentLine = fileContents.get(i);
      //println("doingL1");
      int cmdTyp = commandType(currentLine);
      if (cmdTyp == 0||cmdTyp == 1) { //If A or C  
        memAdr++;
      } 
      else if (cmdTyp == 2) {         //if a label
        String label = symbol(currentLine, cmdTyp, symbolTable);
        String binAdr = binary(memAdr, 15);
        symbolTable.addEntry(label, binAdr); //why does this happen always, not just on new entry?
      }
    }
  }  

  void phase2(SymbolTable symbolTable, Code codeTables) {
    String currentLine = null;
    for (int i = 0; i<fileContents.size()-1; i++) {
      currentLine = fileContents.get(i);
      println("doingl2 line: " + (i+1));
      
      if (currentLine.length() != 0) {
       char cSig = currentLine.charAt(0);
       if (cSig == ' ') {
         while (cSig == ' ') {
         currentLine = currentLine.substring(1, currentLine.length());
         cSig = currentLine.charAt(0);
          }
        }
      }
       
      int cmdTyp = commandType(currentLine);
      println("--cmdTyp: " + cmdTyp);
      if (cmdTyp == 1) { //A cmd
        output.println("0" + symbol(currentLine, cmdTyp, symbolTable));
      } else if (cmdTyp == 0) { //C cmd
        output.println("111" + comp(currentLine, codeTables) + dest(currentLine, codeTables) + jump(currentLine, codeTables));
      }
    }
    output.flush();
    output.close();
  }


  int commandType(String line) {   

    if (line.length() == 0) { 
      return 3;
    }                  //3 = comments and empty lines
    char cType = line.charAt(0);

    if (cType == ' ') { //remove any white space at start of line
      while (cType == ' ') {
        line = line.substring(1, line.length());
        cType = line.charAt(0);
      }
    }

    if (cType == '@') { 
      return 1;
    }      //1 = A Commands
    else if (cType == '(') {
      return 2;
    }     //2 = Labels
    else if (cType == '/') {
      return 3;
    }     //3 = comments and empty lines
    else { //convert to else if(M,D,A)?
      return 0;
    }     //0 = C Commands
  }

  String symbol(String line, int cmdTyp, SymbolTable symbols) {
    if (cmdTyp == 1) { //A cmd   
    String value;
    int indexOfWs = line.indexOf(" ");        //Remove any whitespace AFTEr the cmd.
       if(indexOfWs != -1){
          value = line.substring(1, indexOfWs);
       }
       else{
          value = line.substring(1, line.length());
       }  
      println("value: " + value + ";");
      char sigC = value.charAt(0);
      if (sigC > 47 && sigC < 58) { //if it is a number between 0 & 9 [according to ascii vals), then it's an integer, treat normally
        Integer num = parseInt(value);
        //println("reached normA");
        return binary(num, 15);
      } 
      else { //if it is NOT between 0 & 9...
        if (symbols.contains(value)) { //if the table already contains this value, return the memAdr.
          println("reachedFindA " + value);
          return(symbols.getAddress(value));
        } 
        else { //if the table does not contain this value, add it to table, then return the memAdr.      TODO: is this overwriting the labels?
          String nextMemAdr = binary(newVarMemAdr, 15);
          symbols.addEntry(value, nextMemAdr);
          newVarMemAdr ++;
          println("reachedMakeA: " + value);
          return nextMemAdr;
        }
      }
    } else if (cmdTyp == 2) { //Lbl
      String label = line.substring(1, line.length()-1);
      println("Reached MakeALabel: " + label);
      return label;
    } else return "error";
  }

  String comp(String line, Code codeTables) {
    int indexOfEq = line.indexOf("=");
    int indexOfSc = line.indexOf(";");
    int indexOfWs = line.indexOf(" ");
    String compBits;

    if (indexOfEq == -1) {
      compBits = line.substring(0, indexOfSc);
    } 
    else if (indexOfSc == -1) {
      if(indexOfWs != -1){
        compBits = line.substring(indexOfEq+1, indexOfWs);
      }
      else{
        compBits = line.substring(indexOfEq+1, line.length());
      }
    } 
    else {
      compBits = line.substring(indexOfEq+1, indexOfSc);
    }
    //println("comp bits" + " = " + compBits);
    return codeTables.comp(compBits);
  }

  String dest(String line, Code codeTables) {
    int indexOfEq = line.indexOf("=");
    String destBits;

    if (indexOfEq == -1) {
      return "000";
    } else {
      destBits = line.substring(0, indexOfEq);
    }
    //println("dest bits" + " = " + destBits);
    return codeTables.dest(destBits);
  }

  String jump(String line, Code codeTables) {
    int indexOfSc = line.indexOf(";");
    int indexOfWs = line.indexOf(" ");
    String jumpBits;

    if (indexOfSc == -1) {
      return "000";
    } 
    else {
      if(indexOfWs != -1){
      jumpBits = line.substring(indexOfSc+1, indexOfWs);///line.length());
      }
      else
      {
        jumpBits = line.substring(indexOfSc+1, line.length());
      }
    }
    //println("jumpBits" + " = " + jumpBits);
    return codeTables.jump(jumpBits);
  }
}

//Current Bugs:   -  When checking for pre-existing A cmds, doesn't acknowledge pre-coded ones such as R1 & R2. Is table being loaded?
//                -  comp,dest, and jump all returning null at various points - any point not 000. Are any of my tables being loaded?