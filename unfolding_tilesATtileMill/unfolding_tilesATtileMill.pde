//Source: https://forum.processing.org/topic/unfolding-maps-streaming-tilemill-hack-howto
/*This is a simple example on
HOW TO REQUEST MAP TILES DIRECTLY FROM TileMill
Therefore, TileMill has to be 'open' and...
*/

import processing.opengl.*;
import codeanticode.glgraphics.*;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.Map;
import de.fhpotsdam.unfolding.core.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.tiles.*;
import de.fhpotsdam.unfolding.geo.Location;

Map map;
PImage im;

PFont f;

Location center = new Location(40f, 0f);

void setup() {
  f = loadFont("DejaVuSans-Bold-48.vlw");
  
  size(800, 600, GLConstants.GLGRAPHICS);
         
  //...you have to set the correct name of the mapping project     
  //map = new de.fhpotsdam.unfolding.Map(this, new streamProvider("localhost", "geography-class"));
  map = new de.fhpotsdam.unfolding.Map(this, new streamProvider("localhost", "old_map"));
  MapUtils.createDefaultEventDispatcher(this, map);
  map.zoomAndPanTo(center, 2);
                
}

void draw() {
  background(128);
                
  map.draw();   
  
}

class streamProvider extends MapBox.MapBoxProvider {
  String hostname, mapname;

  streamProvider(String _hostname, String _mapname) {
    hostname = _hostname;
    mapname = _mapname;
  }

  public String getZoomString(Coordinate coordinate) {
    return (int) coordinate.zoom + "/" + (int) coordinate.column + "/" + (int) coordinate.row;
  }

  public String[] getTileUrls(Coordinate coordinate) {
    String url = "http://"+hostname+":20008/tile/"+mapname+"/"
      + getZoomString(coordinate) + ".png?updated=" + int(random(0, 10000));
         
    return new String[] { 
      url
    };
  }
}
