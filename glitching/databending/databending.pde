PImage immagine;

void setup(){
  size(832,468);
  immagine = loadImage("tokyo.bmp");
}

void draw(){
  image(immagine,0,0);
}

void mousePressed(){
  byte[] b = loadBytes("tokyo.bmp");
  println("lunghezza: "+b.length);
  float percentuale_del_file_da_modificare = 0.1;
  int byte_da_distruggere = int(b.length*percentuale_del_file_da_modificare);
  println("byte_da_distruggere:"+byte_da_distruggere);
  IntList indici = new IntList();
  for(int i=0;i<byte_da_distruggere;i++){
    int indice = -1;
    while(indice==-1){
      indice = int(random(b.length));
      if(indice<300||indici.hasValue(indice)){
        indice = -1;
      }
    }
    b[indice] *= sin(radians(i*10));//byte(random(255));
    indici.append(indice);
  }
  for(int i=0;i<20;i++){
    int indice_da = int(random(b.length));
    int indice_a = int(random(b.length));
    int lunghezza = int(random(0,0.1*b.length));
    
    if(lunghezza+indice_da>b.length)lunghezza=b.length-indice_da;
    if(lunghezza+indice_a>b.length)lunghezza=b.length-indice_a;
    
    arrayCopy(b,indice_da,b,indice_a,lunghezza);
  }
  saveBytes("data/tokyoedit.bmp",b);
  immagine = loadImage("tokyoedit.bmp");
}
