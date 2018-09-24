

int lineTop, lineBottom, lineHeight;
int charWidth;
int leftSide, rightSide;
int lastX, lastY, currentX, currentY, nextX, nextY;
int pressure;

void setup() {
  
  size(1000, 400);
  background(#fafafa);
  frameRate(10);
  noFill();
  
  lineTop = 100;
  lineBottom = 200;
  lineHeight = lineBottom - lineTop;
  charWidth = lineHeight / 4;
  currentX = 10;
  currentY = int(random(lineTop, lineBottom));
  lastX = currentX;
  lastY = currentY;
  leftSide = currentX;
  rightSide = width - currentX;
  pressure = 1;
  
  stroke(255, 102, 0, 64);
  line(leftSide, lineTop, rightSide, lineTop);
  line(leftSide, lineBottom, rightSide, lineBottom);
  
  drawPoint(currentX, currentY);
  
}

void draw() {
  
  // randomly make this white so that it looks like a space
  int whiteSpace = int(random(0, 8));
  if (whiteSpace <= 1) {
    charWidth = int(random(lineHeight / 10, lineHeight / 2));
    currentX += charWidth;
  }
  
  
  if (currentX >= rightSide) return;
  
  // randomize the width of this character
  charWidth = int(random(lineHeight / 10, lineHeight / 2));
  
  nextX = currentX + int(random(1, charWidth));
  nextY = int(random(lineTop, lineBottom));
  
  int rand1X = int(random(currentX - charWidth, nextX + charWidth));
  int rand1Y = int(random(lineTop, lineBottom));
  int rand2X = int(random(currentX - charWidth, nextX + charWidth));
  int rand2Y = int(random(lineTop, lineBottom));
  
  stroke(#323234);
  
  if (nextY > currentY) {
    pressure = int(random(3, 5));
  } else if (pressure > 1) {
    pressure--;
  }
  strokeWeight(pressure);
  
  bezier(
    currentX, currentY,
    lastX, lastY,
    rand1X, rand1Y,
    nextX, nextY
  );
  // heck yes!
  
  /*
  bezier(
    currentX, currentY,
    lastX, lastY,
    nextX, nextY,
    rand1X, rand1Y
  );
  // pretty damn cool
  */  
  
  /*
  curve(
    rand1X, rand1Y,
    currentX, currentY,
    nextX, nextY,
    rand2X, rand2Y
  );
  // nice
  */
  
  /*
  curve(
    lastX, lastY,
    currentX, currentY,
    nextX, nextY,
    currentX, currentY
  );
  // not bad
  */  
  
  
  drawPoint(nextX, nextY);
  
  lastX = currentX;
  lastY = currentY;
  currentX = nextX;
  currentY = nextY;
  
  saveFrame("output-####.png");
    
}

void drawPoint(int x, int y) {

  stroke(255, 102, 0, 64);
  ellipse(x, y, 5, 5);
  
}
