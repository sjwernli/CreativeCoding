class Drip{
    int x;
    int y;
    float r;
    float speed;
    float max;
    float progress;
    color currentColor;
   
    
    public Drip(int x, int y ){
        this.x= x;
        this.y= y;
        this.r= random(2,5);
        this.max= random(20,250);
        this.speed= 0;
        this.currentColor= get(x,y);
        
    }
    
    void plot(){
            noStroke();
            int ran= int(random(1,10));            // berechnet random wert der unten für die Verwacklung notwendig ist
            fill(currentColor);
            if(progress<max){
                float vorher= progress;
                progress+=random(0.5,10);          // bestimmt die Geschwindigkeit der fließenden Drops
                int steps= int (progress-vorher);  //bestimmt Anzahl zwischenstufen zwischen zwei Drip Positionen, ist für untere Rechnung wichtig
                
                if(ran==1){                        //---> Drops bewegen sich random leicht nach links oder rechts, wodurch wackelige/zittrige drips entstehen
                    x+=0.5;
                }else if (ran==2){
                    x-=0.5;}
                
                for (int i=0; i<steps;i++){
                    float a= lerp(vorher,progress,float (i)/steps);   //---> berechnet Zwischenstufen (man könnte auch "Zwischenframes" sagen) von den drops, ohne würden lücken entstehen oder die Drops nur sehr langsam fließen
                    circle(x,y+a,r);
                }
                if(progress>max-progress/10){
                    r+=1;
                }
            }
    }

}
        
