particella e = new particella();

void setup() {
  size(600, 600);
  e.xspeed = random(2);
  e.yspeed = random(2);
}

void draw() {
  background(0);
  e.move();
}

void mouseDragged() {
    if (dist(mouseX, mouseY, e.xpos, e.ypos)<20) {
      e.friction = .5;
      e.xspeed = mouseX-pmouseX;
      e.yspeed = mouseY-pmouseY;
    }
}

class particella {
  int id;
  int size = 30;
  float xpos = 0.;
  float ypos = 0.;
  float friction = 0.5;
  float xspeed= 0;
  float yspeed= 0;

  void move() {
    xpos += xspeed/friction;
    ypos += yspeed/friction;
    if (xpos>width||xpos<0)
      xspeed*=-1;
    if (ypos>height||ypos<0)
      yspeed*=-1;
    xpos = constrain(xpos, 0, width);
    ypos = constrain(ypos, 0, height);
    ellipse(xpos, ypos, size, size);
    friction+=0.01;
  }
}
