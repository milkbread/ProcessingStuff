import java.util.Arrays;
import java.util.List;
import processing.opengl.*;
import codeanticode.glgraphics.GLConstants;
import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.Location;
import de.fhpotsdam.unfolding.utils.GeoUtils;
import de.fhpotsdam.unfolding.utils.MapUtils;
import de.fhpotsdam.unfolding.providers.StamenMapProvider;

private static final List<Float> DISPLAY_DISTANCES = Arrays.asList(0.01f, 0.02f, 0.05f, 0.1f, 0.2f, 0.5f, 1f, 2f,
			5f, 10f, 20f, 50f, 100f, 200f, 500f, 1000f, 2000f, 5000f);
private static final float MAX_DISPLAY_DISTANCE = 5000;

UnfoldingMap map;

PFont f;

public void setup() {
  size(600, 400, GLConstants.GLGRAPHICS);
  
   map = new UnfoldingMap(this, new StamenMapProvider.Toner());
  
  MapUtils.createDefaultEventDispatcher(this, map);
  
  map.zoomAndPanTo(new Location(52, 13), 2);

  textFont(createFont("Sans-Serif", 10));
  f = loadFont("DejaVuSans-Bold-48.vlw");
    
}

public void draw() {
  background(0);

  map.draw();

  // Show bar scale at left bottom
  Location startLocation1 = new Location(0, 0);
  Location startLocation2 = new Location(-45, 0);
  Location startLocation3 = new Location(-22.5, 0);
  float hm = map.mapDisplay.getHeight()-((map.mapDisplay.getHeight() / 2)/2);
    
  drawBarScale(20, map.mapDisplay.getHeight() / 2, startLocation1);
  drawBarScale(20, map.mapDisplay.getHeight() - 20, startLocation2);
  drawBarScale(20, map.mapDisplay.getHeight()-(map.mapDisplay.getHeight() / 2)/2, startLocation3);

  Location middle = map.getLocationFromScreenPosition(width/2, height/2);
  drawBarScale(map.mapDisplay.getHeight(), map.mapDisplay.getHeight() / 2, middle);
}

/**
 * Draws a bar scale at given position according to current zoom level.
 * 
 * Calculates distance at equator (scale is dependent on Latitude). Uses a distance to display
 * from fixed set of distance numbers, so length of bar may vary.
 * 
 * @param x
 *            Position to display bar scale
 * @param y
 *            Position to display bar scale
 */
public void drawBarScale(float x, float y, Location startLocation) {

  // Distance in km, appropriate to current zoom
  float distance = MAX_DISPLAY_DISTANCE / map.getZoom();
  distance = getClosestDistance(distance);
  
  // Gets destLocation (world center, on equator, with calculated distance)
  //Location startLocation = new Location(0, 0);
  Location destLocation = GeoUtils.getDestinationLocation(startLocation, 90f, distance);

  // Calculates distance between both locations in screen coordinates
  float[] destXY = map.getScreenPositionFromLocation(destLocation);
  float[] startXY = map.getScreenPositionFromLocation(startLocation);
  float dx = destXY[0] - startXY[0];

  // Display
  stroke(150,150,150);
  strokeWeight(1);
  fill(150,150,150);
  line(x, y - 3, x, y + 3);
  line(x, y, x + dx, y);
  line(x + dx, y - 3, x + dx, y + 3);  
  text(nfs(distance, 0, 0) + " km", x + dx + 3, y + 4);
  text("Scale at "+startLocation.getLat()+" degree", (x + 3), (y + 4)-20);
  
  fill(255,0,0);
  textFont(f,24);
  textAlign(CENTER, CENTER);
  text("Scales in tile-based maps", width/2, 25);
  textFont(f,12);
  text("(Simple calculations and scale lines!)", width/2,45);
  textAlign(LEFT);
}

/**
 * Returns the nearest distance to display as well as to use for calculation.
 * 
 * @param distance
 *            The original distance
 * @return A distance from the set of {@link DISPLAY_DISTANCES}
 */
public float getClosestDistance(float distance) {
  return closest(distance, DISPLAY_DISTANCES);
}

public float closest(float of, List<Float> in) {
  float min = Float.MAX_VALUE;
  float closest = of;

  for (float v : in) {
    final float diff = Math.abs(v - of);

    if (diff < min) {
      min = diff;
      closest = v;
    }
  }

  return closest;
}


