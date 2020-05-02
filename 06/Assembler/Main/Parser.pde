class Parser{
  BufferedReader fileReader;
  String currentLine;
  String currentBinary;
  String[] fileForSecondLoop;
  //Boolean phase2;

  Parser(){
    fileReader = createReader("Add.asm");
    //phase2 = false;
  }
  
  void run(){
    try{
      currentLine = fileReader.readLine();
    }
    catch (IOException e) {
      e.printStackTrace();
      currentLine = null;
    }
    if(currentLine == null){
      //phase2 = true;
      noLoop(); //if this doesn't end the program, put something here that does. Jump to an "End" method?                     //BE WARY - this might prevent phase 2 by accident.
    }
    else{
        //Dothethingshere
        //if first symbol is @, goto A cmd stuff
        //else if first symbol is "//," skip (implem in phase2 bit)
          //also deal with var names and other symbols somewhere in here, too.
        //else - do C comd stuff
    }
  }
  
  int commandType(line){
    char cType = line.charAt(0);
    if(cType == '@'){return 1};     //A Commands
    else{return 0};                 //C Commands
  }
  

  

  //do the tests & stuff on it
  //if it is a label, add it to symbolsTable (do this later).
  //if it isn't a label, add it to the stringArray
  //get next line
  
  //second loop, go through and actually translate the thing, symbols & all.
}