float x = 240; //x position of the player
float y = 80; //y position of the player 
float ythrust = 0;
float ythrustCoefficient = 0.2;
float xthrust = 0;
float xthrustCoefficient = 0.2;
float gravity = 0.1;  
float gravityCoefficient = 0.1;
float thrust = .2;
float rotate = 0;
float degrees;

int xi = 0;
int randY = (int) random(0, height-10);
int randX = (int) random(0, width-10);
int rand1 = (int) random(0, 255);
int rand2 = (int) random(0, 255);
int rand3 = (int) random(0, 255);
int rand4 = (int) random(0, 255);
int rand5 = (int) random(0, 255);
int rand6 = (int) random(0, 255);

boolean willRotate = false;

ArrayList <Point> points = new ArrayList<Point>();
ArrayList <LandingPad> landingPad = new ArrayList<LandingPad>();

void setup() {
  size(480, 270);
  for (int i = 0; i <= random(0, 50); i++) {
    randY = (int) random(0, height-10);
    randX = (int) random(0, width-10);
    points.add(new Point(randX, randY));
  }
  for (int i = 0; i <= 1; i += (int) random(0, 5)) {
    randY = (int) random(height/4, height-10);
    randX = (int) random(0, width-50);
    landingPad.add(new LandingPad(randX, randY));
  }
}

void draw() {
  background(255);
  fill(175);
  stroke(0);
  pushMatrix();
  translate(x+5, y+5);
  rotate(rotate);
  //Starting position of the rocket
  rect(-5, -5, 10, 10);
  popMatrix();
  //rotate*1/(2(PI)) = degrees
  fill(random(rand1, rand2), random(rand3, rand4), random(rand5, rand6));
  for (int i = 0; i < points.size(); i++) {
    ellipse(points.get(i).x, points.get(i).y, 10, 10);
  }
  
  gravity += gravityCoefficient;
  y += gravity;
  println("5*cos: " + 5*cos(rotate) + ", 5*sin: " + 5*sin(rotate));
  if (keyPressed == true && key == 'w') {
    
    ythrustCoefficient = 0.1;
    xthrustCoefficient = 0.1;
    
    ythrustCoefficient += 0.2;
    xthrustCoefficient += 0.2;
    ythrust = ythrustCoefficient*cos(rotate);
    xthrust = xthrustCoefficient*sin(rotate);
    x += xthrust;
    y -= ythrust;
    gravityCoefficient = 0;
    
  } if (keyPressed == true && key == 'a') {

    willRotate = true;
    rotate -= 0.05;
    
  } if (keyPressed == true && key == 'd') {

    willRotate = true;
    rotate += 0.05;
    
  } if (key != 'w') {
    ythrustCoefficient = 0;
    xthrustCoefficient = 0;
    ythrust = 0;
    xthrust = 0;
  }
  if (y > height) { // <- Here, I will check for collision
    y=height;
  }
  fill(0, 255, 0);
  for (int i = 0; i < 1; i += (int) random(0, 5)) {
    rect(landingPad.get(i).x, landingPad.get(i).y, 50, 10);
    if (x+10<=landingPad.get(i).x && x+10<=landingPad.get(i).x+50 && y+10<=landingPad.get(i).y && y+10 >= landingPad.get(i).y+10) {
      y=landingPad.get(i).y;
    }
  }
}
class Point {
  int x;
  int y;

  Point(int x, int y) {
    this.x = x;
    this.y = y;
  }
}
class LandingPad {
  int x;
  int y;

  LandingPad(int x, int y) {
    this.x = x;
    this.y = y;
  }
}