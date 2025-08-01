// PART 1 - Kamera____________________________________________________________________________________________________________________________________________________________________________________

void cameraInterface(){   //---> UI
    image(cam,0,0);
    noStroke();
    fill(0, 200);
    rect(0,0,800,100);
    rect(0,100,200,400);
    rect(600,100,200,400);
    rect(0,500, 800, 100);
    stroke(#EBC82C);
    noFill();
    strokeWeight(3);
    rect(200,100,400,400);
    noStroke();
    fill(#EBC82C);
    rect(300, 525, 200,50);
    fill(255);
    textAlign(CENTER);
    textSize(30);
    text("Capture!", 400, 560);
    text("Take a picture to create your colorpalette!", 400, 50);
}


void cameraCountdown(){
        noStroke();
        rect(300,525, 200, 50);
        fill(0);
        textAlign(CENTER);
        textSize(30);
        text("Capture", 400, 560);
        textAlign(CENTER,CENTER);
        fill(#EC4441);
        textSize(200);
        text(counter,400,300);      //--> Countdown
        if(millis()-time_null>1000){
            counter++;             //--> "counter" beginnt zu zählen
            time_null=millis();
        }
    }
    
void mouseClicked(){   //---> Capture Button drücken, damit Foto aufgenommen wird
    if(counter<1){
        if (mouseX<500 && mouseX>300 && mouseY>525 && mouseY<575){
            time_null=millis();
            counter++;
        }
    }
}
    
void takePhoto(){
        image(cam,0,0);
        saveFrame("material/farbpalette.jpg");
        counter++;
        img = loadImage("material/farbpalette.jpg");
        crop = img.get(200,100,400,400);
        crop.save("material/imagecrop.jpg");
        cam.stop();
        paletteGeneration();
}

// PART 2 - Blumen____________________________________________________________________________________________________________________________________________________________________________________

void drawingFlowers(){                   //-------------> Blumenzeichnen Funktion
        for (int i = 0; i < flowers.size(); i++) { //Schleife die alle Blumen zeichnet: durch die Array liste hindurch, für jede einzelne Blume die Funtktion drawFlower aufrufen
            flowers.get(i).drawFlower();      
        }
            
        if (mousePressed == true) {   //---> Sound für Blumen
            if (random(3)>1) {        //----> in 2/3 der Fälle während die Maus gedrückt wird, wird eine Blume entsprechend der Mausposition in "flowers" erstellt, gleichzeitig wird ein Ton abgespielt
                variableFlowers(mouseX, mouseY, pmouseX, pmouseY);
                
                if (random(2)>1) {        
                float speed = dist(mouseX, mouseY, pmouseX, pmouseY); 
                float pitch = map(speed, 0, 10, 0.5, 0.8); //--> Pitch abhängig von Mausgeschwindigkeit: Tiefster Pitch ist 0.8, föngt an bei keiner Bewegung und steigt mit der geschwindigkeit

                bellSound.rate(pitch); // ----> Wiedergabegeschwindigkeit des Sound um Töhnhöhe zu manipulieren --> Mit pitch als rate ist der Sound interaktiv verknüpft mit der Maus               
                
                if(!playingBell) {
                  bellSound.play();
                  playingBell = true;
                }       
            }
            else {
              playingBell = false;
            }         
          }
        }
}



void variableFlowers(int x, int y, int px, int py) { //-------------> Blumenerstellungsfunktion
  float speed = abs(x-px) + abs(y-py);               
  stroke (speed);                                    // Blumengröße abhängig von Geschwindigkeit des Mauszeigers, obere Grenze 50, untere Grenze 7
  if (speed >= 50) {
    speed = 50;
  }
   else if (speed < 7) {
     speed = 7;
  } 
  flowers.add(new Flower(x+random(50), y+random(50),speed)); //----> Speicherung aller Blumen in ArrayListe
}


// PART 3 - Dripping____________________________________________________________________________________________________________________________________________________________________________________

void drip(){                                           //-----> Dripping Funktion
    for (int i=0; i<drips.size(); i++){
        drips.get(i).plot();                          //alle "drip" Objekte aus Array Liste werden jede draw Schleife neu gezeichnet -> durch Berechnungen in plot() verfließen sie
    }
    if (mousePressed==true && mouseY>0 && mouseX>0 && mouseY<height && mouseX<width){
        drips.add(new Drip(mouseX,mouseY));          // durch Mausklick wird neues "drip" Objekt erstellt
        
             if (!playingSound){     //wenn sound nicht spielt soll er einmal beim maus click abgespielt werden
            dripSound.loop();   
            playingSound = true;
    }
        }
        else { // sound spielt nichtmehr wenn mouse nicht gedrückt ist
          dripSound.stop();  
          playingSound = false;
  }
}


// sonstiges____________________________________________________________________________________________________________________________________________________________________________________

void pause(){        //------------> Übergangs Animation                      
    fill(255);
    rect(0,0,width,height);
    fill(0,0,0,200);
    rect(0,0,width,height);
    textSize(30);
    fill(255);
    textAlign(CENTER,CENTER);
    text("Draw on the canvas to create a flowerfield!", width/2, height/2); 
}

void pause2(){        //------------> Übergangs Animation 2                     
    fill(0,0,0,200);
    rect(0,0,width,height);
    textSize(30);
    fill(255);
    textAlign(CENTER,CENTER);
    text("Now give the flowers some drip!", width/2, height/2); 
}

void keyPressed(){                 //------> Save und Neustart Funktion
    if (key=='s'){
        save("flowerfield_images/drippy_"+month()+day()+"_"+ hour() + minute() + second() + ".jpg");
        fill(255);
        stroke(255);
        rect(0,0,width,height);
        counter=0;
        time_null=millis();
        flowers.clear();
        pixelcolor.clear();
        cam.start();  
    }
}
