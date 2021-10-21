PImage sfondo;
int numeroFoglie = 10;
foglia[] array_di_foglie = new foglia[numeroFoglie];

void setup(){
  sfondo = loadImage("sfondo.jpg");
  size(1000,500);
  for(int i=0;i<numeroFoglie;i++){
    array_di_foglie[i] = new foglia();
    array_di_foglie[i].rate = int(random(2,20));
  }
}

int x,y;

void draw(){
  image(sfondo,0,0);
  for(int i=0;i<numeroFoglie;i++){
    array_di_foglie[i].display();
  }
  
}
