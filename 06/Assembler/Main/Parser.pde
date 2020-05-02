class Parser {
  BufferedReader fileReader;
  String currentLine;
  String currentBinary;
  String[] fileForSecondLoop;

  Parser() {
    fileReader = createReader("TestText.asm");
  }

  void run() {
    //while (currentLine != null) {
      try {
        currentLine = fileReader.readLine();
      }
      catch (IOException e) {
        e.printStackTrace();
        currentLine = null;
      }
      if (currentLine == null) {
        noLoop(); //if this doesn't end the program, put something here that does. Jump to an "End" method?                     //BE WARY - this might prevent phase 2 by accident.
      } 
      else {
        int cmdTyp = commandType(currentLine);
        if(cmdTyp == 1) {println("0" + symbol(currentLine));}
        else if(cmdTyp == 0){println("111" + comp(currentLine) + dest(currentLine) + jump(currentLine));}
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

  String dest(String line) {
    return "uwu"; //will get real data from code module
  }

  String comp(String line) {
    return "ohnowat"; //get real data from code module
  }

  String jump(String line) {
    return "owo";
  }




  //do the tests & stuff on it
  //if it is a label, add it to symbolsTable (do this later).
  //if it isn't a label, add it to the stringArray
  //get next line

  //second loop, go through and actually translate the thing, symbols & all.
}