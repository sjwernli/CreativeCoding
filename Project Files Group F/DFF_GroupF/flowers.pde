class Flower {
  float x, y;
  float r;
  float petalRadius;
  int auswahlFarbe;
  int auswahlFarbeInnen;
  int h;
  int s;
  int b;
  int h2;
  int s2;
  int b2;
  int flowerType;
  int stampProbability;
  
  
  Flower(float x, float y, float speed) {
    this.x = x;
    this.y = y;
    r = random(5, 30);
    petalRadius = speed;
    auswahlFarbe= int(random(imgPalette_hue.length));
    auswahlFarbeInnen= int(random(imgPalette_hue.length));
    h = imgPalette_hue[auswahlFarbe];
    s = imgPalette_sat[auswahlFarbe];
    b = imgPalette_bri[auswahlFarbe];
    
    h2 = imgPalette_hue[auswahlFarbeInnen];   //---> neu Farbe für Inneres der Blume 
    s2 = imgPalette_sat[auswahlFarbeInnen];
    b2 = int((imgPalette_bri[auswahlFarbeInnen])*0.5);
    flowerType = int(random(1, 6));
    stampProbability = int(random(1,5));
  }

  void drawFlower() {
      noStroke();
      switch(flowerType){
          case 1:
            drawFlowers(x, y, r);
            break;
            
            case 2:
            drawFlowers2(x, y, r);
            break;
                        
            case 3:
            drawFlowers3(x, y, r);
            break;
                        
            case 4:
            drawFlowers4(x, y, r);
            break;
                        
            case 5:
            drawFlowers5(x, y, r);
            break;
      }
  }
  
  
  void drawFlowers(float x, float y, float r) { 
    
    if (stampProbability== 1){
        maskImage = createGraphics(img.width,img.height);
        maskImage.beginDraw();
        maskImage.ellipse(x+petalRadius/2, y, petalRadius, petalRadius);
        maskImage.ellipse(x-petalRadius/2, y, petalRadius, petalRadius);
        maskImage.ellipse(x, y+petalRadius/2, petalRadius, petalRadius);
        maskImage.ellipse(x, y-petalRadius/2, petalRadius, petalRadius);
        maskImage.endDraw();
        
        img.mask(maskImage);
        image(img, 0, 0);}
     else{
        fill(h,s,b);
        ellipse(x+petalRadius/2, y, petalRadius, petalRadius);
        ellipse(x-petalRadius/2, y, petalRadius, petalRadius);
        ellipse(x, y+petalRadius/2, petalRadius, petalRadius);
        ellipse(x, y-petalRadius/2, petalRadius, petalRadius);
     }
    fill(h2,s2,b2);
    ellipse(x, y, r, r); //Blumenmitte -> bei allen Blumen gleich
  }
  
  void drawFlowers2(float x, float y, float r) {
  if (stampProbability== 1){
      maskImage = createGraphics(img.width,img.height);
      maskImage.beginDraw();
      maskImage.ellipse(x+petalRadius, y, petalRadius+20, petalRadius);
      maskImage.ellipse(x-petalRadius, y, petalRadius+20, petalRadius);
      maskImage.ellipse(x, y+petalRadius, petalRadius, petalRadius+20);
      maskImage.ellipse(x, y-petalRadius, petalRadius, petalRadius+20);
      maskImage.endDraw();
      
      img.mask(maskImage);
      image(img, 0, 0);}
  else{
  fill(h,s,b);
  ellipse(x+petalRadius, y, petalRadius+20, petalRadius);
  ellipse(x-petalRadius, y, petalRadius+20, petalRadius);
  ellipse(x, y+petalRadius, petalRadius, petalRadius+20);
  ellipse(x, y-petalRadius, petalRadius, petalRadius+20);
  }
  fill(h2,s2,b2);
  ellipse(x, y, r, r); //Blumenmitte -> bei allen Blumen gleich
  }
  
  void drawFlowers3(float x, float y, float r) {
  //noStroke();
  // coordinates to move the center of the circle around x,y 
  float [] xval = new float[]{0, 0.5, 0.7, 0.5, -0.7, -0.5, 0, -0.5};
  float [] yval = new float[]{0.7, 0.5, 0, -0.5, 0, -0.5, -0.7, 0.5};

  fill(h,s,b);
  // makes 8 larger circles
  for (int i = 0; i<8; i++){
    // x,y are changed using the radius (r),
    // factor to move the circles slightly more outwards (1.3),
    // and the value from xval and yval
      ellipse(x+r*1.3*xval[i], y+r*1.3*yval[i], r, r);
   }
  fill(h,s,b*0,70);
  // smaller circles around the center
  for (int i = 0; i<8; i++){
      ellipse(x+r*xval[i], y+r*yval[i], r/3, r/3);
   }
   // center circle
   fill(h2,s2,b2);
   ellipse(x, y, r, r);
   }

    void drawFlowers4(float x, float y, float r) {
      fill(h,s,b);
      int numPetals = 5; // changes the number of petals, with odd numbers there will be twice as many
      for (int i = 0; i<numPetals; i++){ // if numPetals = 5, there will be 10 petals
        pushMatrix(); //rotate() hapens around (0,0)
        translate(x,y); // so the center has to be moved to the center of the flower
        rotate(radians(360*i/numPetals));
        ellipse(0, 0, r*2.5, r*2/3); // height (r*2.5) so the petal is a little more than 2x as long
        popMatrix();                 // as the inner circle radius r
       }
      fill(h2,s2,b2); // doesn't have to be white, we can change this to a random color when we have a color palette
      for (int i = 0; i<numPetals; i++){ // inner layer of petals
        pushMatrix();
        translate(x,y);
        rotate(radians(360*i/numPetals));
        ellipse(0, 0, r*2.1, r*2/3);
        popMatrix();
       }
       //center circle of flower
       fill(h2,s2,b2);
       ellipse(x, y, r, r);
    }

    void drawFlowers5(float x, float y, float r) {
      float [] xval = new float[]{0, 0.5, 0.7, 0.5, -0.7, -0.5, 0, -0.5};
      float [] yval = new float[]{0.7, 0.5, 0, -0.5, 0, -0.5, -0.7, 0.5};
      fill(255);
      for (int i = 0; i<8; i++){
          ellipse(x+r*xval[i], y+r*yval[i], r, r);
       }
       ellipse(x, y, r, r);
      
      // these circles are transparent (alpha = 70) so the previous circles
      // are drawn white to cover up the color of the background
      // and any other flowers behind it
      fill(h,s,b,70);
      for (int i = 0; i<8; i++){
          ellipse(x+r*xval[i], y+r*yval[i], r, r);
       }
       // center circle
       fill(h2,s2,b2);
       ellipse(x, y, r, r);
      
      }
}
