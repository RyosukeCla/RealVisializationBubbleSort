/* =========== Bubble Sort and Physics ============
 *  
 *  @author  Ryosuke Suzuki
 *  @version 1.2
 *  @since   2015-07-04
 *
 *  --- big update 1.2(2015-07-07-01:46) --
 *  * add new background
 *    |_ space shuttle will apears when sort
 *    |  finished
 *    |_ "Penguin X3-44" and "TIE"
 *  ---------------------------------------
 *  --- update 1.1.2(2015-07-06-12:30) ----
 *  * more better UserInterface
 *  ---------------------------------------
 *  --- update 1.1.1(2015-07-06-01:28) ----
 *  * more easier to see characters
 *    |_ "bigger" and "smaller"
 *  ---------------------------------------
 *  --- big update 1.1(2015-07-05-21:04) --
 *  * add new background
 *    |_ starry sky - move -
 *       |_ stars and planets
 *          |_ twinkling
 *  * change ball's color - more matchable
 *  ---------------------------------------
 *  
 *  ================================================
 */

int numberBalls = 0;
float g = 0.5;
float e = 0.5;
float s = 0.2;
float f = 0.983;
float frameColor;
int maxNumber = 5;

ArrayList<Ball> balls;
int ballNumber;

boolean stringButton;
boolean startButton;
boolean helpButton;

float time;
int floorNum;
int ballNum;
boolean floorPlus;
int calculationFrequency;

Planet[] stars = new Planet[1000];
Planet[] planets = new Planet[8];
float skyTimeStars;
float skyTimePlanets;

Shuttle spaceShuttle;
Shuttle[] enemyShuttles = new Shuttle[3];
Beam[] beams = new Beam[15];
float shuTime;
boolean startShu;


void setup() {
  size(300, 700);
  textAlign(CENTER, CENTER);
  initializer();
  stringButton = false;
  helpButton = false;
}

void draw() {
  back();
  display();
  if (startButton == true) {
    system(0.6);
  }
  help();
}

// initialize the scene
void initializer() {
  frameColor = 0;
  balls = new ArrayList<Ball>();
  ballNumber = 0;
  startButton = false;
  time = 0;
  floorNum = 0;
  ballNum = 0;
  floorPlus = false;
  calculationFrequency = 0;
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Planet(random(-height, height), random(-height, height));
  }
  for (int i = 0; i < planets.length; i++) {
    planets[i] = new Planet(random(-height, height), random(-height, height), 1);
  }
  skyTimeStars = 0;
  skyTimePlanets = 0;
  spaceShuttle = new Shuttle(random(-1480, -1250), 0);
  for (int i=0; i<beams.length; i++)beams[i]=new Beam(random(80, 400), random(height + 50, height + 800));
  for (int i=0; i<enemyShuttles.length; i++)enemyShuttles[i]=new Shuttle(random(80, 300), random(height + 50, height + 300), 1);
  shuTime = - 20;
  startShu = false;
}

// background
void back() {
  background(20, 20, 40);

  skyTimeStars += 0.05;
  if (skyTimeStars > 360) {
    skyTimeStars = 0;
  }
  pushMatrix();
  translate(height / 2, height / 2);
  rotate(radians(skyTimeStars));  
  for (int i = 0; i < stars.length; i++) {
    stars[i].updateFar();
  }
  popMatrix();
  skyTimePlanets += 0.1;
  if (skyTimePlanets > 360) {
    skyTimePlanets = 0;
  }
  pushMatrix();
  translate(height / 2, height / 2);
  rotate(radians(skyTimePlanets));
  for (int i = 0; i < planets.length; i++) {
    planets[i].updateNear();
  }
  popMatrix();

  shu();

  noStroke();
  fill(10 - frameColor, 245 - frameColor, 255 - frameColor);
  frameColor += 0.4;
  if (frameColor > 20)frameColor = 0;
  rect(10, -5, - 20, height + 10);
  rect(width - 10, - 5, 20, height + 10);
  rect(-10, -10, width + 20, 20);
  rect(-10, height + 10, width + 20, - 20);
  rect(-10, 170, width + 20, - 50);
  fill(72, 118, 255);
  rect(5, -5, -10, height + 10);
  rect(width -5, -5, 10, height + 10);
  rect(-5, -5, width + 10, 10);
  rect(-5, height - 5, width + 10, 10);
  rect(12, 168, width - 24, - 46);
  fill(54, 100, 139);
  rect(width / 2 - 100, 160, 80, - 30);
  rect(width / 2 + 100, 160, - 80, - 30);
  fill(240);
  textSize(20);
  text("START", width / 2 - 60, 142);
  text("RESET", width / 2 + 60, 142);
  fill(160, 0, 244);
  ellipse(width / 2, 145, 25, 25);
  fill(240);
  textSize(15);
  text("S", width / 2, 142);
  fill(0, 210, 200);
  ellipse(width / 2 - 120, 145, 25, 25);
  fill(120);
  textSize(12);
  text("N|S", width / 2 - 120, 143);
  fill(220, 100, 160);
  ellipse(width / 2 + 120, 145, 25, 25);
  fill(100);
  textSize(10);
  text("help", width / 2 + 120, 143);

  fill(10 - frameColor, 245 - frameColor, 255 - frameColor);
  for (int i = 0; i < maxNumber; i++) {
    rect(6, 165 + 520 / 6 + i * 520 / 6, width - 12, 10);
  }
}

void shu() {
  if (startShu == true) {
    if (shuTime < 200) {
      shuTime += 0.2;
      if (shuTime > - 10) {
        for (int i = 0; i < int (beams.length / 2); i++) {
          pushMatrix();
          rotate(radians(10));
          beams[i].beamAction();
          popMatrix();
        }
        if (shuTime > 4) {
          for (int i = 0; i < enemyShuttles.length; i++) {
            pushMatrix();
            rotate(radians(10));
            enemyShuttles[i].enemyUpdate();
            popMatrix();
          }
        }
      }
    }
  }
  pushMatrix();
  translate(1500, height/2);
  rotate(radians(shuTime));
  spaceShuttle.update();
  popMatrix();

  if (shuTime < 200 && shuTime > - 10) {
    for (int i = int (beams.length / 2); i < beams.length; i++) {
      pushMatrix();
      rotate(radians(10));
      beams[i].beamAction();
      popMatrix();
    }
  }
}

// display
void display() {
  for (int i = 0; i < balls.size (); i++) {
    Ball ball = balls.get(i);
    ball.update();
  }
  fill(230);
  textSize(17);
  if (ballNumber > maxNumber) {
    text("Full", width /2, 25);
  } else {
    text((maxNumber - ballNumber + 1) +" Empty", width / 2, 25);
  }
  if (ballNumber == 0) {
    text("CLICK HERE", width/2, 60);
  }
}

// help display
void help() {
  if (helpButton == true) {
    fill(150, 200, 255, 180);
    stroke(0, 0, 230, 150);
    strokeWeight(10);
    rect(2, 170, width - 4, 220);
    fill(120);
    stroke(120);
    strokeWeight(6);
    line(width/2 - 20, 70, width/2 - 20, 180);
    line(width/2 - 20, 70, width/2 - 10 - 20, 80);
    line(width/2 - 20, 70, width/2 + 10 - 20, 80);
    textSize(20);
    fill(50);
    text("one click one ball.", width/2, 200);
    text("START is to start sort.", width/2, 230);
    text("RESET is to reset.", width/2, 260);
    text("N|S is to change notations \n of the balls.", width/2, 305);
    text("S is to shuffle balls.", width/2, 350);
  }
}

// Bubble sort algorism
void system(float t) {
  int[] floor = new int[balls.size()];
  int[] ballRidingBoard = new int[2];
  int bRBNumber = 0;
  int floorNum2 = 0;
  Ball[] ball = new Ball[balls.size()];
  for (int i = 0; i < balls.size (); i++) {
    ball[i] = balls.get(i);
    floor[i] = 0;
  }
  time += t;
  if (calculationFrequency <= balls.size() * (balls.size() - 1) / 2 + balls.size() - 1) {
    if (time > 50) {
      calculationFrequency++;
      for (int i = 1; i < balls.size (); i++) {
        for (int j = 0; j < balls.size (); j++) {
          if (i == ball[j].floorNumber) {
            floor[i]++;
          }
        }
      }
      for (int i = 1; i < balls.size (); i++) {
        if (floor[i] >= 2) {
          floorNum2 = i;
          floorPlus=true;
          break;
        }
      }
      if (floorPlus == true) {
        for (int i = 0; i < balls.size (); i++) {
          if (ball[i].floorNumber == floorNum2) {
            ballRidingBoard[bRBNumber] = i;
            if (bRBNumber == 0)bRBNumber++;
          }
        }
        if (int(ball[ballRidingBoard[0]].eSize) < int(ball[ballRidingBoard[1]].eSize)) {
          ball[ballRidingBoard[1]].floorNumber++;
          ball[ballRidingBoard[1]].big = true;
          ball[ballRidingBoard[0]].small = true;
        } else if (int(ball[ballRidingBoard[0]].eSize) == int(ball[ballRidingBoard[1]].eSize)) {
          ball[ballRidingBoard[0]].equal = true;
          ball[ballRidingBoard[1]].equal = true;
          ball[ballRidingBoard[0]].floorNumber++;
        } else {
          ball[ballRidingBoard[0]].floorNumber++;
          ball[ballRidingBoard[0]].big = true;
          ball[ballRidingBoard[1]].small = true;
        }
        floorPlus = false;
      } else {
        ball[ballNum].floorNumber++;
        if (ballNum < balls.size() - 1)ballNum++;
      }
      time = 0;
    }
    textSize(20);
    text("Now Bubble Sorting", width/2, 60);
  } else {
    textSize(20);
    text("Bubble Sort Finished", width/2, 60);
    startShu = true;
  }
}

void mouseClicked() {

  // put balls in scene
  if (startButton == false) {
    if (ballNumber <= maxNumber) {
      if (mouseX > 10 && mouseX < width - 10 && mouseY > 10 && mouseY < 120) {
        balls.add(new Ball(mouseX, mouseY, ballNumber, balls));
        Ball ball = balls.get(ballNumber);
        ball.action();
        ballNumber++;
      }
    }
  }


  // START sorting balls
  if (ballNumber > 0) {
    if (mouseX > width / 2 - 100 && mouseY < 160 && mouseX < width / 2 - 20 && mouseY > 130) {
      startButton = true;
    }
  }

  // RESET the scene
  if (mouseX < width / 2 + 100 && mouseY < 160 && mouseX > width / 2 + 20 && mouseY > 130) {
    initializer();
  }

  // shuffle balls
  float sButton = dist(mouseX, mouseY, width / 2, 145);
  if (sButton < 25 / 2) {
    for (int i = 0; i < balls.size (); i++) {
      Ball ball = balls.get(i);
      ball.sAction();
    }
  }

  // change displays of balls number or diameter
  float cButton = dist(mouseX, mouseY, width / 2 - 120, 145);
  if (cButton < 25 / 2) {
    if (stringButton == true) {
      stringButton = false;
    } else {
      stringButton = true;
    }
  }

  // display help
  float hButton = dist(mouseX, mouseY, width / 2 + 120, 145);
  if (mouseY > 165) {
    if (helpButton == true) {
      helpButton = false;
    }
  }
  if (hButton < 25 / 2) {
    if (helpButton == false) {
      helpButton = true;
    } else {
      helpButton = false;
    }
  }
}
