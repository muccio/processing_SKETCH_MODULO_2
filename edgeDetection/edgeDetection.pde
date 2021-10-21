PImage immagine, copia;
int[] xd = {0, 1, 1, 1, 0, -1, -1, -1, 0};
int[] yd = {1, 1, 0, -1, -1, -1, 0, 1, 1};

void setup() {
  size(1280, 900);
  immagine = loadImage("pattern.png");
  noLoop();
}

void draw() {
  image(immagine, 0, 0);
  int[][] copia = new int[width][height];

  //ANALISI IMMAGINE PER TROVARE I BORDI (PIXEL CON SCARTO 
  //ELEVATO DI LUMINOSITA)
  for (int x=1; x<width-1; x++) {
    for (int y=1; y<height-1; y++) {
      //PIXEL IN ANALISI
      int a=0, b=0;
      //PIXEL ADIACENTI A QUELLO IN ANALISI
      for (int i=0; i<8; i++) {
        int coordinata_x = x+xd[i];
        int coordinata_y = y+yd[i];
        int valore_del_pixel = get(coordinata_x, coordinata_y);
        if (brightness(valore_del_pixel)<128) {
          b++;
        }
        int coordinata_x_2 = x+xd[i+1];
        int coordinata_y_2 = y+yd[i+1];
        int valore_del_pixel_2 = get(coordinata_x_2, coordinata_y_2);

        if (
          brightness(valore_del_pixel)<128 &&
          brightness(valore_del_pixel_2)>128
          ) {
          a++;
        }
      }
      if (b>=2&&b<=6 || a==1) {
        copia[x][y] = 1;
      } else {
        copia[x][y] = 0;
      }
    }
  }
  for (int x=1; x<width-1; x++) {
    for (int y=1; y<height-1; y++) {
      if (copia[x][y] == 1) {
        set(x, y, color(0,0,0));
        println("1");
      } else {
        set(x, y, color(255,255,255));
        println("0");
      }
    }
  }
  println("dne");
}
