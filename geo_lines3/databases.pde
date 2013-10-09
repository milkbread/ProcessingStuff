String[] readDB()
{
  import de.bezier.data.sql.*;  

  String user     = "gisadmin";
  String pass     = "tinitus";
  String database = "meingis";
  
  PostgreSQL pgsql;  
  pgsql = new PostgreSQL( this, "localhost", database, user, pass );
  String[] lines;
  int i = 0;
  int dbSize = 0;
  String[] query;
  query = new String[3];
  query[0] = "SELECT COUNT(*) ";
  query[1] = "SELECT *, asewkt(way) as way2 ";
  query[2] = "FROM planet_osm_roads";
  //query[2] = "FROM planet_osm_line WHERE boundary = 'administrative'";
    
  // connected?
  if (pgsql.connect()){
    pgsql.query( query[0]+query[2] );
    pgsql.next();
    dbSize = pgsql.getInt(1);
    println(dbSize);
    lines = new String[dbSize];
    pgsql.query( query[1]+query[2] );
    //println(pgsql.);
    println("Connected to "+database);
    while( pgsql.next() ){
      //println( pgsql.getString("way2") );
      lines[i] = pgsql.getString("way2");
      //println(lines[i]);
      i++;
    }
  } else{
    println("Connection failed!");
    lines = new String[0];
  }
  
  return lines;
}

String[] readOSMDBGeneric( String user, String pass, String database, String table, String condition, String geometry)
{
  import de.bezier.data.sql.*;  

  //String user     = "gisadmin";
  //String pass     = "tinitus";
  //String database = "gis";
  println("aha");
  PostgreSQL pgsql;  
  pgsql = new PostgreSQL( this, "localhost", database, user, pass );
  String[] lines;
  int i = 0;
  int dbSize = 0;
  String[] query;
  query = new String[3];
  query[0] = "SELECT COUNT(*) ";
  query[1] = "SELECT *, asewkt("+geometry+") as way2 ";
  query[2] = "FROM " + table + " "+ condition;
  println(query[1]+query[2]);
  
  // connected?
  if (pgsql.connect()){
    pgsql.query( query[0]+query[2] );
    pgsql.next();
    dbSize = pgsql.getInt(1);
    println(dbSize);
    lines = new String[dbSize];
    pgsql.query( query[1]+query[2] );
    //println(pgsql.);
    println("Connected to "+database);
    while( pgsql.next() ){
      //println( pgsql.getString("way2") );
      lines[i] = pgsql.getString("way2");
      println(lines[i]);
      i++;
    }
  } else{
    println("Connection failed!");
    lines = new String[0];
  }
  
  return lines;
}
