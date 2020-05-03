class Parser {
  //BufferedReader l1Reader;
  BufferedReader fileReader;
  PrintWriter output;
  //String l1CurrentLine;
  String readingLine;
  String currentLine;
  String currentBinary;
  StringList fileContents;
  //Boolean l1Done = false;
  boolean finished = false;
  int memAdr = 0;

  Parser() {
    fileContents = new StringList();
    fileReader = createReader("TestText.asm");
    output = createWriter("TestText.hack");
  }

  void run(SymbolTable symbols, Code codeTables) {
    while (finished == false){
      readFile();
    }
    //while (phase == 1) {
      phase1(symbols);
    //}
    //println(phase);
    while (phase == 2) {
      phase2(codeTables);
    }
  }

  void readFile() {
    try {
      readingLine = fileReader.readLine();
      fileContents.append(currentLine);
    }
    catch (IOException e) {
      e.printStackTrace();
      currentLine = null;
    }
    if (currentLine == null) {
      finished = true;
    }
  }

  void phase1(SymbolTable symbolTable) {
    try {
      currentLine = fileReader.readLine();
      //fileForSecondLoop.append(currentLine);
    }
    catch (IOException e) {
      e.printStackTrace();
      currentLine = null;
    }
    if (currentLine == null) {
      phase = 2; 
      println("phase = 1");
    } else {
      
      
      
      
      println("doingL1");
      int cmdTyp = commandType(currentLine);
      if (cmdTyp == 0||cmdTyp == 1) {
        memAdr++;
      } //If A or C        
      else if (cmdTyp == 2) { //if a label
        String label = symbol(currentLine, cmdTyp);
        String binAdr = binary(memAdr+1, 16);
        symbolTable.addEntry(label, binAdr);
      }
    }
  }

  void phase2(Code codeTables) {
    for (int i = 0; i<fileForSecondLoop.size(); i++) {
    }
    //try {
    //currentLine = fileReader.readLine();
    //println(currentLine);
    //}
    //catch (IOException e) {
    // e.printStackTrace();
    //currentLine = null;
    //}
    //if (currentLine == null) {
    output.flush();
    output.close();
    noLoop();          
    //} else {
      println("doingl2");
      int cmdTyp = commandType(currentLine);
      if (cmdTyp == 1) {
        output.println("0" + symbol(currentLine, cmdTyp));
      } else if (cmdTyp == 0) {
        output.println("111" + comp(currentLine, codeTables) + dest(currentLine, codeTables) + jump(currentLine, codeTables));
      }
    }
  }

  int commandType(String line) {    
    if (line.length() == 0) { 
      return 3;
    }                  //3 = comments, whitespace-only, and empty lines

    char cType = line.charAt(0);

    if (cType == '@') { 
      return 1;
    }      //1 = A Commands
    else if (cType == '(') {
      return 2;
    }     //2 = Labels
    else if (cType == '/' | cType == ' ') {
      return 3;
    }     //3 = comments,whitespace-only, and empty lines
    else {
      return 0;
    }                     //0 = C Commands
  }

  String symbol(String line, int cmdTyp) {// int cmdTyp) {
    //later, add an if statement to account for labels.
    if (cmdTyp == 1) {
      String value = line.substring(1, line.length());

      Integer num = parseInt(value);
      return binary(num, 15);
    } else if (cmdTyp == 2) {
      String label = line.substring(1, line.length()-1);
      return label;
    } else return "bleh";
  }

  String comp(String line, Code codeTables) {
    int indexOfEq = line.indexOf("=");
    int indexOfSc = line.indexOf(";");
    String compBits;

    if (indexOfEq == -1) {
      compBits = line.substring(0, indexOfSc);
    } else if (indexOfSc == -1) {
      compBits = line.substring(indexOfEq+1, line.length());
    } else {
      compBits = line.substring(indexOfEq+1, indexOfSc);
    }
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
    return codeTables.dest(destBits);
  }

  String jump(String line, Code codeTables) {
    int indexOfSc = line.indexOf(";");
    String jumpBits;

    if (indexOfSc == -1) {
      return "000";
    } else {
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