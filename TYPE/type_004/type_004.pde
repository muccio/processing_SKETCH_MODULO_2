import processing.pdf.*;
import java.util.Calendar;

boolean savePDF = false;
PFont font;
String joinedText;
String alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZòéàù’,.;:!? ";
int[] counters = new int[alphabet.length()];
float charSize;
color charColor = 0;
int posX, posY;
boolean drawAlpha = true;

void setup() {
  size(670, 800);
  String[] lines = loadStrings("cuore.txt");
  joinedText = join(lines, " ");
  font = createFont("Courier", 10);
  countCharacters();
  alphabet = alphabet.toUpperCase();
}


void draw() {
  if (savePDF) beginRecord(PDF, timestamp()+".pdf");
  textFont(font);
  background(255);
  noStroke();
  smooth();
  posX = 20;
  posY = 40;
  // go through all characters in the text to draw them  
  for (int i = 0; i < joinedText.length(); i++) {
    // again, find the index of the current letter in the alphabet
    String s = str(joinedText.charAt(i)).toUpperCase();
    char uppercaseChar = s.charAt(0);
    int index = alphabet.indexOf(uppercaseChar);
    if (index < 0) continue;

    if (drawAlpha) fill(87, 35, 129, counters[index]*3);
    else fill(87, 35, 129);
    textSize(18);

    float sortY = index*20+40;
    float m = map(mouseX, 50,width-50, 0,1);
    m = constrain(m, 0, 1);
    //interpolazione lineare
    float interY = lerp(posY, sortY, m);
    text(joinedText.charAt(i), posX, interY);
    posX += textWidth(joinedText.charAt(i));
    if (posX >= width-200 && uppercaseChar == ' ') {
      posY += 30;
      posX = 20;
    }
  }
  if (savePDF) {
    savePDF = false;
    endRecord();
  }
}


void countCharacters(){
  for (int i = 0; i < joinedText.length(); i++) {
    // get one char from the text, convert it to a string and turn it to uppercase
    char c = joinedText.charAt(i);
    String s = str(c);
    s = s.toUpperCase();
    // convert it back to a char
    char uppercaseChar = s.charAt(0);
    // get the position of this char inside the alphabet string
    int index = alphabet.indexOf(uppercaseChar);
    // increase the respective counter
    if (index >= 0) counters[index]++;
  }
}




void keyReleased(){
  if (key == 's' || key == 'S') saveFrame(timestamp()+"_##.png");
  if (key=='p' || key=='P') savePDF = true;

  if (key == '1') drawAlpha = !drawAlpha;
}


// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
