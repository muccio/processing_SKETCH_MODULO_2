

void setup(){
  size(832,468);
  PImage originale = loadImage("tokyo.bmp");
  image(originale,0,0);
}

void draw(){
  mousePressed();
}

void mousePressed(){
  // Open a file and read its binary data 
  byte b[] = loadBytes("tokyo.bmp"); 
  IntList indici = new IntList();
  println("lughezza:"+b.length);
  float percentuale_da_distruggere = 0.05;
  int byte_da_distruggere = int(b.length*percentuale_da_distruggere);
  println("byte_da_distruggere:"+byte_da_distruggere);
  //valori random
  for (int i = 0; i < byte_da_distruggere; i++) { 
    int indice = -1;
    while (indice==-1){
      indice = int(random(b.length));
      if(indici.hasValue(indice)||indice<300)
        indice=-1;
    }
    b[indice]*=byte(random(1));
    indici.append(indice);
  } 
  //copia
  for(int i=0;i<20;i++){
    int indice_da = int(random(b.length));
    int indice_a = int(random(b.length));
    int lunghezza = int(random(0,b.length/10));
    //println(indice_da + " a "+indice_a+" - lun:"+lunghezza);
    if(indice_da+lunghezza>b.length)lunghezza=b.length-indice_da;
    if(indice_a+lunghezza>b.length)lunghezza=b.length-indice_a;
    arrayCopy(b,indice_da,b,indice_a,lunghezza);
  }
  //copia(b,random(b.length),random(b.length),200);
  //println(); 
  saveBytes("data/tokyoedit.bmp", b);
  //println("saved "+indici.size());
  
  PImage scrambled = loadImage("tokyoedit.bmp");
  image(scrambled,0,0);
}
