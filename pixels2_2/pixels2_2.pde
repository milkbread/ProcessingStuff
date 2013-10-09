size(255, 255);
loadPixels();  
int colour = 0;
int colour2 = 255;
// Loop through every pixel column
for (int x = 0; x < width; x++) {
  // Loop through every pixel row
  for (int y = 0; y < height; y++) {
    // Use the formula to find the 1D location
    int loc = x + y * width;
    pixels[loc] = color(colour);
    if (y == (height-1)){
      colour = colour +1;
    }   
    
    
  }
}
updatePixels(); 
