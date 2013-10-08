//this first tutorial relys on the Tutorial-slideshow 
//(beginning with Slide53) from on this site: http://unfoldingmaps.org/

import de.fhpotsdam.unfolding.Map;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;
import processing.opengl.*;
import codeanticode.glgraphics.*;

Map map;

Location locationBerlin = new Location(52.2f, 13.4f);
Location locationLondon = new Location(51.5f, 0f);

void setup(){
  size(800, 600, GLConstants.GLGRAPHICS);
  
  map = new Map(this);
  map.zoomAndPanTo(new Location(51.049259f, 13.73836f),5);
  
  MapUtils.createDefaultEventDispatcher(this, map);

}

void draw(){
  background(0);
  map.draw();
  
  fill(100, 100);
  noStroke();
  ellipse(mouseX, mouseY, 80, 80);  
  fill(0);
  ellipse(mouseX, mouseY, 2, 2);
  
  Location location = map.getLocationFromScreenPosition(mouseX, mouseY);
  text(location.toString(), mouseX+45, mouseY);
  
  float xy[] = map.getScreenPositionFromLocation(location);
  fill(215, 0 , 0, 100);
  ellipse(xy[0], xy[1], 20, 20);
  
    
  float xyBerlin[] = map.getScreenPositionFromLocation(locationBerlin);
  fill(0, 200, 0, 100);
  ellipse(xyBerlin[0], xyBerlin[1], 20, 20);

}
