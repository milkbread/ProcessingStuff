import de.fhpotsdam.unfolding.geo.Location;
import de.fhpotsdam.unfolding.marker.AbstractMarker;

/**
 * Simple marker, implementing only the main draw method. The given x,y coordinates are already
 * converted into the local coordinate system, so no need for further conversion.
 */
class PlaceMarker extends AbstractMarker {

  public Location location;
  
  public Location getLocation() {
    return location;
  }
  
  public void draw(PGraphics pg, float x, float y) {
    pg.fill(255,100);
    pg.stroke(255);
    pg.ellipse(x, y, 50, 50);
  }
  
  public void drawOuter(PGraphics pg, float x, float y) {
  		
  }
  
  public boolean isInside(float checkX, float checkY, float x, float y) {
    return false;
  }

}
