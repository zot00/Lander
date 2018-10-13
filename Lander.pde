
float x = 240; //x position of the player
float y = 80; //y position of the player 
float ythrust = 0; //the thrust in the y direction
float ythrustCoefficient = 1; // ? \\
float xthrust = 0; //the thrust in the x direction
float xthrustCoefficient = 1; // ? \\
float gravity = 0.1; //gravity affecting the player's bot
float gravityCoefficient = 0.1; // ? \\
float velocity = 0; //the speed of acceleration
float velocityCoefficient = 0.2; // ? \\
float rotate = 0; //placeholder of how much the robot rotates
float degrees; //the amount of degrees to rotate

int randY = (int) random(0, height-10); //controls the y values of the obstacles & landing pad
int randX = (int) random(0, width-10); //controls the x values of the obstacles & landing pad
int rand1 = (int) random(0, 255); //partially controls the colors of the obstacles
int rand2 = (int) random(0, 255); //partially controls the colors of the obstacles
int rand3 = (int) random(0, 255); //partially controls the colors of the obstacles
int rand4 = (int) random(0, 255); //partially controls the colors of the obstacles
int rand5 = (int) random(0, 255); //partially controls the colors of the obstacles
int rand6 = (int) random(0, 255); //partially controls the colors of the obstacles

boolean willRotate = false; //determines if the player will rotate

ArrayList <Point> points = new ArrayList<Point>(); //controls how many obstacles there are and their positions
ArrayList <LandingPad> landingPad = new ArrayList<LandingPad>(); //controls the position of the landing pad

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

  if (gravity >= 10) {
    gravity = 10;
  }
  y -= ythrust;
  if (keyPressed == true && key == 'w') {
    //ythrust += ythrustCoefficient;
    //xthrust += xthrustCoefficient;
    ythrust -= cos(rotate)*ythrustCoefficient;
    xthrust -= sin(rotate);
    x += xthrust;
    print("(" + xthrust + ", " + ythrust + ")");
  } else {
    xthrustCoefficient -= 0.1;
    if (ythrust > 0) {
      ythrust -= 0.1;
    } 
    if (xthrust > 0) {
      xthrust -= 0.1;
    }
  }
  if (keyPressed == true && key == 'a') {
    willRotate = true;
    rotate -= 0.05;
  } 
  if (keyPressed == true && key == 'd') {
    willRotate = true;
    rotate += 0.05;
  }
  if (y > height) { // <- Here, I will check for collision
    y=height-40;
  }
  if (x > width) {
    x= width;
  }
  if (x<0) {
    x=0;
  }
  if (y<0) {
    y=0;
  }
  fill(0, 255, 0);
  for (int i = 0; i < 1; i += (int) random(0, 5)) {
    rect(landingPad.get(i).x, landingPad.get(i).y, 50, 10);
    if (x+10<=landingPad.get(i).x && x+10<=landingPad.get(i).x+50 && y+10<=landingPad.get(i).y && y+10 >= landingPad.get(i).y+10) {
      y=landingPad.get(i).y;
    }
  }
}
void keyReleased() {
  if (key == 'w') {
    gravity = 1;
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