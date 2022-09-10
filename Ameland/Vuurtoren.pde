class Vuurtoren {
  int x, y;
  
  int torenRingen;
  int torenHoogte;
  int torenBreedteOnder;
  int torenBreedteBoven;
  int lampHoogte;
  int lampBreedte;
  
  color rood, wit, glas;
  
  Lichtkegels lichtkegels;

  Vuurtoren(int x, int y) {
    this.x = x;
    this.y = y;
    
    this.torenRingen = 9;
    this.torenHoogte = 350;
    this.torenBreedteOnder = 100;
    this.torenBreedteBoven = 60;
    this.lampHoogte = 50;
    this.lampBreedte = 50;
    
    this.rood = color(200, 10, 15);
    this.wit = color(255, 255, 255);
    this.glas = color(255, 255, 220, 230);
    
    this.lichtkegels = new Lichtkegels(this.x, this.y, this.lampHoogte / 10);
  }
  
  void update() {
    this.lichtkegels.draai(0.01);
  }

  void display(float licht) {
    // Bereken locatie van toren en maak een variabele om de breedte
    // van de huidige ring bij te houden
    int torenTopY = this.y + this.lampHoogte / 2;
    int torenOnderY = torenTopY + this.torenHoogte;
    int ringBreedte = this.torenBreedteOnder;
    
    // We tekenen zonder lijnen
    noStroke();
    
    // Teken de lichtkegel achter de toren als het donker is
    if (licht < 0.5) {
      lichtkegels.displayAchter();
    }
    
    // Teken de toren met rode en witte ringen
    for (int i = 1; i <= this.torenRingen; i++) {
      int breedteOnder = ringBreedte;
      ringBreedte = round(lerp(this.torenBreedteOnder, this.torenBreedteBoven, float(i) / this.torenRingen));
      
      if (i % 2 == 0) {
        fill(verdonker(this.rood, licht));
      } else {
        fill(verdonker(this.wit, licht));
      }
      
      quad(
        // Linksonder
        this.x - breedteOnder / 2, lerp(torenOnderY, torenTopY, float(i - 1) / this.torenRingen),
        // Linksboven
        this.x - ringBreedte / 2, lerp(torenOnderY, torenTopY, float(i) / this.torenRingen),
        // Rechtsboven
        this.x + ringBreedte / 2, lerp(torenOnderY, torenTopY, float(i) / this.torenRingen),
        // Rechtsonder
        this.x + breedteOnder / 2, lerp(torenOnderY, torenTopY, float(i - 1) / this.torenRingen));
    }
    
    // Teken de railing aan de bovenkant
    float railHoogte = this.torenHoogte / (2 * this.torenRingen);
    float railBreedteOnder = lerp(this.torenBreedteBoven, this.torenBreedteOnder, railHoogte / this.torenHoogte);
    fill(0);
    quad(
      // Linksonder
      this.x - railBreedteOnder / 2, torenTopY + railHoogte,
      // Linksboven
      this.x - railBreedteOnder * 1.2 / 2, torenTopY,
      // Rechtsboven
      this.x + railBreedteOnder * 1.2 / 2, torenTopY,
      // Rechtsonder
      this.x + railBreedteOnder / 2, torenTopY + railHoogte);
    
    // Teken het glas van de lamp
    fill(verdonker(this.glas, licht));
    rectMode(CENTER);
    rect(this.x, this.y, this.lampBreedte, this.lampHoogte);
    
    // Teken het "mutsje" van de vuurtoren
    fill(verdonker(this.rood, licht));
    arc(this.x, this.y - this.lampHoogte / 2, this.lampBreedte, 0.8 * this.lampBreedte, PI, TWO_PI);
    
    // Teken de lichtkegel voor de vuurtoren
    if (licht < 0.5) {
      lichtkegels.displayVoor();
    }
  }
}
