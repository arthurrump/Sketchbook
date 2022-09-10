class AnsichtTekst {
  int x, y, tekstGrootte;
  PFont font;
  
  AnsichtTekst(int x, int y, int tekstGrootte) {
    this.x = x;
    this.y = y;
    this.tekstGrootte = tekstGrootte;
    
    this.font = createFont("MsMadi/MsMadi-Regular.ttf", this.tekstGrootte);
  }
  
  void display() {
    fill(#fefefe);
    
    textFont(this.font);
    
    textSize(0.7 * this.tekstGrootte);
    text("Groetjes vanaf", this.x + textWidth("x"), this.y);
    
    textSize(this.tekstGrootte);
    text("Ameland", this.x, this.y + 1.2 * 0.7 * this.tekstGrootte);
  }

}
