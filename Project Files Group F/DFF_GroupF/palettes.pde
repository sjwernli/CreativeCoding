class Pixelcolor{
    int hue;
    int sat;
    int bri;
    int frequency;
    
    Pixelcolor(int hue, int sat, int bri){
        this.hue=hue;
        this.sat=sat;
        this.bri=bri;
        this.frequency=1;
    }
    void increment(){
        frequency++;
    }
    
    boolean equalsColor(int other_hue,int other_sat,int other_bri){
        int h2 = other_hue;
        int s2 = other_sat;
        int b2 = other_bri;
        
        float dist= sq(hue-h2)+sq(sat-s2)+sq(bri-b2);         //--> es wird überprüft ob Farben gleich, bzw. ähnlich sind. 
        return dist<1000;                                    // --> Schwellwert damit nicht zu ähnliche Farben bei der Farbpalette rauskommen
    }
}
  
    
public void paletteGeneration(){
        
    crop=loadImage("material/imagecrop.jpg");
    crop.loadPixels();  
    
    for (int i=0; i<crop.pixels.length;i++){
        int pixel = crop.pixels[i];
        int hue = int(hue(pixel));
        int sat = int(saturation(pixel));
        int bri = int(brightness(pixel));
        boolean found = false;
        
        for (Pixelcolor j: pixelcolor){                    //---> for-each loop; für jeden Pixel wird pixelcolor durchgegangen und verglichen bzw. erweitert
            if (j.equalsColor(hue,sat,bri)){
                j.increment();
                found=true;
                break;
            }    
            }if(!found){
                pixelcolor.add(new Pixelcolor(hue,sat,bri)) ;  
            }
        }
   
   pixelcolor.sort(new Comparator<Pixelcolor>() {                  //---> Klasse wird beim Aufruf erstellt, impelementierung von Interface Comparator
    public int compare(Pixelcolor a, Pixelcolor b) {
      return b.frequency - a.frequency;                            // wenn negativ kommt a zuerst
    }
  });
    
    for(int i=0; i<min(5,pixelcolor.size()); i++){
        imgPalette_bri[i] = int(pixelcolor.get(i).bri*1.2);
        imgPalette_sat[i] = int(pixelcolor.get(i).sat*1.5);        //-----> Sättigung kann hier geändert werden
        imgPalette_hue[i] = pixelcolor.get(i).hue;
     
}
println("palette complete");

}


   
