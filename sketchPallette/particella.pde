class particella{
  float dimensione;//il diametro
  color colore; //attributo della particella
  PVector posizione;
  PVector velocita;
  PVector accelerazione;
  float trasparenza = 255.0;
  float banda_della_particella;
  
   particella(){
     //inizializzazione degli attributi
     posizione = new PVector(
       random(width/2-50,width/2+50),
       random(height/2-50,height/2+50)
       );
     dimensione = 10;
     colore = color(random(255),random(255),random(255),trasparenza);
     velocita=new PVector(random(-3,3),random(-3,3));
     accelerazione = new PVector(0,0);
   }
   
   void aggiorna(){
     //V=V0+at
     PVector velocita_attuale =new PVector(
       velocita.x+accelerazione.x,
       velocita.y+accelerazione.y
     );
     velocita.x = constrain(velocita.x,-3,3);
     velocita.y = constrain(velocita.y,-3,3);
     accelerazione.x = constrain(accelerazione.x,-3,3);
     accelerazione.y = constrain(accelerazione.y,-3,3);
     posizione.add(velocita_attuale);
     if(posizione.x<0||posizione.x>width){
       velocita.x*=-1;
       accelerazione.x*=-1;
     }
     if(posizione.y<0||posizione.y>height){
       velocita.y*=-1;
       accelerazione.y*=-1;
     }
     colore = color(red(colore),green(colore),
       blue(colore),trasparenza);
   }
   
   void disegna(){
     stroke(255);
     calcola_la_distanza_dalle_altre_e_disegna_riga();
     fill(colore);
     ellipseMode(CENTER);
     ellipse(posizione.x,posizione.y,dimensione,dimensione);
     
     String scrittina = posizione.x+"-"+posizione.y;
     textSize(8);
     fill(255);
     text(scrittina,posizione.x,posizione.y );
     text(banda_della_particella,posizione.x,posizione.y+10 );
     
   }
   
   void calcola_la_distanza_dalle_altre_e_disegna_riga(){
      for(int i=0;i<bands;i++){
        float distanza = dist(posizione.x,posizione.y,
          pippi[i].posizione.x,pippi[i].posizione.y);
        if(distanza<100){
          stroke(255);
          line(posizione.x,posizione.y,
          pippi[i].posizione.x,pippi[i].posizione.y);
        }
      }
   }
   
  
}
