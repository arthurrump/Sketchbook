class Huis {
  static final int aantalStijlen = 2;
  
  float x;
  float breedte;
  float hoogte;

  float y;
  float doelY;

  float snelheid;
  
  int stijl;

  Huis(int stijl, float x, float doelY, float startY) {
    this.stijl = stijl;
    this.x = x;
    
    switch (stijl) {
    case 0:
      this.breedte = 160;
      this.hoogte = 80;
      break;
    case 1:
      this.breedte = 200;
      this.hoogte = 100;
      break;
    }
    
    this.doelY = doelY - this.hoogte;
    this.y = startY - this.hoogte;
    this.snelheid = 0;
  }

  void update() {
    if (this.y < this.doelY) {
      this.y += this.snelheid;
      if (this.y > this.doelY) {
        this.y = this.doelY;
      }
      this.snelheid += valVersnelling;
    }
  }

  void display() {
    switch (stijl) {
    case 0:
      // Huis
      fill(#E02D09);
      rect(
        this.x + 0.05 * this.breedte, this.y + 0.2 * this.hoogte, 
        0.9 * this.breedte, 0.8 * this.hoogte);
      // Dakrand
      fill(#8CD8EA);
      quad(
        this.x, this.y,
        this.x + this.breedte, this.y,
        this.x + 0.95 * this.breedte, this.y + 0.2 * this.hoogte,
        this.x + 0.05 * this.breedte, this.y + 0.2 * this.hoogte);
      break;
    case 1:
      // Veranda
      fill(#C1BC7D);
      quad(
        this.x + 0.1 * this.breedte, this.y + 0.9 * this.hoogte,
        this.x + 0.9 * this.breedte, this.y + 0.9 * this.hoogte,
        this.x + this.breedte, this.y + this.hoogte,
        this.x, this.y + this.hoogte);
      // Huis
      fill(#C1987D);
      rect(
        this.x + 0.1 * this.breedte, this.y + 0.35 * this.hoogte,
        0.8 * this.breedte, 0.55 * this.hoogte);
      // Dak
      fill(#E3CF8C);
      quad(
        this.x + 0.2 * this.breedte, this.y,
        this.x + 0.8 * this.breedte, this.y,
        this.x + this.breedte, this.y + 0.35 * this.hoogte,
        this.x, this.y + 0.35 * this.hoogte);
      // Dakraam
      fill(#65CED8);
      triangle(
        this.x + 0.5 * this.breedte, this.y,
        this.x + 0.6 * this.breedte, this.y + 0.35 * this.hoogte,
        this.x + 0.4 * this.breedte, this.y + 0.35 * this.hoogte);
    }
  }
}
