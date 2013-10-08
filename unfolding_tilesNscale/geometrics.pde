class geomBBox{

  float xS, xB, yS, yB;
  
  geomBBox(float xS2, float yS2, float xB2, float yB2){
    xS = xS2;
    xB = xB2;
    yS = yS2;
    yB = yB2;
  }
  
  float getLengthH(){
    return xB-xS;
  }
  float getLengthV(){
    return yB-yS;
  }
}

class geomPoint{

  float x;
  float y;
  String[] meta;
  int i;
  
  geomPoint(float x2, float y2){
    x = x2;
    y = y2;  
    i = 0; 
    meta = new String[50];    //-->50 Values of Metainformation should be enough
  }
  
  void setX(float x2){
    x = x2;
  }
  void setY(float y2){
    y = y2; 
  }
  float getX(){
    return x;
  }
  float getY(){
    return y; 
  }
  void addMetadata(String meta2){
    meta[i] = meta2;
    i++;
  }
  void addMetaArray(String[] metaA){
    meta = metaA;
  }
  String[] getMetadata(){
    return meta;
  }
}

geomPoint simpleTransform(geomPoint poi){
  geomPoint poi2;
  float x, y;
  x = (poi.x + 180) / 360 * width;
  y = (-poi.y + 90) / 180 * height;
  poi2 = new geomPoint(x, y);
  
  return poi2;  
}
