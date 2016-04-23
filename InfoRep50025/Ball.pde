class Ball {
  float xpos, ypos, xsp, ysp;
  float eSize;
  int id;
  color eColor;
  int floorNumber;
  ArrayList<Ball> others;
  boolean big;
  boolean small;
  boolean equal;
  float t;
  Ball(float xpos, float ypos, int idin, ArrayList<Ball> others) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.xsp = 0;
    this.ysp = 0;
    this.id = idin;
    this.eSize = random(20, 70);
    this.others = others;
    this.eColor = color(int(random(0, 255)), int(random(0, 255)), int(random(0, 255)),100);
    this.floorNumber = 0;
    this.big = false;
    this.small = false;
  }

  void update() {
    motion();
    system();
    collision();
    display();
    if (this.big == true) {
      textBigger();
    }
    if (this.small == true) {
      textSmaller();
    }
    if (this.equal == true) {
      textEqual();
    }
  }

  // collide with the others
  void collision() {
    for (int i = id + 1; i < balls.size (); i++) {

      Ball ball = balls.get(i);

      float dx = ball.xpos - this.xpos;
      float dy = ball.ypos - this.ypos;
      float distance = sqrt(dx * dx + dy * dy);
      float minDist = ball.eSize / 2 + this.eSize / 2;
      if (distance < minDist) {
        float angle = atan2(dy, dx);
        float targetX = this.xpos + cos(angle) * minDist;
        float targetY = this.ypos + sin(angle) * minDist;
        float xac = (targetX - ball.xpos) * s;
        float yac = (targetY - ball.ypos) * s;
        this.xsp -= xac;
        this.ysp -= yac;
        ball.xsp += xac;
        ball.ysp += yac;
      }
    }
  }
  
  // ball motion
  void motion() {
    this.ysp += g;
    this.xpos += this.xsp;
    this.ypos += this.ysp;
    if (this.xpos + this.eSize / 2 > width - 10) {
      this.xpos = width - this.eSize / 2 - 10;
      this.xsp *= - e;
    }
    if (this.xpos - this.eSize / 2 < 10) {
      this.xpos = this.eSize / 2 + 10;
      this.xsp *= - e;
    }
    if (this.ypos + this.eSize / 2 > height - 10) {
      this.ypos = height - this.eSize / 2 - 10;
      this.ysp *= - e;
    }
    if (this.ypos - this.eSize / 2 < 10) {
      this.ypos = this.eSize / 2 + 10;
      this.ysp *= - e;
    }
  }
  
  // system which is to collide with floor
  void system() {
    switch(this.floorNumber) {
    case 0:
      if (this.ypos + this.eSize / 2 > 120) {
        this.ypos = 120 - this.eSize / 2;
        this.ysp *= - e;
      }
      if (this.ypos + this.eSize / 2 == 120) {
        this.xsp *= f;
      }
      break;
    case 6:
      if (this.ypos == height - this.eSize / 2 - 10) {
        this.xsp *= f;
      }
      break;
    default: 
      if (this.ypos + this.eSize / 2 > 165 + this.floorNumber * 520 / 6) {
        this.ypos = 165 + this.floorNumber * 520 / 6 - this.eSize / 2;
        this.ysp *= - e;
        this.xsp *= f;
      }
      if (this.ypos == 165 + this.floorNumber * 520 / 6 - this.eSize / 2) {
        this.xsp *= f;
      }
      break;
    }
  }
  
  // ball display
  void display() {
    stroke(eColor);
    strokeWeight(this.eSize / 8);
    fill(127 - frameColor, 255 - frameColor , 212 - frameColor); //Aquamarine
    ellipse(this.xpos, this.ypos, this.eSize, this.eSize);
    fill(25,25,112); //MidnightBlue
    textSize(this.eSize/2);
    
    if (stringButton == false) {
      text("n" + (this.id + 1),this.xpos, this.ypos - this.eSize / 14);
    } else {
      text(int(this.eSize), this.xpos, this.ypos- this.eSize /14);
    }
  }
  
  // system which is to display "bigger" or "smaller" in algorism
  void textBigger() {
    t++;
    textSize(14);
    fill(255,0,255);
    text("bigger", this.xpos, this.ypos - this.eSize / 2 - 20);
    if (t > 50) {
      t = 0;
      this.big = false;
    }
  }
  void textSmaller() {
    t++;
    textSize(10);
    fill(255,255,0);
    text("smaller", this.xpos, this.ypos - this.eSize / 2 - 20);
    if (t > 50) {
      t = 0;
      this.small = false;
    }
  }
  void textEqual() {
    t++;
    textSize(12);
    fill(160);
    text("equal", this.xpos, this.ypos - this.eSize / 2 - 20);
    if (t > 50) {
      t = 0;
      this.equal = false;
    }
  }  
  // ball action
  void sAction() {
    this.xsp = random(-8,8);
    this.ysp = random(-15,5);
  }
  
  void action() {
    this.xsp = random(-2,2);
    this.ysp = random(-8, -2);
  }
}

