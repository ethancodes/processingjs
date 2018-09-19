void setup() {
  size(600, 338);
  background(#323232);
  noLoop(); // only draw() once please
}

int max_mountains = 7;
int step_size = 3;
int step_range = 15;
int wander_range = 10;

color[] colors = {
  #0A122A,
  #698F3F,
  #FBFAF8,
  #E7DECD,
  #804E49
};

void draw() {
  int num_mountains = int(random(1, max_mountains));
  println(num_mountains);
  color random_color;
  
  for (int m = 1; m <= num_mountains; m++) {
    random_color = pickColor(colors);
    drawMountain(m, random_color);
  }
}

color pickColor(color[] colors) {
  int r = int(random(0, colors.length));
  return colors[r];
}

void drawMountain(int m, color c) {

  stroke(c);
  fill(c, m*10 + 128);
  
  beginShape();  
  
  int step = 0;
  int pos_chunk = height / 10;
  int current_pos = int(random(pos_chunk, pos_chunk)) * (m+3);
  vertex(step, current_pos);
  int next_step = step + step_size;
  int next_pos = current_pos;
  while (step < width) {
    next_step = step + get_next_step();
    next_pos = wander_go(current_pos);
    vertex(next_step, next_pos);
    step = next_step;;
    current_pos = next_pos;
  }
  
  vertex(width, height);
  vertex(0, height);
  
  endShape();
  
}

int get_next_step() {
  return step_size + int(random(0, step_range));
}

int wander_go(int current_pos) {
  int new_pos = current_pos + int(random(wander_range * -1, wander_range));
  
  if (new_pos < 0) {
    new_pos = 0;
  }
  if (new_pos > height) {
    new_pos = height;
  }
  
  return new_pos;
}
