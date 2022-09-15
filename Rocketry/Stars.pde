class Stars {
  int starCount;
  int[] xs, ys;
  
  Stars(int starCount) {
    this.starCount = starCount;
    this.xs = new int[starCount];
    this.ys = new int[starCount];
    for (int i = 0; i < starCount; i++) {
      this.xs[i] = round(random(width));
      this.ys[i] = round(random(height));
    }
  }
  
  void display() {
    for (int i = 0; i < starCount; i++) {
      fill(200, 200, 0);
      circle(this.xs[i], this.ys[i], 5);
    }
  }
}
