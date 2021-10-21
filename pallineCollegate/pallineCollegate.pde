class pallina{
  float x,y,vx,vy;
  
  pallina(){
    x = random(0,width);
    y = random(0,width);
    vx = random(0.1,2.0);
    vy = random(0.1,2.0);
  }
  void update(){
    x+=vx;
    y+=vy;
    if(x<0 || x>width){
      vx = -vx;
    }
    if(y<0 || y>width){
      vy = -vy;
    }
  }
  
  void display(){
    fill(0,255,0);
    ellipse(x,y,20,20);
  }
  
  void calcolaDistanza(pallina[] parametro_array){
    for(int i=0;i<parametro_array.length;i++){
      float distanza = dist(x,y,parametro_array[i].x,parametro_array[i].y);
      if(distanza<100){
        stroke(255);
        line(x,y,parametro_array[i].x,parametro_array[i].y);
      }
    }
  }
 
}

pallina[] array;

void setup(){
  size(600,600);
  array = new pallina[10];
  for(int i=0;i<array.length;i++){
    array[i]= new pallina();
  }
}
void draw(){
  background(0);
  for(int i=0;i<array.length;i++){
    array[i].update();
    array[i].display();
    array[i].calcolaDistanza(array);
  }
}
