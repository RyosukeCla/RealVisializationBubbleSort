class Shuttle {
  float xpos, ypos;
  float[] x = new float[5];
  float[] y = new float[5];
  float[] xsp = new float[5];
  float[] ysp = new float[5];
  int time;

  float ysp2;
  Beam[] beams = new Beam[3];
  Shuttle(float xpos, float ypos) {
    this.xpos = xpos;
    this.ypos = ypos;
    for (int i = 0; i < 5; i++) {
      this.x[i] = 0;
      this.y[i] = 140;
      this.xsp[i] = random(-0.5, 0.5);
      this.ysp[i] = random(0.5, 2);
    }
    this.time = 0;
  }

  Shuttle(float xpos, float ypos, int k) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.ysp2 = random(3,5);
    for (int i = 0; i < this.beams.length; i++)this.beams[i] = new Beam(xpos, ypos);
    this.time = int(random(-30,0));
  }

  void update() {
    translate(this.xpos, this.ypos);
    system();
    display();
  }

  void system() {
    time++;
    noStroke();
    fill(255, 0, 0, 230 - time * 2);
    ellipse(0, 145, 22, 45);
    fill(255, 255, 0, 200 - time * 2);
    ellipse(0, 145, 18, 26);
    for (int i = 0; i < 5; i++) {
      this.x[i] += this.xsp[i];
      this.y[i] += this.ysp[i];
      fill(255, 20, 0, 255 - time * 5);
      ellipse(this.x[i], this.y[i], 10, 10);
      if (time > 40) {
        x[i] = 0;
        y[i] = 140;
        xsp[i] = random(-0.5, 0.5);
        ysp[i] = random(1, 4);
      }
    }
    if (time > 40) {
      time = 0;
    }
  }

  void display() {
    strokeWeight(1);
    noFill();
    stroke(0);
    fill(255);
    beginShape();
    vertex(-9.5, 30);
    vertex(-11, 33);
    vertex(-20, 90);
    vertex(-50, 120);
    vertex(-54, 135);
    vertex(0, 140);
    vertex(0, 30);
    vertex(-9.5, 30);
    endShape();

    beginShape();
    vertex(9.5, 30);
    vertex(11, 33);
    vertex(20, 90);
    vertex(50, 120);
    vertex(54, 135);
    vertex(0, 140);
    vertex(0, 30);
    vertex(9.5, 30);
    endShape();

    noStroke();
    fill(0);

    beginShape();
    vertex(0, 0);
    bezierVertex(6, 3, 8, 18, 10, 30);
    vertex(-10, 30);
    bezierVertex(-8, 18, -6, 3, 0, 0);
    endShape();
    fill(255);
    beginShape();
    vertex(0, 4);
    bezierVertex(6, 3, 8, 18, 10, 30);
    vertex(-10, 30);
    bezierVertex(-8, 18, -6, 3, 0, 4);
    endShape();
    fill(255, 255, 0);
    triangle(0, 8, -2, 1, 2, 1);
    fill(255);
    rect(-9.5, 30, 19, 110);
    stroke(100, 100);
    line(-9.5, 30, -9.5, 140);
    line(9.5, 30, 9.5, 140);

    strokeWeight(2.5);
    stroke(20);

    line(-20, 90, -50, 120);
    line(-50, 120, -53, 120 + 15 * 2 / 3);
    line(-53, 120 + 15 * 2 / 3, 0, 120 + 15 * 2 / 3);
    line(20, 90, 50, 120);
    line(50, 120, 53, 120 + 15 * 2 / 3);
    line(53, 120 + 15 * 2 / 3, 0, 120 + 15 * 2 / 3);

    stroke(100, 100);
    strokeWeight(1);
    beginShape();
    vertex(0, 120);
    vertex(14, 123);
    vertex(14.3, 145);
    vertex(-14.3, 145);
    vertex(-14, 123);
    vertex(0, 120);
    endShape();
    fill(50);
    rect(-12, 135, 24, 15);

    stroke(10);
    beginShape();
    vertex(-6, 28);
    vertex(-7, 26);
    bezierVertex(-2, 20, 2, 20, 7, 26);
    vertex(6, 28);
    bezierVertex(-2, 25, 2, 25, -6, 28);
    endShape();

    strokeWeight(2.5);
    stroke(20);
    line(0, 125, 0, 157);

    strokeWeight(1);
    stroke(100);

    line(-6, 10, 0, 8);
    line(0, 8, 6, 10);
    fill(40);
    textSize(7);
    text("Penguin", 25, 115);
    textSize(4);
    text("X3-44", 22, 123);
  }

  void enemyUpdate() {
    this.time += 1;
    if (this.time >= 160) {
      this.beams[0] = new Beam(this.xpos, this.ypos);
      this.time = 0;
    }
    if (this.time < 160) {
      pushMatrix();
      this.beams[0].beamAction();
      popMatrix();
      if (this.time <= 0) {
        this.beams[0] = new Beam(this.xpos, this.ypos);
      }
      if (this.time <= 30) {
        this.beams[1] = new Beam(this.xpos, this.ypos);
      } 
      if (this.time <= 60) {
        this.beams[2] = new Beam(this.xpos, this.ypos);
      }
      if (this.time >= 30) {
        pushMatrix();
        this.beams[1].beamAction();
        popMatrix();
      }
      if (this.time >= 60) {
        pushMatrix();
        this.beams[2].beamAction();
        popMatrix();
      }
    }
    
    this.ypos -= this.ysp2;
    translate(this.xpos, this.ypos);
    fill(150, 150, 220);
    stroke(100, 100, 200);
    beginShape();
    vertex(0, 0);
    vertex(5, 0);
    vertex(7, 2);
    vertex(9, 15);
    vertex(14, 15);

    vertex(14, -40);
    vertex(33, 10);
    vertex(33, 25);
    vertex(14, 40);
    vertex(8, 48);

    vertex(-8, 48);
    vertex(-14, 40);
    vertex(-33, 25);
    vertex(-33, 10);
    vertex(-14, -40);

    vertex(-14, 15);
    vertex(-9, 15);
    vertex(-7, 2);
    vertex(-5, 0);
    vertex(0, 0);
    endShape();
    fill(10, 10, 100);
    triangle(16, -30, 30, 10, 16, 15);
    triangle(30, 12, 30, 24, 16, 24);
    triangle(-16, -30, -30, 10, -16, 15);
    triangle(-30, 12, -30, 24, -16, 24);
    rect(-4, 2, 8, 3);

    stroke(100, 100, 180);
    line(-12, 15, -12, 42);
    line(12, 15, 12, 42);
    line(10, 15, 0, 13);
    line(-10, 15, 0, 13);

    fill(10, 10, 100);
    beginShape();
    vertex(-10, 44);
    vertex(10, 44);
    vertex(8, 48);
    vertex(-8, 48);
    vertex(-10, 44);
    endShape();
    textSize(5);
    text("T\nI\nE", 3, 30);
  }
}

class Beam {
  float xpos, ypos;
  float ysp;
  Beam(float xpos, float ypos) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.ysp = 12;
  }

  void beamAction() {
    this.ypos -= this.ysp;
    translate(this.xpos, this.ypos);
    for (int i = 0; i < 10; i++) {
      strokeWeight(5 - i / 2.0);
      stroke(255, 10 + i * 10, 10 + i * 10, 100 * 10 * i);
      line(0, -35, 0, 35);
    }
  }
}

