String fileName = "Pong";
Parser myParser;

void setup(){
  size(500,500);
  myParser = new Parser(fileName);
}

void draw(){myParser.run();}