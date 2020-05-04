class Parser {
  BufferedReader fileReader;
  PrintWriter output;
  String readingLine;
  String currentBinary;
  StringList fileContents;
  boolean finished = false;
  int memAdr = 0;

  Parser() {
    fileContents = new StringList();
    fileReader = createReader("TestText.asm");
    output = createWriter("TestText.hack");
  }

  void run(SymbolTable symbols, Code codeTables) {
    while (finished == false) {
      readFile();
    }
    phase1(symbols);
    phase2(codeTables);
    noLoop();
  }

  void readFile() {
    try {
      readingLine = fileReader.readLine();
      fileContents.append(readingLine);
      //println(readingLine);
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
      println("doingL1");
      int cmdTyp = commandType(currentLine);
      if (cmdTyp == 0||cmdTyp == 1) { //If A or C  
        memAdr++;
      } else if (cmdTyp == 2) {         //if a label
        String label = symbol(currentLine, cmdTyp);
        String binAdr = binary(memAdr+1, 16);
        symbolTable.addEntry(label, binAdr);

      }
    }
  }  

  void phase2(Code codeTables) {
    String currentLine = null;
    for (int i = 0; i<fileContents.size()-1; i++) {
      currentLine = fileContents.get(i);
      println("doingl2");
      int cmdTyp = commandType(currentLine);
      if (cmdTyp == 1) {
        output.println("0" + symbol(currentLine, cmdTyp));
               println( i + "   added an A ");
      } else if (cmdTyp == 0) {
        output.println("111" + comp(currentLine, codeTables) + dest(currentLine, codeTables) + jump(currentLine, codeTables));
               println( i + "   added a C ");
      }
    }
    output.flush();
    output.close();
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

  String symbol(String line, int cmdTyp) {
    if (cmdTyp == 1) { //A cmd
      String value = line.substring(1, line.length());
      println("value: " + value);

      Integer num = parseInt(value);
      println(binary(num, 15));
      return binary(num, 15);
    } 
    else if (cmdTyp == 2) { //Lbl
      String label = line.substring(1, line.length()-1);
      return label;
    } 
    else return "bleh";
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
}