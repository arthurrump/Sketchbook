class Achtergrond {

  color achtergrondKleur = #06B795;
  color grondKleur = #EAD99A;
  
  int aantalBomen = 6;
  int boomDikte = 30;
  Boom[] bomen;
  
  Achtergrond() {
    int tussenRuimte = width / (this.aantalBomen - 1);
    this.bomen = new Boom[this.aantalBomen];
    for (int i = 0; i < this.aantalBomen; i++) {
      float x = i * tussenRuimte + random(-3, 3) * this.boomDikte;
      float dikte = random(0.2, 1) * this.boomDikte;
      float alpha = random(80, 160);
      this.bomen[i] = new Boom(x, dikte, alpha);
    }
  }
  
  void display() {
    background(this.achtergrondKleur);
    
    for (int i = 0; i < this.aantalBomen; i++) {
      this.bomen[i].display();
    }
    
    noStroke();
    fill(grondKleur);
    rect(0, height - 150, width, height);
  }
}
