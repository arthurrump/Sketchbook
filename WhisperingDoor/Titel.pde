class Titel {
  float x;
  float y;
  PFont font;
  
  Titel() {
    this.x = 50;
    this.y = 40;
    this.font = createFont("Goudy Old Style", 64, true);
  }
  
  void display() {
    textFont(this.font, 64);
    fill(#ffffff);
    textAlign(LEFT, TOP);
    text("UNDER THE", this.x, this.y);
    text("WHISPERING", this.x, this.y + 64);
    text("DOOR", this.x, this.y + 128);
    
    fill(#085B5F);
    textAlign(CENTER, BOTTOM);
    text("TJ KLUNE", width / 2, height - 20);
  }
}
