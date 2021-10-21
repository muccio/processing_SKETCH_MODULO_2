

import treemap.*;
import processing.pdf.*;
import java.util.Calendar;

Treemap map;
MapLayout layoutAlgorithm = new SquarifiedLayout();
//BinaryTreeLayout StripTreemap OrderedTreemap PivotByMiddle 
//PivotBySize PivotBySplitSize SliceLayout SquarifiedLayout StripTreemap

boolean savePDF = false;

int maxFontSize = 1000;
int minFontSize = 1;

PFont font;


void setup() {
  size(800,600);
    
  font = createFont("miso-bold.ttf", 10);
  smooth();

  WordMap mapData = new WordMap();

  //  ------ read a textfile ------
  String[] lines = loadStrings("cuore.txt");
  // join all lines to a big string
  String joinedText = join(lines, " ");

  // replacings
  joinedText = joinedText.replaceAll("_", "");  

  // split text into words by delimiters
  String[] words = splitTokens(joinedText, " ¬ª¬´‚Äì_-–().,;:?!\u2014\"");

  // add all words to the treemap
  for (int i = 0; i < words.length; i++) {
    // translate all to UPPERCASE
    String word = words[i].toLowerCase();
    mapData.addWord(word);     
  }

  //  ------ treemap data is ready ------
  mapData.finishAdd();

  // create treemap with mapData
  map = new Treemap(mapData, 0, 0, width, height);
}


void draw() {
  if (savePDF) beginRecord(PDF, timestamp()+".pdf");

  background(255);
  map.setLayout(layoutAlgorithm);
  map.updateLayout();
  map.draw();

  if (savePDF) {
    savePDF = false;
    endRecord();
  }

  noLoop();
}


void keyReleased() {
  if (key == 's' || key == 'S') saveFrame(timestamp()+"_##.png");
  if (key == 'p' || key == 'P') savePDF = true;

  // set layout algorithm
  if (key=='1') layoutAlgorithm = new SquarifiedLayout();
  if (key=='2') layoutAlgorithm = new PivotBySplitSize();
  if (key=='3') layoutAlgorithm = new SliceLayout();
  if (key=='4') layoutAlgorithm = new OrderedTreemap();
  if (key=='5') layoutAlgorithm = new StripTreemap();

  if (key=='1'||key=='2'||key=='3'||key=='4'||key=='5'||
    key=='s'||key=='S'||key=='p'||key=='P') loop();
}


// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
