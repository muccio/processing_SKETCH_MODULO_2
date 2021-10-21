
import java.util.Calendar;

PFont font;
String letter = "A";


void setup(){
  size(800, 800);
  background(255);
  fill(0);

  font = createFont("Arial", 12);
  textFont(font);
  textAlign(CENTER, CENTER);
}

void draw(){
}

void mouseMoved(){
  background(255);
  textSize((mouseX-width/2)*5+1);
  text(letter, width/2, mouseY);
}

void mouseDragged(){
  textSize((mouseX-width/2)*5+1);
  text(letter, width/2, mouseY);
}

void keyReleased() {
  if (keyCode == CONTROL) saveFrame(timeStamp()+"_##.png");

  if (key != CODED && (int)key > 32) letter = str(key);
}


// timestamp
String timeStamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
