//simple example for demonstrating the use of unfolging MBTilesMapProvider
//I had a problem with the sqlitejdbc-library
//-- so I had to add the sqlitejdbc.jar to the lib diectory of unfolding
//(../processing_sketchdirectory/libraries/Unfolding/library)

import processing.opengl.*;
import codeanticode.glgraphics.*;
import de.fhpotsdam.unfolding.providers.MBTilesMapProvider;
import de.fhpotsdam.unfolding.Map;
import de.fhpotsdam.unfolding.core.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.tiles.*;
import de.fhpotsdam.unfolding.geo.Location;

//!!!I'm sure you have to modify this string ... the data is also at GitHub!!!
String JDBC_CONN_STRING_TABLE = "jdbc:sqlite:/home/klammer/Arbeitsfläche/neues_fur_homepage/ProcessingStuff/data/simple_world.mbtiles";
//String test = "jdbc:sqlite:"+dataPath("")+"simple_world.mbtiles";

Map map;
PImage im;

PFont f;

Location center = new Location(51.3f, 10f);

void setup() {
  
  f = loadFont("DejaVuSans-Bold-48.vlw");
  
  size(800, 600, GLConstants.GLGRAPHICS);
  MBTilesMapProvider mbtiles;
  mbtiles = new MBTilesMapProvider(JDBC_CONN_STRING_TABLE);
  println(new MBTilesMapProvider(JDBC_CONN_STRING_TABLE));
                
  map = new Map(this, 0, 0, width, height, mbtiles);
  MapUtils.createDefaultEventDispatcher(this, map);
  //map.setZoomRange(8,12);
  map.zoomAndPanTo(center, 6);
  map.setZoomRange(0, 15);                
  
}

void draw() {
  background(128);
                
  map.draw();
  
  float xyCenter[] = map.getScreenPositionFromLocation(center);
  fill(255, 0, 0, 10);
  stroke(255,10);
  ellipse(xyCenter[0], xyCenter[1], 8, 8);
  
  fill(255);
  textFont(f,20);
  fill(128);  
  text("Using mbtiles - a first test",10,20);
  textFont(f,16);
  text("Zoomlevel "+round(map.getZoomLevel()),10,height-10);
  
  Location location = map.getLocationFromScreenPosition(mouseX, mouseY);
  textFont(f,12);
  text(location.toString(), width-120, height-10);  
  
}


