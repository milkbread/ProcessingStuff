import processing.opengl.*;
import codeanticode.glgraphics.*;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.Map;
import de.fhpotsdam.unfolding.core.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.tiles.*;
import de.fhpotsdam.unfolding.geo.Location;

Map map;
int mapX, mapY, mapL, mapH;
PImage im;

PFont f;
int xOffset;

Location center = new Location(50.5f, 12.2f);

void setup() {
  f = loadFont("DejaVuSans-Bold-48.vlw");
  
  size(850, 670, GLConstants.GLGRAPHICS);
  
  xOffset = 20;
  
  mapX = xOffset;
  mapY = 30;
  mapL = width-50;
  mapH = height-70;
  //map = new Map(this, mapX, mapY, mapL, mapH, mbtiles);
                
  map = new de.fhpotsdam.unfolding.Map(this, mapX, mapY, mapL, mapH, new streamProvider("localhost", "slippy_vogtland"));
  MapUtils.createDefaultEventDispatcher(this, map);
  //map.setZoomRange(8,12);
  map.zoomAndPanTo(center, 11);
  map.setZoomRange(0, 17);                
  
}

void draw() {
  background(160);
                
  map.draw();  
  legend();
  
}

void legend(){
  fill(255);
  textFont(f,20);
  text("Streaming TileMill - A map of the saxonian vogtland",xOffset,25);
  textFont(f,16);
  text("Zoomlevel "+round(map.getZoomLevel()),xOffset,height-10);
  
  Location mouseCoords = map.getLocationFromScreenPosition(mouseX, mouseY);
  textFont(f,12);
  text("Mouse at Lon: "+ nf(mouseCoords.getLon(), 3, 4) + "° - Lat: " + nf(mouseCoords.getLat(), 3, 4) + "°", width-300, height-10); 
   
  Location middle = map.getLocationFromScreenPosition(map.mapDisplay.getWidth()/2, map.mapDisplay.getHeight()/2);
  drawBarScale(150, height-10, middle);
     
  stroke(100,0,0);
  strokeWeight(1);
  line(width-30, map.mapDisplay.getHeight()/2+mapY, width-15, map.mapDisplay.getHeight()/2+mapY);
  line(width-15, map.mapDisplay.getHeight()/2+mapY, width-15, height-30);
  line(width-15, height-30, 480, height-30);
  stroke(100,0,0);
  singleScaleLine(width-30, map.mapDisplay.getHeight()/2+mapY, middle);
}


