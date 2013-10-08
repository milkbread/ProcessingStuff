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
         http://localhost:20008/tile/slippy_vogtland/6/34/20.png?updated=1331716172000
    return new String[] { 
      url
    };
  }
}
