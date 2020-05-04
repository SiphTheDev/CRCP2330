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
  int memAdr = 0; 

  Parser() {
    //initilize symbol and code tables.
    mySymbols = new SymbolTable();
    myCode = new Code();
    mySymbols.loadDefaultSymbols();
    myCode.loadTables();

    fileContents = new StringList();  
    fileReader = createReader("Pong.asm");  //HERE: Change filename to the file which will be read
    output = createWriter("Pong.hack");     //HERE: Change filename to the file which will be produced
  }

  void run() {              //Calls methods to read the file, load the symbols into Symbol Table, and parse the program.  
    while (finished == false){readFile();}
    phase1(mySymbols);
    phase2(mySymbols, myCode);
    noLoop();
  }

  void readFile() {
    try {                   //Reads the file and saves each line into fileContents.
      readingLine = fileReader.readLine(); 
      fileContents.append(readingLine);
    }
    catch (IOException e) { //Catches when there is not another line to read.
      e.printStackTrace();
      readingLine = null;
    }
    if (readingLine == null) {finished = true;}
  }

  void phase1(SymbolTable symbolTable) {     //First Loop through the program to get labels.
    String currentLine = null;
    
    for (int i = 0; i < fileContents.size()-1; i++) {
      currentLine = fileContents.get(i);
      int cmdTyp = commandType(currentLine); //determines what type of command is stored in the next line of the file.
      if (cmdTyp == 0||cmdTyp == 1) {        //If A or C cmd, increment memoryAddress.
        memAdr++;
      } 
      else if (cmdTyp == 2) {                //if a label, add name string and memory address to SymbolTable.
        String label = symbol(currentLine, cmdTyp, symbolTable);
        String binAdr = binary(memAdr, 15);
        symbolTable.addEntry(label, binAdr); 
      }
    }
  }  

  void phase2(SymbolTable symbolTable, Code codeTables) {  //Second Loop to parse program.
    String currentLine = null;
    
    for (int i = 0; i<fileContents.size()-1; i++) {        //Loads next line into currentLine variable.
      currentLine = fileContents.get(i);
      
      if (currentLine.length() != 0) {                     //Ensures that currentLine is not empty and removes all white space in front of commands.
        char cSig = currentLine.charAt(0);
        if (cSig == ' ') {
          while (cSig == ' ') {
            currentLine = currentLine.substring(1, currentLine.length());
            cSig = currentLine.charAt(0);
          }
        }
      }
       
      int cmdTyp = commandType(currentLine);               //Returns type of command, A or C
      
      if (cmdTyp == 1) {                                   //A command - run through symbol method and print into final document
        output.println("0" + symbol(currentLine, cmdTyp, symbolTable));
      } else if (cmdTyp == 0) {                            //C command - convert each element of the command to the proper binary and pring into final document        
        output.println("111" + comp(currentLine, codeTables) + dest(currentLine, codeTables) + jump(currentLine, codeTables));
      }
    }
    output.flush();  //finalize the final document
    output.close();
  }


  int commandType(String line) {             //returns the type of command stored in Line
    if (line.length() == 0) {return 3;}      //returns 3(do nothing) if line is empty
    
    char cType = line.charAt(0);

    if (cType == ' ') {                      //removes any white space at start of line
      while (cType == ' ') {
        line = line.substring(1, line.length());
        cType = line.charAt(0);
      }
    }

    if (cType == '@') {return 1;}            //returns 1 = A Commands
    else if (cType == '(') {return 2;}       //returns 2 = Labels
    else if (cType == '/') {return 3;}       //returns 3(do nothing) = Comment
    else {return 0;}                         //returns 0 = C Commands
  }

  String symbol(String line, int cmdTyp, SymbolTable symbols) {    //returns A commands in binary &/or address labels to the SymbolTable
    if (cmdTyp == 1) {                             //If it is an A command
    String value;
    int indexOfWs = line.indexOf(" ");             //Remove '@' before and any whitespace after the A command.
       if(indexOfWs != -1){
          value = line.substring(1, indexOfWs);
       }
       else{
          value = line.substring(1, line.length());
       }  

      char sigC = value.charAt(0);
      if (sigC > 47 && sigC < 58) {               //If command begins with an integer, convert to binary and return
        Integer num = parseInt(value);
        return binary(num, 15);
      } 
      else {                                      //if it is NOT between 0 & 9, check if it is in the SymbolTable already or not
        if (symbols.contains(value)) {return(symbols.getAddress(value));}            //if the table already contains this value, return the memoryAddress
        else {                                    //if the table does not contain this value, add it to table, then return the memAdr.
          String nextMemAdr = binary(newVarMemAdr, 15);
          symbols.addEntry(value, nextMemAdr);
          newVarMemAdr ++;
          return nextMemAdr;
        }
      }
    } else if (cmdTyp == 2) {                      //If it is a label, remove parentheses and returns the string name of the label.
      String label = line.substring(1, line.length()-1);
      return label;
    } else return "error";
  }

  String comp(String line, Code codeTables) {       //Removes symbolic dividers and whitespace around compCodes and returns binary equivalent.
    int indexOfEq = line.indexOf("=");
    int indexOfSc = line.indexOf(";");
    int indexOfWs = line.indexOf(" ");
    String compBits;

    if (indexOfEq == -1) {compBits = line.substring(0, indexOfSc);} 
    else if (indexOfSc == -1) {
      if(indexOfWs != -1){compBits = line.substring(indexOfEq+1, indexOfWs);}
      else{compBits = line.substring(indexOfEq+1, line.length());}
    } 
    else {compBits = line.substring(indexOfEq+1, indexOfSc);}
    return codeTables.comp(compBits);
  }

  String dest(String line, Code codeTables) {        //Removes symbolic dividers and whitespace around destCodes and returns binary equivalent.
    int indexOfEq = line.indexOf("=");
    String destBits;

    if (indexOfEq == -1) {return "000";} //returns 000 if no dest command
    else {destBits = line.substring(0, indexOfEq);}
    
    return codeTables.dest(destBits);
  }

  String jump(String line, Code codeTables) {        //Removes symbolic dividers and whitespace around jumpCodes and returns binary equivalent.
    int indexOfSc = line.indexOf(";");
    int indexOfWs = line.indexOf(" ");
    String jumpBits;

    if (indexOfSc == -1) { //returns 000 if no jump command
      return "000";
    } 
    else {
      if(indexOfWs != -1){jumpBits = line.substring(indexOfSc+1, indexOfWs);}
      else{jumpBits = line.substring(indexOfSc+1, line.length());}
    }
    
    return codeTables.jump(jumpBits);
  }
}