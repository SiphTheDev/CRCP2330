BufferedReader fileReader;
String currentLine;
String[] fileForSecondLoop;
Boolean phase2;

void setup(){
  size(500,500);
  fileReader = createReader("Add.asm");
  phase2 = false;
}

void draw(){
  //get currentLine from file
  if(!phase2){
    try{
      currentLine = fileReader.readLine();
    }
    catch (IOException e) {
      e.printStackTrace();
      currentLine = null;
    }
    if(currentLine == null){
      phase2 = true;
      noLoop();                      //BE WARY - this might prevent phase 2 by accident.
    }
    else{
        //Dothethingshere
    }
  }
  else
  

  //do the tests & stuff on it
  //if it is a label, add it to symbolsTable (do this later).
  //if it isn't a label, add it to the stringArray
  //get next line
  
  //second loop, go through and actually translate the thing, symbols & all.
}