PImage img, img2;
PFont f;
geomLine[] lines;
geomBBox bBox;
int i = 0;
String[] contents;
float rectx, recty;
int yOffset = 0;
int xOffset = 0;

button[] buts, curs;

String user     = "gisadmin";
String pass     = "tinitus";
String database = "gis";
String table = "planet_osm_roads";
String geometry = "way";
String condition = "";

void setup() {  
  contents = this.readOSMDBGeneric( user,pass,database,table,condition, geometry); 
  lines = this.readLines3(contents);            
  bBox = this.getBboxFromLineArray(lines);
  
  this.doBackground();
  
  translate(rectx, recty);
  stroke(255);
  this.drawLines(lines, bBox); 
  
}

void draw() { 
 
   /*  stroke(255);
     translate(rectx, recty);
     this.drawLinesAnimated(i, lines, bBox);  
     i++;
     if (i == lines.length-1){
       noLoop();
     }*/   
}

void mousePressed() { 
  println(key);

  this.doSelection();
  this.doPan();
}  

void doVisualization(String condition){
  String[] cont;
    cont = this.readOSMDBGeneric( user,pass,database,table,condition, geometry);
    geomLine[] lin; 
    lin = this.readLines3(cont);
    //bBox = this.getBboxFromLineArray(lin);
    stroke(0,192,0);
    translate(rectx, recty);
    this.drawLines(lin, bBox);

}

void doBackground(){
  //noLoop();                                     
  size(750, 500);
   
  smooth();
  
  //img = loadImage("vgtl-map.png");     
  //img.resize(width, height); 
  
  background(128);
  buts = this.steering();
  curs = this.pan();
  
  
  //offset of the area of visualization
  rectx = 37.5;
  recty = 25;
  
  
  //rectangle of the area where data is visualised
  stroke(0);
  line(rectx,recty,width-rectx,recty);
  line(width-rectx,recty,width-rectx,height-recty);
  line(rectx,height-recty,width-rectx,height-recty);
  line(rectx,recty,rectx,height-recty);
  
}

void doSelection(){
  if ((mouseX >= buts[0].getXMin()) && (mouseX <= buts[0].getXMax()) && (mouseY >= buts[0].getYMin()) && (mouseY <= buts[0].getYMax())) {    
    condition = "WHERE bridge = 'yes'";    
    this.doVisualization(condition);
  }
  if ((mouseX >= buts[1].getXMin()) && (mouseX <= buts[1].getXMax()) && (mouseY >= buts[1].getYMin()) && (mouseY <= buts[1].getYMax())) {
    condition = "WHERE bicycle = 'yes'";    
    this.doVisualization(condition);
  }
  if ((mouseX >= buts[2].getXMin()) && (mouseX <= buts[2].getXMax()) && (mouseY >= buts[2].getYMin()) && (mouseY <= buts[2].getYMax())) {
    condition = "WHERE highway = 'primary'";    
    this.doVisualization(condition);
  }
  if ((mouseX >= buts[3].getXMin()) && (mouseX <= buts[3].getXMax()) && (mouseY >= buts[3].getYMin()) && (mouseY <= buts[3].getYMax())) {
    condition = "WHERE highway = 'secondary'";    
    this.doVisualization(condition);
  }
  if ((mouseX >= buts[4].getXMin()) && (mouseX <= buts[4].getXMax()) && (mouseY >= buts[4].getYMin()) && (mouseY <= buts[4].getYMax())) {
    condition = "WHERE highway = 'tertiary'";    
    this.doVisualization(condition);
  }
  if ((mouseX >= buts[5].getXMin()) && (mouseX <= buts[5].getXMax()) && (mouseY >= buts[5].getYMin()) && (mouseY <= buts[5].getYMax())) {
    condition = "WHERE highway = 'residential'";    
    this.doVisualization(condition);
  }
  if ((mouseX >= buts[6].getXMin()) && (mouseX <= buts[6].getXMax()) && (mouseY >= buts[6].getYMin()) && (mouseY <= buts[6].getYMax())) {
    condition = "WHERE railway != ''";    
    this.doVisualization(condition);
  }
  if ((mouseX >= buts[7].getXMin()) && (mouseX <= buts[7].getXMax()) && (mouseY >= buts[7].getYMin()) && (mouseY <= buts[7].getYMax())) {
    condition = "WHERE highway = 'unclassified'"; 
    this.doVisualization(condition);    
  }
}

void doPan(){
  if ((mouseX >= curs[0].getXMin()) && (mouseX <= curs[0].getXMax()) && (mouseY >= curs[0].getYMin()) && (mouseY <= curs[0].getYMax())) { 
    yOffset = yOffset - 50;
    this.doPanAction(); 
  }
  if ((mouseX >= curs[1].getXMin()) && (mouseX <= curs[1].getXMax()) && (mouseY >= curs[1].getYMin()) && (mouseY <= curs[1].getYMax())) { 
    yOffset = yOffset + 50;
    this.doPanAction(); 
  }
  if ((mouseX >= curs[2].getXMin()) && (mouseX <= curs[2].getXMax()) && (mouseY >= curs[2].getYMin()) && (mouseY <= curs[2].getYMax())) { 
    xOffset = xOffset - 50;
    this.doPanAction(); 
  }
  if ((mouseX >= curs[3].getXMin()) && (mouseX <= curs[3].getXMax()) && (mouseY >= curs[3].getYMin()) && (mouseY <= curs[3].getYMax())) { 
    xOffset = xOffset + 50;
    this.doPanAction(); 
  }
  if ((mouseX >= curs[4].getXMin()) && (mouseX <= curs[4].getXMax()) && (mouseY >= curs[4].getYMin()) && (mouseY <= curs[4].getYMax())) { 
    xOffset = 0;
    yOffset = 0;
    this.doPanAction(); 
  }
}
void doPanAction(){
  this.doBackground();
  translate(rectx+xOffset, recty+yOffset);
  stroke(255);
  this.drawLines(lines, bBox);
}


  
