void drawLines(geomLine[] lin, geomBBox bbox){
  int i = 0;
  while (i < lin.length-1){
    geomPoint[] points = lin[i].getAllPoints();
    geomPoint poi, poi2;
    //prinln();
    for(int j = 0; j < points.length; j++){
      poi = transformPoint(points[j], bbox, width-rectx, height-recty);
//      println("test"+poi.y);      
      //ellipse(poi.x, poi.y, 4, 4);
      if (j != 0){
        poi2 = transformPoint(points[j-1], bbox, width-rectx, height-recty);
        line(poi.x, poi.y, poi2.x, poi2.y);      
      } 
         
    }
    i++;
  } 
}
void drawLinesAnimated(int i, geomLine[] lin, geomBBox bbox){
    geomPoint[] points = lin[i].getAllPoints();
    geomPoint poi, poi2;
    //prinln();
    for(int j = 0; j < points.length; j++){
      poi = transformPoint(points[j], bbox, width-rectx, height-recty);
//      println("test"+poi.y);      
      //ellipse(poi.x, poi.y, 4, 4);
      if (j != 0){
        poi2 = transformPoint(points[j-1], bbox, width-rectx, height-recty);
        line(poi.x, poi.y, poi2.x, poi2.y);      
      }          
    }   
}
