private static final List<Float> DISPLAY_DISTANCES = Arrays.asList(0.01f, 0.02f, 0.05f, 0.1f, 0.2f, 0.5f, 1f, 2f,
			5f, 10f, 20f, 50f, 100f, 200f, 500f, 1000f, 2000f, 5000f);
private static final float MAX_DISPLAY_DISTANCE = 5000;


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
  stroke(255);
  strokeWeight(1);
  fill(255);
  line(x, y - 3, x, y + 3);
  line(x, y, x + dx, y);
  line(x + dx, y - 3, x + dx, y + 3);  
  text(nfs(distance, 0, 0) + " km", x + dx + 3, y + 4);
  text("Scale at "+round(startLocation.getLat())+" degree", (x + 3), (y + 4)-20);
}

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

