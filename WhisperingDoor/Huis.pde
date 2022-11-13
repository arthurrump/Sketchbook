class Huis {
  static final int aantalStijlen = 3;

  float x;
  float breedte;
  float hoogte;

  float y;
  float doelY;

  float snelheid;

  int stijl;

  int aantalRamen;
  Raam[] ramen;

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
    case 2:
      this.breedte = 180;
      this.hoogte = 105;
      break;
    }

    this.doelY = doelY - this.hoogte;
    this.y = startY - this.hoogte;
    this.snelheid = 0;

    switch (stijl) {
    case 0:
      this.aantalRamen = 4;
      this.ramen = new Raam[] {
        new Raam(this.x, this.y, 0.1 * this.breedte, 0.3 * this.hoogte, 0.15 * this.breedte, 0.5 * this.hoogte, #8CD8EA),
        new Raam(this.x, this.y, 0.3 * this.breedte, 0.3 * this.hoogte, 0.15 * this.breedte, 0.5 * this.hoogte, #8CD8EA),
        new Raam(this.x, this.y, 0.55 * this.breedte, 0.3 * this.hoogte, 0.15 * this.breedte, 0.5 * this.hoogte, #8CD8EA),
        new Raam(this.x, this.y, 0.75 * this.breedte, 0.3 * this.hoogte, 0.15 * this.breedte, 0.5 * this.hoogte, #8CD8EA)
      };
      break;
    case 1:
      this.aantalRamen = 3;
      this.ramen = new Raam[] {
        new Raam(this.x, this.y, 0.2 * this.breedte, 0.4 * this.hoogte, 0.15 * this.breedte, 0.3 * this.hoogte, #9DBF7D),
        new Raam(this.x, this.y, 0.65 * this.breedte, 0.4 * this.hoogte, 0.15 * this.breedte, 0.3 * this.hoogte, #9DBF7D),
        new Raam(this.x, this.y, 0.45 * this.breedte, 0.45 * this.hoogte, 0.1 * this.breedte, 0.25 * this.hoogte, #F0DE3A)
      };
      break;
    case 2:
      this.aantalRamen = 5;
      this.ramen = new Raam[] {
        new Raam(this.x, this.y, 0.1 * this.breedte, 0.55 * this.hoogte, 0.15 * this.breedte, 0.35 * this.hoogte, #51B757),
        new Raam(this.x, this.y, 0.3 * this.breedte, 0.55 * this.hoogte, 0.15 * this.breedte, 0.35 * this.hoogte, #51B757),
        new Raam(this.x, this.y, 0.55 * this.breedte, 0.55 * this.hoogte, 0.15 * this.breedte, 0.35 * this.hoogte, #51B757),
        new Raam(this.x, this.y, 0.75 * this.breedte, 0.55 * this.hoogte, 0.15 * this.breedte, 0.35 * this.hoogte, #51B757),
        new Raam(this.x, this.y, 0.45 * this.breedte, 0.1 * this.hoogte, 0.1 * this.breedte, 0.3 * this.hoogte, #F0DE3A)
      };
      break;
    }
  }

  boolean muisIsOver(float muisX, float muisY) {
    return (
      this.x <= muisX && muisX <= this.x + this.breedte &&
      this.y <= muisY && muisY <= this.y + this.hoogte
      );
  }

  void mouseClicked(float muisX, float muisY) {
    for (int i = 0; i < this.aantalRamen; i++) { //<>// //<>//
      if (this.ramen[i].muisIsOver(muisX, muisY)) { //<>// //<>//
        this.ramen[i].mouseClicked();
      }
    }
  }

  void update() {
    if (this.y < this.doelY) {
      this.y += this.snelheid;
      if (this.y > this.doelY) {
        this.y = this.doelY;
      }
      this.snelheid += valVersnelling;
      for (int i = 0; i < this.aantalRamen; i++) {
        this.ramen[i].update(this.x, this.y);
      }
    }
  }

  void display() {
    noStroke();
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
      // Deur
      fill(#51B757);
      rect(
        this.x + 0.4 * this.breedte, this.y + 0.4 * this.hoogte,
        0.2 * this.breedte, 0.5 * this.hoogte);
      // Dak
      fill(#E3CF8C);
      quad(
        this.x + 0.2 * this.breedte, this.y,
        this.x + 0.8 * this.breedte, this.y,
        this.x + this.breedte, this.y + 0.35 * this.hoogte,
        this.x, this.y + 0.35 * this.hoogte);
      // Dakkapel
      fill(#65CED8);
      triangle(
        this.x + 0.5 * this.breedte, this.y,
        this.x + 0.6 * this.breedte, this.y + 0.35 * this.hoogte,
        this.x + 0.4 * this.breedte, this.y + 0.35 * this.hoogte);
      break;
    case 2:
      // Huis
      fill(#F7A42F);
      rect(
        this.x + 0.05 * this.breedte, this.y + 0.4 * this.hoogte,
        0.9 * this.breedte, 0.6 * this.hoogte);
      // Dak
      fill(#D3D380);
      rect(
        this.x, this.y,
        this.breedte, 0.5 * this.hoogte);
      // Dakkapel
      fill(#1E7FFA);
      rect(
        this.x + 0.4 * this.breedte, this.y,
        0.2 * this.breedte, 0.5 * this.hoogte);
      break;
    }
    
    for (int i = 0; i < this.aantalRamen; i++) {
      this.ramen[i].display();
    }
  }
}
