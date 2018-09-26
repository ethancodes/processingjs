PImage img;

void setup() {
  
  //img = loadImage("falcon.jpg");
  //size(600, 310);
  //img = loadImage("korolev_crater.jpg");
  //size(600, 262);
  //img = loadImage("pia22425.jpg");
  //size(600, 372);
  img = loadImage("no_file.jpg");
  size(600, 340);

  println(img.width + "x" + img.height);  
  noLoop();
  
}

color p;
color[] ps;
//color[] sorted;
int counter;

void draw() {
    
  p = #000000;
  ps = new color[img.width * img.height];
  counter = 0;
  
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      p = img.get(x, y);
      ps[counter] = p;
      counter++;
    }
  }
  println("Got color information for " + counter + " pixels");
  
  color a, b;
  
  // now sort by color
  // the way this works out white (#ffffff) is -1 
  // and black (#000000) is -16777216 
  println("Sorting...");
  for (int i = 0; i < ps.length - 1; i++) {
    for (int j = 0; j < ps.length - 1 - i; j++) {
      a = ps[j];
      b = ps[j+1];
      if (a > b) {
        ps[j] = b;
        ps[j+1] = a;
      }
    }
  }
  println("Sorted!");
  
  int x = 0;
  int y = 0;
  
  for (int i = 0; i < ps.length; i++) {
    
    stroke(ps[i]);
    point(x, y);
    
    x++;
    if (x >= img.width) {
      x = 0;
      y++;
    }
    
  }
  
  saveFrame("output.png");
  
}
