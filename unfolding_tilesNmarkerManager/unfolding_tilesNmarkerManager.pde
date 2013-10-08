import java.util.ArrayList;
import java.util.List;
import processing.opengl.*;
import codeanticode.glgraphics.GLConstants;
import de.fhpotsdam.unfolding.Map;
import de.fhpotsdam.unfolding.geo.Location;
import de.fhpotsdam.unfolding.mapdisplay.MapDisplayFactory;
import de.fhpotsdam.unfolding.marker.Marker;
import de.fhpotsdam.unfolding.marker.MarkerManager;
import de.fhpotsdam.unfolding.providers.OpenStreetMap;
import de.fhpotsdam.unfolding.utils.MapUtils;
import de.fhpotsdam.unfolding.providers.MBTilesMapProvider;


/**
 * Simple example with two markers, managed by the MarkerManager. The markers are cut-off at the
 * border of the map.
 */
//String JDBC_CONN_STRING_TABLE = "jdbc:sqlite:/media/Speicher/Daten/mbTiles/simple_world.mbtiles";
//String JDBC_CONN_STRING_TABLE = "jdbc:sqlite:/home/ralf/Grunddaten/mbtiles/simple_world.mbtiles";
String JDBC_CONN_STRING_TABLE = "jdbc:sqlite:/home/klammer/Arbeitsfläche/neues_fur_homepage/ProcessingStuff/data/simple_world.mbtiles";

Map map;

List<Marker> markers = new ArrayList<Marker>();
MarkerManager<Marker> markerManager;

public void setup() {
  size(800, 600, GLConstants.GLGRAPHICS);
  MBTilesMapProvider mbtiles;
  mbtiles = new MBTilesMapProvider(JDBC_CONN_STRING_TABLE);
  println("test");

  map = new Map(this, 0, 0, width, height, mbtiles);
  
  map.zoomToLevel(2);
  map.panTo(new Location(40f, 20f));
  MapUtils.createDefaultEventDispatcher(this, map);

  markerManager = map.getDefaultMarkerManager();
  
  // Berlin
  PlaceMarker marker1 = new PlaceMarker();
  marker1.location = new Location(52.5f, 13.4f);  
  markerManager.addMarker(marker1);
  
  // Mexiko City
  PlaceMarker marker2 = new PlaceMarker();
  marker2.location = new Location(19.4f, -99.1f);  
  markerManager.addMarker(marker2);
  
}

public void draw() {
  background(240);
  map.draw();
}

