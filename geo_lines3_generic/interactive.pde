class button{

  float x, y, wid, heig;
  String name;
  
  button(float x2, float y2, float w, float h, String name2){
    x = x2;
    y = y2;
    wid = w;
    heig = h;
    name = name2;
    rect(x,y,wid,heig);
  }
  
  float getXMin(){
    return x;
  }
  float getXMax(){
    return x+wid;
  }
  float getYMin(){
    return y;
  }
  float getYMax(){
    return y+heig;
  }
  float getWidth(){
    return wid;
  }
  float getHeigth(){
    return heig;
  }
  String buttonName(){
    return name;
  }
}

button[] pan(){
  button[] buts;
  buts = new button[5];
  
  fill(0);
  stroke(255);
  buts[0] = new button(15,40,10,10,"up");
  buts[1] = new button(15,60,10,10,"down");
  buts[2] = new button(5,50,10,10,"right");
  buts[3] = new button(25,50,10,10,"center");
  fill(255);
  stroke(0);
  buts[4] = new button(15,50,10,10,"up");

  return buts;
}

button[] steering(){
  PFont f;
  f = loadFont("LiberationMono-Bold-24.vlw");
  
  //main text
  textFont(f,18);
  fill(0);
  text("Quick Datavisualization",2,20);
  
  //draw the buttons of the legend
  fill(200);
  noStroke();  
  
  button[] buts;
  buts = new button[8];
  int bw, bh;
  bw = 60;
  bh = 25;
  
  //draw the buttons
  fill(0);
  stroke(255);
  buts[0] = new button(0,height-20,75,20,"user");
  textFont(f,10);
  fill(255);
  text(buts[0].buttonName(),buts[0].getXMin()+5,buts[0].getYMin()-2);
  
  
  return buts;
  
}

button animateB(boolean animate) {

  PFont f;
  f = loadFont("LiberationMono-Bold-24.vlw");
  
  //draw the animate button
  button but;
  fill(0);
  but = new button(300,height-20,50,20,"Animate");
  //rect(550,height-50,50,20);
  fill(255);   
  textFont(f,10);
  if (animate == true) {           //the textchange for clicking on the animate/stop button     
    text("Stop",but.getXMin()+10,but.getYMin()+13); 
    //text("Stop",560,height-37);
  } 
  else{
    text(but.buttonName(),but.getXMin()+4,but.getYMin()+13); 
    //text("Animate",554,height-37);
  } 

  return but;
}
