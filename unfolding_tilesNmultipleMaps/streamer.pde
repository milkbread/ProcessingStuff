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
