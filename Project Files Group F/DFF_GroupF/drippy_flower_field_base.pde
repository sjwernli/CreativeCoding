import java.util.Comparator;
import processing.video.*;
import processing.sound.*;

Capture cam;
PImage img, crop;
PGraphics maskImage;
ArrayList <Pixelcolor> pixelcolor= new ArrayList<Pixelcolor>();
int[] imgPalette_hue = new int[5];
int[] imgPalette_sat = new int[5];
int[] imgPalette_bri = new int[5];

SoundFile dripSound;
SoundFile bellSound;
boolean playingBell = false;
boolean playingSound = false;

ArrayList<Flower> flowers; //Array List für unendlich viele Blumen

color currentColor; //momentan aktive Farbe für dripping

ArrayList<Drip> drips= new ArrayList<Drip>(); //Array Liste für drips, damit sie durch draw Schleife verlangsamt herunterfließen

int time_null;
int counter;   // counter der Zeit misst
PFont font;



void setup() {
  size(800, 600);
  background(255);
  colorMode(HSB);
  font= createFont("material/LoRes12OT-Regular.ttf", 18);
  textFont(font);
  flowers = new ArrayList<Flower>();
  dripSound = new SoundFile(this, "material/splat.mp3");
  bellSound = new SoundFile(this, "material/bell.mp3");
  bellSound.amp(0.2);
  time_null = millis();
  String[] cameras = Capture.list();
  cam = new Capture(this,800,600,cameras[0]);
  cam.start();
}

void draw() {
  println(counter);
  if (counter<4){
      if (cam.available()==true){
          cam.read();}
          cameraInterface();
      if (counter>0){           //--> durch Mausklick auf "Capture Button" beginnt "counter" zu zählen was die Funktion cameraCountdown() aufruft
          cameraCountdown();
      }
  }
  else if(counter==4){
      if(cam.available()==true){
          cam.read();
      }
      takePhoto();
      

  }else{
    counter++;
    if (counter==6){
        pause();}
    if (counter==7){
        delay(3000);
        fill(255);                      
        stroke(255);                      
        rect(0,0,width,height);}
        
    if (counter<=300){
         drawingFlowers();
    }else if(counter==301) {
        pause2();
    }else if(counter==302){                      
        delay(3000);
        fill(255);                      
        stroke(255);                      
        rect(0,0,width,height);                    
        drawingFlowers();                   
    }else{
        drip();
    }
  }
}
