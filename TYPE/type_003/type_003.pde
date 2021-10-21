import processing.pdf.*;
import java.util.Calendar;

boolean savePDF = false;
PFont font;
String textTyped = "";
PShape shapeSpace, shapeSpace2, shapePeriod, shapeComma;
PShape shapeQuestionmark, shapeExclamationmark, shapeReturn;
int centerX = 0, centerY = 0, offsetX = 0, offsetY = 0;
float zoom = 0.75;
int actRandomSeed = 6;


void setup() {
  //imposta la finestra a tutto schermo
  size(displayWidth, displayHeight);
  // make window resizable
  surface.setResizable(true);
  // text to begin with
  textTyped += "La Nellie, una iolla da crociera, girò sull’ancora senza il minimo fluttuare delle vele\n\n";
  textTyped += "e si fermò. \n";
  textTyped += "La marea si era alzata, \n\n";
  textTyped += "il vento era quasi calmo e, poiché dovevamo discendere il fiume,";
  textTyped += "non ci restava che fermarci all’ancora e attendere il riflusso.\n\n";
  textTyped += "L’ultimo tratto del Tamigi si stendeva davanti a noi\n";
  textTyped += "come il principio di un interminabile corso d’acqua. \n\n";
  //textTyped += "Al largo, cielo e mare erano saldati senza una giuntura e nello spazio luminoso le vele conciate delle barche che salivano con la marea sembravano immobili fastelli rossi di tele appuntite tra luccicori di aste verniciate.\n\n";
  centerX = width/2;
  centerY = height/2;  
  font = createFont("miso-bold.ttf",10);
  //font = createFont("Arial",10);
  //carica gli svg
  shapeSpace = loadShape("space.svg");
  shapeSpace2 = loadShape("space2.svg");
  shapePeriod = loadShape("period.svg");
  shapeComma = loadShape("comma.svg"); 
  shapeExclamationmark = loadShape("exclamationmark.svg");
  shapeQuestionmark = loadShape("questionmark.svg");
  shapeReturn = loadShape("return.svg");
  //imposta la forma del puntatore del mouse
  cursor(HAND);
}


void draw() {
  if (savePDF) beginRecord(PDF, timestamp()+".pdf");
  background(255);
  smooth();
  noStroke();
  textAlign(LEFT);
  if (mousePressed == true) {
    centerX = mouseX-offsetX;
    centerY = mouseY-offsetY;
  } 

  // allways produce the same sequence of random numbers
  randomSeed(actRandomSeed);
  translate(centerX,centerY);
  scale(zoom);
  for (int i = 0; i < textTyped.length(); i++) {
    float fontSize = 25;
    textFont(font,fontSize);
    char letter = textTyped.charAt(i);
    float letterWidth = textWidth(letter);
    // ------ letter rule table ------
    switch(letter) {
    case ' ': // space
      // 50% left, 50% right
      int dir = floor(random(0, 2)); 
      if(dir == 0){
        shape(shapeSpace, 0, 0);
        translate(1.9, 0);
        rotate(PI/4);
      }
      if(dir == 1){
        shape(shapeSpace2, 0, 0);
        translate(13, -5);
        rotate(-PI/4);
      }
      break;
    case ',':
      shape(shapeComma, 0, 0);
      translate(34, 15);
      rotate(PI/4);
      break;
    case '.':
      shape(shapePeriod, 0, 0);
      translate(56, -54);
      rotate(-PI/2);
      break;
    case '!':  
      shape(shapeExclamationmark, 0, 0);
      translate(42, -17.4);
      rotate(-PI/4);
      break;
    case '?':  
      shape(shapeQuestionmark, 0, 0);
      translate(42, -18);
      rotate(-PI/4);
      break;
    case '\n': // return  
      shape(shapeReturn, 0, 0);
      translate(0, 10);
      rotate(PI);
      break;
    default: // all others
      fill(0);
      text(letter, 0, 0);
      translate(letterWidth, 0);
    }
  }

  // blink cursor after text
  fill(0);
  if (frameCount/6 % 2 == 0) rect(0, 0, 15, 2);
  if (savePDF) {
    savePDF = false;
    endRecord();
    saveFrame(timestamp()+".png");
  }
}


void mousePressed(){
  offsetX = mouseX-centerX;
  offsetY = mouseY-centerY;
}


void keyReleased() {
  if (keyCode == CONTROL) savePDF = true;
  if (keyCode == ALT) actRandomSeed++;
  println(actRandomSeed);
}

void keyPressed() {
  if (key != CODED) {
    switch(key) {
    case DELETE:
    case BACKSPACE:
      textTyped = textTyped.substring(0,max(0,textTyped.length()-1));
      break;
    case TAB:
      break;
    case ENTER:
    case RETURN:
      // enable linebreaks
      textTyped += "\n";
      break;
    case ESC:
      break;
    default:
      textTyped += key;
    }
  }

  // zoom
  if (keyCode == UP) zoom += 0.05;
  if (keyCode == DOWN) zoom -= 0.05;  
}


// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
