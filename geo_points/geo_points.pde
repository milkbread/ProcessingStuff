PImage img;
String[] lines;
float[] x, y, bbox;

void setup() {
  noLoop();
  size(500, 449);
  smooth();
  img = loadImage("vgtl-map.png");
  img.resize(width, height);                 
  background(img);
  
  //lines = new String[8000];
  lines = loadStrings("points-vgtl-27-01-12.csv");
}

void draw() {  
    this.getPoints();
    this.getBBox(); 
    this.drawPoints();
    //println(y);
   
  
  /*if (index == (lines.length - 1)){
    noLoop();
  }*/
   
}

void getPoints(){
  int index = 1;  
  x = new float[lines.length];
  y = new float[lines.length];
  while(index < lines.length){
    String[] values = split(lines[index], ',');
    //println(values[1]);
    //println("**************");
    x[index] = float(values[0]);
    y[index] = float(values[1]);
    index = index + 1;
  }
  println("All coordinates successfully loaded!");
  println("Index: "+ index + " vs. length: "+(lines.length));
}

void getBBox(){
  int index = 0;
  bbox = new float[4];
  //the bbox: upperRight = biggestX , biggestY
  //          lowerLeft = smallestX , smallestY
  float biggestX, smallestX, biggestY, smallestY;
  biggestX = 0;
  smallestX = 200000000.0;
  biggestY = 0;
  smallestY = 200000000.0;
  while(index < x.length){
    //println(x[index]+" vs. "+smallestX);
    if ((biggestX < x[index]) && (x[index] != 0)){
      biggestX = x[index];
    }
    if ((smallestX > x[index]) && (x[index] != 0)){
      smallestX = x[index];
    }
    if ((biggestY < y[index]) && (y[index] != 0)){
      biggestY = y[index];
    }
    if ((smallestY > y[index]) && (y[index] != 0)){
      smallestY = y[index];
    }    
    index = index + 1;
  }
  bbox[0] = smallestX;
  bbox[1] = smallestY;
  bbox[2] = biggestX;
  bbox[3] = biggestY;
  println("biggestX: "+biggestX);
  println("smallestX: " + smallestX);
  println("biggestY: "+biggestY);
  println("smallestY: " + smallestY);
}
void drawPoints(){
  int index = 0;
  while(index < x.length){
    stroke(0);            
    fill(255, 0, 0);
    float[] poi;
    poi = new float[2];
    poi[0] = x[index];
    poi[1] = y[index];
    this.transPoints(poi, bbox);
    ellipse(poi[0], poi[1], 4, 4);
    println(x[index]+" vs. "+poi[0]);
    
    index = index + 1;    
  }
}
void transPoints(float[] poi, float[] bbox2){ //overwrites poi, so it works as void
  float distX, distY;
  distX = bbox2[2]-bbox2[0];
  distY = bbox2[3]-bbox2[1];
  //transform the coordinates
  //Rule: X = (X-smallestX) / (Length along x-axis) * (width of picture)
  //      Y = (-Y-biggestY) / (Length along y-axis) * (heigth of picture)
  poi[0] = (poi[0]-bbox2[0]) / (distX) * width;
  poi[1] = (-poi[1] + bbox2[3]) / (distY) * height;   
  
  //return poi;
}
