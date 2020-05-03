import java.util.map;

class Code{
  HashMap<String,Integer> compCodes;
  HashMap<String,Integer> destCodes;
  HashMap<String,Integer> jumpCodes;
  
  Code() {
      compCodes = new HashMap<String,Integer>();  //.get & .put
      destCodes = new HashMap<String,Integer>();
      jumpCodes = new HashMap<String,Integer>();
    }
    
void loadTables(){
  compCodes.put("0", 0101010);
  compCodes.put("1", 0111111);
  compCodes.put("-1", 0111010);
  compCodes.put("D", 0001100);
  compCodes.put("A", 0110000);
  compCodes.put("!D", 0001101 );
  compCodes.put("!A", 0110001);
  compCodes.put("-D", 0001111);
  compCodes.put("-A", 0110011);
  compCodes.put("D+1", 0011111);
  compCodes.put("A+1", 0110111);
  compCodes.put("D-1", 0001110);
  compCodes.put("A-1", 0110010);
  compCodes.put("D+A", 0000010);
  compCodes.put("D-A", 0010011);
  compCodes.put("A-D", 0000111);
  compCodes.put("D&A", 0000000);
  compCodes.put("D|A", 0010101);
  compCodes.put("M", 1110000);
  compCodes.put("!M", 1110001);
  compCodes.put("-M", 1110011);
  compCodes.put("M+1", 1110111);
  compCodes.put("M-1", 1110010);
  compCodes.put("D+M", 1000010);
  compCodes.put("D-M", 1010011);
  compCodes.put("M-D", 1000111);
  compCodes.put("D&M", 1000000);
  compCodes.put("D|M", 1010101);
  
  //include one for null, or not? 000
  destCodes.put("M", 001);
  destCodes.put("D", 010);
  destCodes.put("MD", 011);
  destCodes.put("A", 100);
  destCodes.put("AM", 101);
  destCodes.put("AD", 110);
  destCodes.put("AMD", 111);
  
  //include one for null, or not? 000
  jumpCodes.put("JGT", 001);
  jumpCodes.put("JEQ", 010);
  jumpCodes.put("JGE", 011);
  jumpCodes.put("JLT", 100);
  jumpCodes.put("JNE", 101);
  jumpCodes.put("JLE", 110);
  jumpCodes.put("JMP", 111);
}
    
    String comp(String mnemonic){
      String code = str(compCodes.get(mnemonic));
      return(code);
    }
    
    String dest(String mnemonic){
      String code = str(destCodes.get(mnemonic));
      return(code);
    }
    
    String jump(String mnemonic){
      String code = str(jumpCodes.get(mnemonic));
      return(code);
    }
    
    //dest = Have 3 bit variables. 1 is true of A, false if !a, 2 for d, 3 for m. Concatenate them & return. These will always be before =, so go until you find one. If ; but no =, then all are 0.
    
    //comp = 
    
    //jmp = get indexOf ";". If not present, no jmp. If present, check the next 3 chars. 
      //1st bit is jmp if negatice, 2nd is jmp if 0, 3rd is jmp if pos.

}