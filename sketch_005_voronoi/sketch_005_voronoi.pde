float [] px = new float[0]; // hold the mouse pressed marks
float [] py = new float[0];
float [] distance = new float[0]; //holds the pixel�s distance to the marked point
int [] idx = new int[0]; //used for sorting the pixels
PImage MyImage;
void setup(){
  size (400,400);
  MyImage = createImage (width, height, RGB); //create an image
  image(MyImage,0,0);
}
void draw(){
  stroke(0);
  for(int i=0; i<px.length; i++)
    rect(px[i],py[i],3,3); //draw the mark as a tiny rectangle
}
void mousePressed(){ //if the use presses the mouse
  px = append(px,mouseX); //add that clicked point
  py = append(py,mouseY);
  distance = append(distance,0); //allocate memory for the distance
  idx = append(idx,0); // and the id
  for(int x=0; x<width; x++) //for all pixels
    for(int y=0; y<height; y++){
      for(int i=0; i<px.length; i++) //for all already defined marks
        distance[i] = dist(x,y,px[i],py[i]); //find the distance from all points
      for(int i=0; i<idx.length; i++)
        idx[i]=i;
      for(int i=1; i<distance.length; i++) //sort all distances together with ids
        for(int j=0; j<distance.length-1; j++)
          if(distance[i]>distance[j]){
            float t = distance[i]; //swap in ascending order
            distance[i] = distance[j];
            distance[j] = t;
            int tr = idx[i];
            idx[i]=idx[j];
            idx[j] = tr;
          }
      for(int i=0; i<idx.length; i++) //color the area with random colors
        set(x,y,color((idx[i]*126)%255,(idx[i]*133)%255,(idx[i]*144)%255));
    }
}
