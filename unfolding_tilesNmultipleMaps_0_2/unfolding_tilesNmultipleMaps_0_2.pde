import de.fhpotsdam.unfolding.Map;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.events.EventDispatcher;
import processing.opengl.*;
import codeanticode.glgraphics.*;
import de.fhpotsdam.unfolding.providers.StamenMapProvider;

Map mapDetail, mapOverview, mapOverviewStatic;
Location locationBerlin = new Location(52.2f, 13.4f);
Location locationLondon = new Location(51.5f, 0f);
int mapX, mapY, mapL, mapH;
void setup(){
  size(800, 600, GLConstants.GLGRAPHICS);
  mapX = 20;
  mapY = 30;
  mapL = width-50;
  mapH = height-70;
    
  //mapDetail = new de.fhpotsdam.unfolding.Map(this, mapX, mapY, mapL, mapH, new streamProvider("localhost", "vogtland_slippy_Vnet"));
  mapDetail = new de.fhpotsdam.unfolding.Map(this, mapX, mapY, mapL, mapH, new StamenMapProvider.Toner());
  mapDetail.zoomToLevel(4);
  mapDetail.setZoomRange(4, 10);
  mapDetail.panTo(locationBerlin);
  EventDispatcher eventDispatcher = MapUtils.createDefaultEventDispatcher(this, mapDetail);
  
  
  //mapOverview = new de.fhpotsdam.unfolding.Map(this, mapX, mapY, mapL, mapH, new streamProvider("localhost", "vogtland_slippy_Vnet"));
  mapOverview = new de.fhpotsdam.unfolding.Map(this, mapX, mapY, mapL, mapH, new StamenMapProvider.Toner());
  mapOverview.zoomToLevel(1);
  mapOverview.setZoomRange(1, 7);
  mapOverview.panTo(locationBerlin);
  eventDispatcher.register(mapOverview, "pan", mapDetail.getId());
  eventDispatcher.register(mapOverview, "zoom", mapDetail.getId());

  mapOverviewStatic = new Map(this, "overviewStatic", 605, 205, 185, 185);
  
 
}

void draw(){
  background(255);
  
  mapDetail.draw();
  mapOverview.draw();
  mapOverviewStatic.draw();
  
  float xyBerlin[] = mapDetail.getScreenPositionFromLocation(locationBerlin);
  fill(0, 200, 0, 100);
  if ((xyBerlin[0] >= 10) && (xyBerlin[0] <= 585) && (xyBerlin[1] >= 10) && (xyBerlin[1] <= 580)) { 
    ellipse(xyBerlin[0], xyBerlin[1], 20, 20);
  }
  this.showArea(mapDetail, mapOverview);
  this.showArea(mapDetail, mapOverviewStatic);
}
void showArea(Map mapDetail, Map mapOverview){
  Location mapBorderR, mapBorderL;
  mapBorderR = mapDetail.getBottomRightBorder();
  mapBorderL = mapDetail.getTopLeftBorder();
  float xyR[] = mapOverview.getScreenPositionFromLocation(mapBorderR);
  float xyL[] = mapOverview.getScreenPositionFromLocation(mapBorderL);
  quad(xyL[0], xyL[1], xyR[0], xyL[1], xyR[0], xyR[1], xyL[0], xyR[1]) ;
}
