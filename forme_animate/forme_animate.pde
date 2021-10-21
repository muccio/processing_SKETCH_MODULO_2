float x, y, xn, yn;

void setup() {
  size(600, 600);
  x=width/2;
  y=height/2;
  xn=x;
  yn=y;
  background(255);
}

int q = 10;

void draw() {
  //background(255);
  /*
  //SPOSTAMENTO LIBERO (MOTO BROWNIANO)
  x += random(-3, 3);
  y += random(-3, 3);*/
  /*
  //MOVIMENTO VINCOLATO X o Y
  if(random(1.)>0.5){
    x += random(-10,10);
  }
  else{
    y += random(-10,10);
  }
  */
  //MOVIMENTO VINCOLATO X o Y
  //"QUANTIZZATO" SU UNA GRIGLIA 10*10
  q = int(float(mouseX)/float(width)*30);
  if(random(1.)>0.5){
    x += random(-q,q);
  }
  else{
    y += random(-q,q);
  }
  x = round(x/q)*q;
  y = round(y/q)*q;
  x= constrain(x, 0, width);
  y= constrain(y, 0, height);

  //ellipse(x,y,10,10);

  line(x, y, xn, yn);
  xn = x;
  yn = y;
}

void mousePressed() {
  x=mouseX;
  y=mouseY;
}
