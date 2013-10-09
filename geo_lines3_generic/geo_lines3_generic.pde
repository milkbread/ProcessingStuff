PImage img, img2;
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

boolean[] text;
PFont f;
String text2;

void setup() {  
  //noLoop();                                     
  size(750, 500);   
  smooth();
  
  f = loadFont("LiberationMono-Bold-24.vlw");
  
  text = new boolean[5];
  
  //contents = this.readOSMDBGeneric( user,pass,database,table,condition, geometry); 
  //lines = this.readLines3(contents);            
  //bBox = this.getBboxFromLineArray(lines);
  
  this.doBackground();
  
  translate(rectx, recty);
  stroke(255);
  //this.drawLines(lines, bBox); 
  
}

void draw() { 

 if (text[0] == true){
   println(text2);
   text2 = text2 + key;
   textFont(f,18);
   fill(0);
   text(text2,2,height-20);
 }
 
  
}

void mousePressed() { 
  println(key);

  this.doSelection();
  this.doPan();
}


void doSelection(){
  if ((mouseX >= buts[0].getXMin()) && (mouseX <= buts[0].getXMax()) && (mouseY >= buts[0].getYMin()) && (mouseY <= buts[0].getYMax())) {    
    text[0] = true;
    text2 = ""+ key;
  }  
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


  
