
color[] colors = {
  #050505,
  #004FFF,
  #31AFD4,
  #902D41,
  #FF007F
};

int num_wanderers;
Wanderer[] wanderers;
int max_angle;
int[] angles;

void setup() {
  size(800, 450);
  background(#ffffff);
  frameRate(16);
  //noLoop();
  
  max_angle = 60;
  
  // initialize the array by telling it how big it needs to be
  num_wanderers = int(random(10, 30));
  //num_wanderers = 1;
  wanderers = new Wanderer[num_wanderers];
  
  int counting = 0;
  for (int i = 0; i < max_angle; i++) {
    for (int j = 0; j < max_angle - i; j++) {
      counting++;
    }
  }
  //println(counting);
  
  angles = new int[counting];
  counting = 0;
  for (int i = 0; i < max_angle; i++) {
    for (int j = 0; j < max_angle - i; j++) {
      angles[counting] = i;
      counting++;
    }
  }
  
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
  println("Everyone move!");
  
}

void draw() {
  
  /*
  int dist = 10;
  for (int i = 0; i < 360; i++) {
    int bearing = i;
    float bearingR = radians(bearing);
    float movex = calcNewX(dist, bearingR);
    float movey = calcNewY(dist, bearingR);
    println(bearing + " " + movex + "x" + movey);
  }
  */
  
  everyoneMoveOnce();
  saveFrame("output-####.png");
  
}

boolean everyoneMoveOnce() {
  
  boolean anyone_still_moving = false;
  int dist = 0;
  
  for (int i = 0; i < num_wanderers; i++) {
    
    Wanderer w = wanderers[i];
    if (w.canMove()) {
    
      dist = int(random(10, 30));
      float bearing = wanderAngle(w.wBearing);
      moveWanderer(w, dist, bearing);
      
    } // end if can move
    
    if (w.canMove()) {
      anyone_still_moving = true;
    }
    
  } // end foreach wanderer
  
  return anyone_still_moving;

}

void moveWanderer(Wanderer w, int dist, float bearing) {
  
  // convert bearing (in degrees) to radians SO THAT MATH WORKS
  float bearingR = radians(bearing);
  //println(bearing + " degrees is " + bearingR + " radians"); 
  
  float movex = calcNewX(dist, bearingR);
  float movey = calcNewY(dist, bearingR);

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
  
  if (newx < 0) {
    newx = 0;
  } else if (newx > width) {
    newx = width;
  }
  
  if (newy < 0) {
    newy = 0;
  } else if (newy > height) {
    newy = height;
  }
  
  
  w.draw(newx, newy, dist);

  w.move(newx, newy, bearing);
  if (!w.canMove()) {
    println("I took " + w.wNumSteps + " steps and I'm done!");
  }
  
}

float calcNewX(int dist, float angleR) {
  return dist * sin(angleR);
  
}
float calcNewY(int dist, float angleR) {
  return dist * cos(angleR);
  /*
    sin(theta) = opposite / hypotenuse
    sin(angle) = o / dist
    sin(angle) * dist = o
    */
}


float wanderAngle(float currentAngle) {
  
  float rA = randomAngle();
  float wA = currentAngle + rA;
  //print(currentAngle + " " + rA + " " + wA + " "); 
  
  if (wA < 0) {
    wA = 360 + wA;
  }
  if (wA > 360) {
    wA = wA - 360;
  }
  //println(wA);
  
  return wA;
  
}

float randomAngle() {
 
  int random_index = int(random(0, angles.length));
  int random_angle = angles[random_index];
  
  float s = random(1);
  if (s > 0.5) {
    random_angle *= -1;
  }
  
  //print(random_angle + " ");
  
  return random_angle;
  
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
    //wMaxSteps = 100;
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
  
  void draw(float newx, float newy, int dist) {
    int transparency = 128;
    stroke(wColor, transparency);
    //strokeWeight(dist / 1.5);
    line(wX, wY, newx, newy);
  }
  
}
