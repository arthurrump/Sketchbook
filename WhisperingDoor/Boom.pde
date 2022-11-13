class Boom {
  float x;
  float dikte;
  float alpha;

  Boom(float x, float dikte, float alpha) {
    this.x = x;
    this.dikte = dikte;
    this.alpha = alpha;
  }

  void display() {
    strokeCap(SQUARE);
    strokeWeight(this.dikte);
    stroke(0, this.alpha);
    line(this.x, height, this.x, 0);
  }

}
