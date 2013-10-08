import processing.opengl.*;
import codeanticode.glgraphics.*;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.Map;
import de.fhpotsdam.unfolding.core.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.tiles.*;
import de.fhpotsdam.unfolding.geo.Location;
import de.fhpotsdam.unfolding.events.EventDispatcher;
import de.fhpotsdam.unfolding.providers.StamenMapProvider;


Map map, mapOverview, mapOverviewStatic;
int mapX, mapY, mapL, mapH;
PImage im;

PFont f;
int xOffset;

Location center = new Location(51.3f, 10f);

void setup() {
  f = loadFont("DejaVuSans-Bold-48.vlw");
  
  size(800, 670, GLConstants.GLGRAPHICS);
  
  xOffset = 20;
  
  mapX = xOffset;
  mapY = 30;
  mapL = width-50;
  mapH = height-70;
  //map = new Map(this, mapX, mapY, mapL, mapH, mbtiles);
                
  //map = new de.fhpotsdam.unfolding.Map(this, 10, 50, 585, 580, new streamProvider("localhost", "vogtland_slippy_Vnet"));
  map = new de.fhpotsdam.unfolding.Map(this, 10, 50, 585, 580, new StamenMapProvider.Toner());
  map.zoomAndPanTo(center, 6);
  map.setZoomRange(6, 17);  
  EventDispatcher eventDispatcher = MapUtils.createDefaultEventDispatcher(this, map);
  

  //mapOverview = new de.fhpotsdam.unfolding.Map(this, 605, 50, 185, 185, new streamProvider("localhost", "vogtland_slippy_Vnet"));
  mapOverview = new de.fhpotsdam.unfolding.Map(this, 605, 50, 185, 185, new StamenMapProvider.Toner());
  mapOverview.zoomToLevel(1);
  mapOverview.setZoomRange(1, 10);
  mapOverview.panTo(center);
  eventDispatcher.register(mapOverview, "pan", map.getId());
  eventDispatcher.register(mapOverview, "zoom", map.getId());

  //mapOverviewStatic = new de.fhpotsdam.unfolding.Map(this, 605, 255, 185, 185, new streamProvider("localhost", "vogtland_slippy_Vnet"));
  mapOverviewStatic = new de.fhpotsdam.unfolding.Map(this, 605, 255, 185, 185, new StamenMapProvider.Toner());
  
}

void draw() {
  background(160);
                
  map.draw();
  mapOverview.draw();
  mapOverviewStatic.draw();  
  legend();
  fill(255,100);
  stroke(0);
  this.showArea(map, mapOverview);
  this.showArea(map, mapOverviewStatic);
  
}

void showArea(Map mapDetail, Map mapOverview){
  Location mapBorderR, mapBorderL;
  mapBorderR = mapDetail.getBottomRightBorder();
  mapBorderL = mapDetail.getTopLeftBorder();
  float xyR[] = mapOverview.getScreenPositionFromLocation(mapBorderR);
  float xyL[] = mapOverview.getScreenPositionFromLocation(mapBorderL);
  quad(xyL[0], xyL[1], xyR[0], xyL[1], xyR[0], xyR[1], xyL[0], xyR[1]) ;
}

void legend(){
  fill(255);
  textFont(f,20);
  text("Multiple Maps - A Test",xOffset,25);
  textFont(f,16);
  text("Zoomlevel "+round(map.getZoomLevel()),xOffset,height-10);
  
  Location mouseCoords = map.getLocationFromScreenPosition(mouseX, mouseY);
  textFont(f,12);
  text("Mouse at Lon: "+ nf(mouseCoords.getLon(), 3, 4) + " - Lat: " + nf(mouseCoords.getLat(), 3, 4), width-300, height-10); 
   
  Location middle = map.getLocationFromScreenPosition(map.mapDisplay.getWidth()/2, map.mapDisplay.getHeight()/2);
  drawBarScale(150, height-10, middle);
     
  stroke(100);
  strokeWeight(1);
  //line(width-30, map.mapDisplay.getHeight()/2+mapY, width-15, map.mapDisplay.getHeight()/2+mapY);
  //line(width-15, map.mapDisplay.getHeight()/2+mapY, width-15, height-30);
  //line(width-15, height-30, 350, height-30);
  stroke(255);
  singleScaleLine(595, map.mapDisplay.getHeight()/2+mapY, middle);
}


