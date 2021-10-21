class foglia {
  int x, y;
  PImage immagine;
  int rate, contatore_iterazioni=0;

  //COSTRUTTORE FOGLIA
  foglia() {
    x =int(random(width));
    y =int(random(height));

    immagine = loadImage("foglia.png");
  }

  //METODO VISUALIZZAZIONE
  void display() {
    //AGGIORNIAMO LA POSIZIONE DELLA FIGLIA
    //DOPO UN CERTO NUMERO DI FRAME
    //OVVERO RATE
    if (contatore_iterazioni==rate) {
      x+=int(random(-5, 5));
      y+=int(random(-5, 5));
      contatore_iterazioni= 0;
    }
    contatore_iterazioni++;
    image(immagine,x,y);
  }
}
