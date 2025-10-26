rm -rf /Library/Arturia/Shared/features.xml
echo "<features><product name=\"Efx AMBIENT\"><feature name=\"EngineControls\" enable=\"$1\"/></product></features>" > /Library/Arturia/Shared/features.xmlfunction setup() {
  size = 400
  sqr_size = 400/5;
  iteration = sqr_size/5;
  createCanvas(size, size);
    background(220);

  for (let x = 0; x<size; x +=sqr_size){
    for (let y = 0; y<size; y +=sqr_size){
      r = random(0, 3)
        if (r > 1){
          one(x, y);
        } else {
          two(x,y);
        }
      
      }
    }
  
  
  
}

function one(x, y){
  for (let x2 = 0; x2<sqr_size; x2+= iteration){  
          line(x, y, x+x2, y+sqr_size);}
        for (let y2 = 0; y2<sqr_size; y2+= iteration){
          line(x, y, x+sqr_size, y+y2)        
        }
}

function two(x, y){
  for (let x2 = 0; x2<sqr_size; x2+= iteration){  
          line(x+sqr_size, y+sqr_size, x-x2, y-sqr_size);}
        for (let y2 = 0; y2<sqr_size; y2+= iteration){
          line(x+sqr_size, y+sqr_size, x-sqr_size, y-y2)        
        }
}

function draw() {
}