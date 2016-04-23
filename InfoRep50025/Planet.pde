class Planet {
  float xpos, ypos;
  float starring;
  float starringSpeed;
  float pSize;
  float pSizeProbability;
  color planetColor;
  Planet(float xpos, float ypos) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.starring = 0;
    this.starringSpeed = random(1, 2);
    this.pSizeProbability = random(10);
    if (this.pSizeProbability > 8) {
      this.pSize = random(1.1, 2);
    } else {
      this.pSize = random(0.1, 1);
    }
  }
  Planet(float xpos, float ypos, int k) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.planetColor = color(int(random(255)), int(random(255)), int(random(255)));
    this.pSize = random(10, 90);
  }

  void updateFar() {
    this.starring += this.starringSpeed;
    if (this.starring > 30) {
      this.starring = 0;
    }

    stroke(255 - this.starring);
    strokeWeight(this.pSize);
    point(this.xpos, this.ypos);
  }

  void updateNear() {
    noStroke();
    fill(this.planetColor);
    ellipse(this.xpos, this.ypos, int(this.pSize), int(this.pSize));
  }
}

