particella[] e = new particella[16];

void setup() {
  size(600, 600);
  for (int i=0; i<e.length; i++) {
    e[i] = new particella(i, e);
    e[i].posizione = new PVector(random(width),random(height));
    e[i].velocita = new PVector(random(0.5),random(0.5));
  }
}

void draw() {
  background(0);
  stroke(255);
  for (int i=0; i<e.length; i++) {
    e[i].collide();
    e[i].muovi();
  }
  for (int i=0; i<e.length; i+=2) {
    line(e[i].posizione.x, e[i].posizione.y, 
      e[i+1].posizione.x, e[i+1].posizione.y);
  }
}

void mouseDragged() {
  for (int i=0; i<e.length; i++) {
    if (dist(mouseX, mouseY, e[i].posizione.x, e[i].posizione.y)<20) {
      e[i].frizione = 0.5;
      e[i].velocita.x = mouseX-pmouseX;
      e[i].velocita.y = mouseY-pmouseY;
    }
  }
}

class particella {
  PVector posizione;
  PVector velocita;
  int dimensione = 30;
  float frizione =0.5 ;
  particella[] altre_particelle;
  int identificativo;

  particella(int idin, particella[] altrein) {
    identificativo = idin;
    altre_particelle = altrein;
  }

  void muovi() {
    posizione.x += velocita.x/frizione;
    posizione.y += velocita.y/frizione;
    if (posizione.x>width-dimensione/2||posizione.x<dimensione/2) {
      velocita.x*=-1;
    }
    if (posizione.y>height-dimensione/2||posizione.y<dimensione/2) {
      velocita.y*=-1;
    }
    fill(255);
    ellipse(posizione.x, posizione.y, dimensione, dimensione);
    frizione+=0.01;
  }

  void collide() {
    for (int i=0; i<e.length; i++) {
      if (dist(posizione.x, posizione.y, 
        altre_particelle[i].posizione.x, altre_particelle[i].posizione.y)<
        dimensione) {
        float angolo = atan2(altre_particelle[i].posizione.y-posizione.y, 
          altre_particelle[i].posizione.x-posizione.x);
        float target_x = posizione.x + cos(angolo)*2*dimensione;
        float target_y = posizione.y + sin(angolo)*2*dimensione;
        float ax = 0.01 * (target_x - altre_particelle[i].posizione.x) * frizione;
        float ay = 0.01 * (target_y - altre_particelle[i].posizione.y) * frizione;
        velocita.x -= ax;
        velocita.y -= ay;
        altre_particelle[i].velocita.x +=ax;
        altre_particelle[i].velocita.y +=ay;
      }
    }
  }
}
