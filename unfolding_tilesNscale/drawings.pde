

int graphicPointSize(float value){
  int si = int(((value*value*value)/16));
  return si;
}


class button{

  float x, y, wid, heig;
  String name;
  
  button(float x2, float y2, float w, float h, String name2){
    x = x2;
    y = y2;
    wid = w;
    heig = h;
    name = name2;
    stroke(255); 
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

button[] animateB(boolean animate) {

  PFont f;
  f = loadFont("DejaVuSans-Bold-48.vlw");
  
  //draw the animate button
  button[] buts;
  buts = new button[2];
  int butH = 30;
  int butL = 100;
  fill(0);
  buts[0] = new button(200,height-butH,butL,butH,"Animate");
  fill(255);  
  textFont(f,16);
  if (animate == true) {           //the textchange for clicking on the animate/stop button     
    text("Stop",buts[0].getXMin()+20,buts[0].getYMin()+17); 
  } 
  else{
    text(buts[0].buttonName(),buts[0].getXMin()+10,buts[0].getYMin()+17); 
  }
 
  //draw the reset Animation button
  fill(0);
  stroke(255);
  buts[1] = new button(300,height-butH,butL,butH,"Reset Animation");
  textFont(f,10);
  fill(255);
  text(buts[1].buttonName(),buts[1].getXMin()+5,buts[1].getYMin()+13);      

  return buts;
}


