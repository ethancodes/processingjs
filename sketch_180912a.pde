import java.util.concurrent.ThreadLocalRandom;

boolean run_once = true;
boolean has_run = false;



void setup() {
  size(500, 500);
  background(0);
}

void draw() {
  if (run_once && !has_run) {
  for (int j = 0; j < 100; j++) {
    int x = ThreadLocalRandom.current().nextInt(10, width - 10);
    int y = ThreadLocalRandom.current().nextInt(10, height - 10);
    int r = ThreadLocalRandom.current().nextInt(10, 100);
    drawDot(x, y, r, j);
  }
  has_run = true;
  }
  saveFrame("bubbles.png");
}

void drawDot(int x, int y, int r, int transparency) {
  float hex = percentToHex(transparency);
  stroke(153, 225, 217, hex);
  fill(153, 225, 217, hex);
  ellipse(x, y, r, r);
}

float percentToHex(int p) {
  float hex = ((float)p / 100) * 255;
  return hex; //<>// //<>//
}
