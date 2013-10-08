import processing.opengl.*;
import codeanticode.glgraphics.*;
import de.fhpotsdam.unfolding.providers.StamenMapProvider;
import de.fhpotsdam.unfolding.Map;
import de.fhpotsdam.unfolding.core.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.tiles.*;
import de.fhpotsdam.unfolding.geo.Location;
import de.fhpotsdam.unfolding.events.EventDispatcher;

Map map, mapOverview;
int mapX, mapY, mapL, mapH;
Location center = new Location(40.0f, 0.0f);

PImage im;
PFont f;

geomPoint[] geom;
boolean animated;
button[] buttons;
int i = 0;
int j = 0;
Location location;
int maxPointsToDraw;

void setup() {
  f = loadFont("DejaVuSans-Bold-48.vlw");
  
  size(1000, 600, GLConstants.GLGRAPHICS);
  
  //************************
  //The Unfolding elements
  mapX = mapY = 10;
  mapL = width-20;
  mapH = height-100;
  map = new Map(this, mapX, mapY, mapL, mapH, new StamenMapProvider.Toner());
  EventDispatcher eventDispatcher = MapUtils.createDefaultEventDispatcher(this, map);
  map.zoomAndPanTo(center, 2);
  map.setZoomRange(0, 8);
  
  mapOverview = new Map(this, width-170, 20, 150, 150, new StamenMapProvider.Toner());
  mapOverview.zoomAndPanTo(center, 0);
  mapOverview.setZoomRange(0, 2);
  //eventDispatcher.register(mapOverview, "pan", map.getId());
  eventDispatcher.register(mapOverview, "zoom", map.getId());
  //************************    

  geom = this.readFile(); 
  maxPointsToDraw = geom.length;
  animated = false;
  
}

void draw() {
  background(0,10);
                
  map.draw();  
  
  noStroke();
  fill(0,128);
  rect(width-180, 10, 170, 170);
  mapOverview.draw();
  this.showArea(map, mapOverview);
  
  this.legend();
  
}
//this function shows the area of the mainMap as rectangle in an overviewMap
void showArea(Map mapDetail, Map mapOverview){
  Location mapBorderR, mapBorderL;
  mapBorderR = mapDetail.getBottomRightBorder();
  mapBorderL = mapDetail.getTopLeftBorder();
  float xyR[] = mapOverview.getScreenPositionFromLocation(mapBorderR);
  float xyL[] = mapOverview.getScreenPositionFromLocation(mapBorderL);
  noStroke();
  fill(255,50);
  quad(xyL[0], xyL[1], xyR[0], xyL[1], xyR[0], xyR[1], xyL[0], xyR[1]) ;
}

//this function draws the points animatd
void drawAnimation(int i, int maxDrawPoints){  
   //j is the iterator for always drawing just a set of points...maxDrawPoints defines how many points
   if(i <= maxDrawPoints){
     j = 0;
   }else if(i > maxDrawPoints){
     j= i - maxDrawPoints;
   }
   //loop through the points and draw them
   while(j <= i){
    float x = geom[j].getX();
    float y = geom[j].getY();
    location = new Location(y, x);
    float xyScreen[] = map.getScreenPositionFromLocation(location);
    int si = graphicPointSize(float(geom[j].getMetadata()[0]));
    fill(255,0,0,128);
    stroke(255);
    //just if the point lies within the map
    if ((xyScreen[0] >= mapX) && (xyScreen[0] <= mapL) && (xyScreen[1] >= mapY) && (xyScreen[1] <= mapH)) { 
      ellipse(xyScreen[0], xyScreen[1],si,si);
    }
    j++;
  }  
}

void legend(){
  fill(255);  
  textFont(f,16);
  text("Zoomlevel "+round(map.getZoomLevel()),10,height-10);
  textFont(f,14);
  this.scaleBar();
  
  textFont(f,12);
  Location mouseCoords = map.getLocationFromScreenPosition(mouseX, mouseY);
  float xy[] = map.getScreenPositionFromLocation(mouseCoords);
  text("Lon: "+ mouseCoords.getLon() +", Lat: "+ mouseCoords.getLat(), width-230, height-10);
  float xy2[] = mapOverview.getScreenPositionFromLocation(mouseCoords);
  fill(255);
  noStroke();
  ellipse(xy2[0], xy2[1], 4,4);
  drawBarScale(width-230, height-50, mouseCoords);  

  textFont(f,24);
  textAlign(CENTER, CENTER);
  text("Scales in the Mercator-Projection", width/2, height-50);
  textFont(f,12);
  text("(Visualising the different scales in tile-based maps!)", width/2, height-25);
  textAlign(LEFT);
}

void scaleBar(){
  Location middle = map.getLocationFromScreenPosition(map.mapDisplay.getWidth()/2, map.mapDisplay.getHeight()/2);
  drawBarScale(20, height - 50, middle);  
}
