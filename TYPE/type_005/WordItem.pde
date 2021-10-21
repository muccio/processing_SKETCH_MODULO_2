
class WordItem extends SimpleMapItem {
  String word;
  int count;
  int margin = 3;

  WordItem(String word) {
    this.word = word;
  }

  void draw() {
    // frames
    // inheritance: x, y, w, h
    strokeWeight(0.25);
    fill(255);
    rect(x, y, w, h);

    // maximize fontsize in frames
    for (int i = minFontSize; i <= maxFontSize; i++) {
      textFont(font,i);
      if (w < textWidth(word) + margin || h < (textAscent()+textDescent()) + margin) {
        textFont(font,i);
        break;
      }
    }

    // text
    fill(0);
    textAlign(CENTER, CENTER);
    text(word, x + w/2, y + h/2);
  }
}
