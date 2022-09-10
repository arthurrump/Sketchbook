class Vuurtoren {
  int x, y;
  
  int torenRingen;
  int torenHoogte;
  int torenBreedteOnder;
  int torenBreedteBoven;
  int lampHoogte;
  int lampBreedte;
  
  color rood, wit, glas, licht;
  
  int lichtkegelBreedte;
  int lichtkegelStraal;
  float lichtkegelRotatie;

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
    this.licht = color(255, 255, 15, 100);
    
    this.lichtkegelRotatie = HALF_PI;
    this.lichtkegelBreedte = 600;
    this.lichtkegelStraal = 60;
  }
  
  void update() {
    this.lichtkegelRotatie = (this.lichtkegelRotatie + 0.01) % TWO_PI;
  }

  void display(float licht) {
    int torenTopY = this.y + this.lampHoogte / 2;
    int torenOnderY = torenTopY + this.torenHoogte;
    int ringBreedte = this.torenBreedteOnder;
    noStroke();
    
    if (licht < 0.5) {
      blendMode(LIGHTEST);
      fill(this.licht);
      if (this.lichtkegelRotatie > PI) {
        quad(
          this.x, this.y - this.lampHoogte / 10, 
          this.x + this.lichtkegelBreedte * cos(this.lichtkegelRotatie), this.y - this.lichtkegelStraal,
          this.x + this.lichtkegelBreedte * cos(this.lichtkegelRotatie), this.y + this.lichtkegelStraal,
          this.x, this.y + this.lampHoogte / 10);
        ellipse(
          this.x + this.lichtkegelBreedte * cos(this.lichtkegelRotatie), this.y,
          2 * this.lichtkegelStraal * sin(this.lichtkegelRotatie), 
          2 * this.lichtkegelStraal);
      } else {
        quad(
          this.x, this.y - this.lampHoogte / 10, 
          this.x - this.lichtkegelBreedte * cos(this.lichtkegelRotatie), this.y - this.lichtkegelStraal,
          this.x - this.lichtkegelBreedte * cos(this.lichtkegelRotatie), this.y + this.lichtkegelStraal,
          this.x, this.y + this.lampHoogte / 10);
        ellipse(
          this.x - this.lichtkegelBreedte * cos(this.lichtkegelRotatie), this.y,
          2 * this.lichtkegelStraal * sin(this.lichtkegelRotatie), 
          2 * this.lichtkegelStraal);
      }
      blendMode(BLEND);
    }
    
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
    
    fill(verdonker(this.glas, licht));
    rectMode(CENTER);
    rect(this.x, this.y, this.lampBreedte, this.lampHoogte);
    
    fill(verdonker(this.rood, licht));
    arc(this.x, this.y - this.lampHoogte / 2, this.lampBreedte, 0.8 * this.lampBreedte, PI, TWO_PI);
    
    if (licht < 0.5) {
      blendMode(LIGHTEST);
      fill(this.licht);
      if (this.lichtkegelRotatie <= PI) {
        quad(
          this.x, this.y - this.lampHoogte / 10, 
          this.x + this.lichtkegelBreedte * cos(this.lichtkegelRotatie), this.y - this.lichtkegelStraal,
          this.x + this.lichtkegelBreedte * cos(this.lichtkegelRotatie), this.y + this.lichtkegelStraal,
          this.x, this.y + this.lampHoogte / 10);
        ellipse(
          this.x + this.lichtkegelBreedte * cos(this.lichtkegelRotatie), this.y,
          2 * this.lichtkegelStraal * sin(this.lichtkegelRotatie), 
          2 * this.lichtkegelStraal);
      } else {
        quad(
          this.x, this.y - this.lampHoogte / 10, 
          this.x - this.lichtkegelBreedte * cos(this.lichtkegelRotatie), this.y - this.lichtkegelStraal,
          this.x - this.lichtkegelBreedte * cos(this.lichtkegelRotatie), this.y + this.lichtkegelStraal,
          this.x, this.y + this.lampHoogte / 10);
        ellipse(
          this.x - this.lichtkegelBreedte * cos(this.lichtkegelRotatie), this.y,
          2 * this.lichtkegelStraal * sin(this.lichtkegelRotatie), 
          2 * this.lichtkegelStraal);
      }
      blendMode(BLEND);
    }
  }
}
