float x = 240;
float y = 0;

float speed = 0;
float gravity = 0.1;  

int randY = (int) random(0, height-10);
int randX = (int) random(0, width-10);

ArrayList <Point> points = new ArrayList<Point>();

void setup() {
  size(480, 270);
  for (int i = 0; i <= random(0, 50); i++) {
    randY = (int) random(0, height-10);
    randX = (int) random(0, width-10);
    points.add(new Point(randX, randY));
  }
}

void draw() {
  background(255);
  fill(175);
  stroke(0);
  rectMode(CENTER);
  rect(x, y, 10, 10);
  y += speed;
  speed += gravity;
  if (y > height) { // <- Here, I will check for collision
    y=height;
  }
  for (int i = 0; i < points.size(); i++) {
    ellipse(points.get(i).x, points.get(i).y, 10,10);
    //if (y > points(i).width()) {
    //}
  }
}
class Point {
  int x;
  int y;

  Point(int x, int y) {
    this.x =x;
    this.y = y;
  }
}