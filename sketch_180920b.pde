
color[] colors = {
  #454ADE,
  #1B1F3B,
  #B14AED,
  #C874D9,
  #E1BBC9
};

int num_wanderers;
Wanderer[] wanderers;

void setup() {
  size(800, 450);
  background(#ffffff);
  noLoop();
  
  // initialize the array by telling it how big it needs to be
  num_wanderers = int(random(10, 30));
  //num_wanderers = 1;
  wanderers = new Wanderer[num_wanderers];
  
  print("Initializing ");
  for (int i = 0; i < num_wanderers; i++) {
    int width_chunk = width / 4;
    int height_chunk = height / 4;
    int random_x = int(random(width_chunk, width_chunk * 3));
    int random_y = int(random(height_chunk, height_chunk * 3));
    color random_color = colors[int(random(0, colors.length))];
    Wanderer w = new Wanderer(random_color, random_x, random_y, random(0, 360));
    wanderers[i] = w;
    print(".");
  }
  println();
  
}

void draw() {
  
  int dist  = 1;
  boolean done_moving = false;
  boolean anyone_still_moving = false;
  
  noStroke();
  
  while (!done_moving) {
    
    anyone_still_moving = false;

    for (int i = 0; i < num_wanderers; i++) {
      
      Wanderer w = wanderers[i];
      if (w.canMove()) {
      
        dist = int(random(1, 6));
        float bearing = wanderAngle(w.wBearing);
        moveWanderer(w, dist, bearing);
        
      } // end if can move
      
      if (w.canMove()) {
        anyone_still_moving = true;
      } else {
        println("I took " + w.wNumSteps + " steps and I'm done!");
      }
      
    } // end foreach wanderer
    
    if (!anyone_still_moving) {
      done_moving = true;
    }
  
  } // end while
  
}

void moveWanderer(Wanderer w, int dist, float bearing) {
  
  float movex = calcNewX(dist, bearing);
  float movey = calcNewY(dist, bearing);
  //println("Moving by " + dist + " > " + movex + "x" + movey);

  float newx = 0;
  float newy = 0;

  if (bearing > 180) {
    // left side
    newx = w.wX - abs(movex);
  } else {
    // right
    newx = w.wX + abs(movex);
  }

  if (bearing < 90 || bearing > 270) {
    // up
    newy = w.wY - abs(movey);
  } else {
    // down
    newy = w.wY + abs(movey);
  }

  //println("Moving to " + newx + "x" + newy);
  w.move(newx, newy, bearing);
  w.draw();
  
}

float calcNewX(int dist, float angle) {
  return dist * sin(angle);
}
float calcNewY(int dist, float angle) {
  return dist * cos(angle);
}


float wanderAngle(float currentAngle) {
  
  float rA = randomAngle();
  float wA = currentAngle + rA;
  //println(currentAngle + " " + rA + " " + wA);
  
  if (wA < 0) {
    wA = 360 + wA;
  }
  if (wA > 360) {
    wA = 360 - wA;
  }
  
  return wA;
  
}

float randomAngle() {
 
  float r = random(0, 10);
  float y = (r*r) * -1;
  y = y + 90;
  if (y > 90) {
    y = 90;
  }
  y = 90 - y;
  
  float n = random(1);
  if (n > 0.5) {
    y = y * -1;
  }
  
  return y;
  
}

class Wanderer {
  
  color wColor;
  float wX;
  float wY;
  float wBearing;
  int wMaxSteps;
  int wNumSteps;
  
  Wanderer(color c, float x, float y, float b) {
    wColor = c;
    wX = x;
    wY = y;
    wBearing = b;
    wMaxSteps = int(random(100, 1500));
    wNumSteps = 0; 
  }
  
  boolean canMove() {
    return wNumSteps < wMaxSteps;
  }
  
  void move(float newx, float newy, float bearing) {
    wX = newx;
    wY = newy;
    wBearing = bearing;
    wNumSteps++;
  }
  
  void draw() {
    //int transparency = calcTransparency();
    int transparency = 32;
    fill(wColor, transparency);
    ellipse(wX, wY, 5, 5);
  }
  
  int calcTransparency() {
    /*
      Java says an int divided by an int returns an int
      So 3 / 10 return 0 because 0.3 typecast to an int is 0
      So you have to convert your ints to floats before you math
      */
    float n = float(wNumSteps);
    float m = float(wMaxSteps);
    float d = n / m;
    d = 255 * d;
    return int(d);
  }
  
}
