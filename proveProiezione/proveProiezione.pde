import codeanticode.syphon.*;

import netP5.*;
import oscP5.*;
import processing.sound.*;

PImage london_map, effetto_vignette, illustrazionebn, tamigi, sfondo_carta, africa_map;
PImage risultato_blend;
PGraphics maschera;
int london_map_x=-600, london_map_y=0;
PFont font_dreamcatcher, font_tahomabold;
int frame_rate=25;
int scena_attiva = 2;
String testo_unito;
PFont font;
String[] righe;
String alfabeto = "ABCDEFGHIJKLMNOPQRSTUVWXYZ ";
int[] contatori = new int[alfabeto.length()];
int posX, posY;
AudioIn ingresso;
Amplitude rms;
OscP5 osc;
SyphonServer server;

void setup() {
  size(1024, 768, P2D);
  //frameRate(frame_rate);
  africa_map = loadImage("africa.jpg");
  sfondo_carta  = loadImage("carta.jpg");
  london_map = loadImage("londonMap.jpg");
  effetto_vignette = loadImage("vignette.png");
  illustrazionebn = loadImage("illustrazioneBN.jpg");
  tamigi = loadImage("tamigi.jpg");
  london_map.resize(london_map.width*2, 0);
  africa_map.resize(3*width, 0);
  effetto_vignette.resize(width, height);
  illustrazionebn.resize(width, 0);
  tamigi.resize(width, 0);
  risultato_blend = createImage(width, height, RGB);
  risultato_blend = illustrazionebn;
  risultato_blend.blend(
    tamigi, 0, 0, width, height, 
    0, 0, width, height, 
    OVERLAY);
  risultato_blend.resize(0, height);
  font_dreamcatcher = loadFont("DreamCatcher-48.vlw");
  font_tahomabold = loadFont("Tahoma-Bold-48.vlw");
  maschera = createGraphics(width, height, P2D);
  textAlign(CENTER, CENTER);
  //esempio testo audio reattivo inizializzazione
  righe = loadStrings("cuore.txt");
  testo_unito = join(righe, " ");
  font = createFont("Courier", 10);
  contaCaratteri();
  ingresso = new AudioIn(this, 0);
  //ingresso.play();
  rms = new Amplitude(this);
  rms.input(ingresso);
  osc = new OscP5(this, 8000);
  server = new SyphonServer(this, "Processing Syphon");
}

int fade_selezionato=0;
int numero_riga = 0;

void draw() {
  background(0);
  switch(scena_attiva) {
  case 1:
    scenaMappa(2);
    break;
  case 2:
    scenaBlend();
    break;
  case 3:
    scenaScrittura(righe[numero_riga], 0.5);
    break;
  case 4:
    testoMask(africa_map, righe[1], maschera, 2);
    break;
  }
  fade(fade_selezionato);
  server.sendScreen();
}

//SCENA MAPPA IN SCORRIMENTO

boolean direzione_scorrimento_mappa = false, direzione_scorrimento_mappa_x = false;

void scenaMappa(int velocita_scorrimento) {
  image(london_map, london_map_x, london_map_y);
  filter(THRESHOLD, 0.6);
  image(effetto_vignette, 0, 0);
  float altezza_mappa = london_map.height;
  float offset_y = altezza_mappa - height;
  println(offset_y);
  if (direzione_scorrimento_mappa)
    london_map_y += velocita_scorrimento;
  else
    london_map_y -= velocita_scorrimento;
  if (abs(london_map_y)>offset_y||london_map_y>=0) {
    direzione_scorrimento_mappa = !direzione_scorrimento_mappa;
  }
}

//SCENA BLEND FRA IMMAGINI
void contaCaratteri() {
  for (int i=0; i<testo_unito.length(); i++) {
    char lettera = testo_unito.charAt(i);
    String stringa_lettera = str(lettera);
    stringa_lettera = stringa_lettera.toUpperCase();
    char lettera_maiuscola = stringa_lettera.charAt(0);
    int indice = alfabeto.indexOf(lettera_maiuscola);
    if (indice>=0) {
      contatori[indice]++;
    }
  }
  println("contaCaratteri");
}

void scenaBlend() {
  image(risultato_blend, 0, 0);

  textFont(font);
  noStroke();
  smooth();

  posX=20;
  posY=200;

  for (int i=0; i<testo_unito.length(); i++) {
    String stringa_singolo = str(testo_unito.charAt(i)).toUpperCase();
    char carattereMaiuscolo = stringa_singolo.charAt(0);
    int indice_in_alfabeto = alfabeto.indexOf(carattereMaiuscolo);
    if (indice_in_alfabeto<0)
      continue;

    fill(0, 255, 0, contatori[indice_in_alfabeto]*3);
    float ampiezza = rms.analyze();
    //println(ampiezza);
    textSize(24);

    float ordinaY = indice_in_alfabeto*20+40;
    float m = ampiezza*2;//map(mouseX,50,width-50,0,1);
    m = constrain(m, 0, 1);
    float interlineaY = lerp(posY, ordinaY, m);


    text(testo_unito.charAt(i), posX, interlineaY);
    fill(0);
    posX += textWidth(testo_unito.charAt(i));

    if (posX>=width-100 && carattereMaiuscolo==' ' ) {
      posY += 30;
      posX = 20;
    }
  }


  image(effetto_vignette, 0, 0);
}

//SCENA TESTO IN LETTERING CON FONDO CARTA
int indice_carattere = 0;

void scenaScrittura(String testo, float secondi) {
  textFont(font_dreamcatcher);
  textSize(100);
  image(sfondo_carta, 0, 0);
  fill(0);
  String testo_con_lettering = testo.substring(0, indice_carattere);
  text(testo_con_lettering, width/2, height/2);
  if (frameCount%(secondi*frame_rate)==0 && indice_carattere<testo.length()) {
    indice_carattere++;
    //flash
    rect(0, 0, width, height);
  }
  indice_carattere = constrain(indice_carattere, 0, testo.length());  
  image(effetto_vignette, 0, 0);
}

//SCENA TESTO MASK MAPPA
float africa_map_x=0, africa_map_y=0;

void testoMask(PImage bg, String text, PGraphics out, int velocita_scorrimento) {
  float text_size = calcolaTextWidth(text);
  out.beginDraw();
  out.image(bg, africa_map_x, africa_map_y);
  PImage to_mask = out.get();
  out.background(0);
  out.fill(255);
  out.textFont(font_tahomabold);
  out.textSize(text_size);
  out.textAlign(CENTER, CENTER);
  out.text(text, width/2, height/2, width);
  out.loadPixels();
  to_mask.mask(out.pixels);
  out.image(to_mask, 0, 0);
  out.endDraw();
  image(maschera, 0, 0);
  image(effetto_vignette, 0, 0);

  float altezza_mappa = africa_map.height;
  float larghezza_mappa = africa_map.width;
  float offset_x = larghezza_mappa - width;
  float offset_y = altezza_mappa - height;

  //rimbalzo x
  if (direzione_scorrimento_mappa_x)
    africa_map_x += velocita_scorrimento;
  else
    africa_map_x -= velocita_scorrimento;
  if (abs(africa_map_x)>offset_x||africa_map_x>=0) {
    direzione_scorrimento_mappa_x = !direzione_scorrimento_mappa_x;
  }
  //rimbalzo y
  if (direzione_scorrimento_mappa)
    africa_map_y += velocita_scorrimento;
  else
    africa_map_y -= velocita_scorrimento;
  if (abs(africa_map_y)>offset_y||africa_map_y>=0) {
    direzione_scorrimento_mappa = !direzione_scorrimento_mappa;
  }
}

float calcolaTextWidth(String text) {
  float size = 1, textW=1;
  while (textW<width) {
    textSize(size);
    textW = textWidth(text);
    size++;
  }
  float scarto = 2*(max(width, textW)-min(width, textW));
  return size-scarto;
}

float canale_alpha_per_il_fade = 0.;

void fade(int tipo_fade) {
  switch(tipo_fade) {
  case 1://fade in 
    canale_alpha_per_il_fade-=5;
    break;
  case 2://fadeout
    canale_alpha_per_il_fade+=5;
    break;
  default:
    break;
  }
  canale_alpha_per_il_fade = constrain(canale_alpha_per_il_fade, 0, 255);

  fill(0, canale_alpha_per_il_fade);
  rect(0, 0, width, height);
}

//COMANDI DA TASTIERA
void keyPressed() {
  switch(key) {
  case 'i':
    fade_selezionato = 1;
    break;
  case 'o':
    fade_selezionato = 2;
    break;
  case 'q':
    scena_attiva = 1;
    break;
  case 'w':
    scena_attiva = 2;
    break;
  case 'e':
    scena_attiva = 3;
    break;
  case 'r':
    scena_attiva = 4;
    break;
  }
}

//GESTIONE MESSAGGI OSC
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
  if (theOscMessage.checkAddrPattern("/scena_attiva")) {
    scena_attiva = theOscMessage.get(0).intValue();
    numero_riga = int(random(righe.length));
  }
  if (theOscMessage.checkAddrPattern("/fadein")) {
    fade_selezionato = 1;
  }
  if (theOscMessage.checkAddrPattern("/fadeout")) {
    fade_selezionato = 2;
  }
}
