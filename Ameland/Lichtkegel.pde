class Lichtkegel {
  int lampX, lampY;
  int lampHoogte;
  int breedte;
  int straal;
  float startRotatie;

  Lichtkegel(int lampX, int lampY, int lampHoogte, int breedte, int straal, float startRotatie) {
    this.lampX = lampX;
    this.lampY = lampY;
    this.lampHoogte = lampHoogte;
    this.breedte = breedte;
    this.straal = straal;
    this.startRotatie = startRotatie;
  }

  void display(float rotatie) {
    rotatie = rotatie + this.startRotatie;
    float breedte = this.breedte * cos(rotatie);
    float straal = this.straal * map(sin(rotatie), -1, 1, 0.8, 1.2);

    blendMode(LIGHTEST);
    
    fill(255, 255, 15, 100);

    quad(
      this.lampX, this.lampY + this.lampHoogte / 2,
      this.lampX + breedte, this.lampY - straal,
      this.lampX + breedte, this.lampY + straal,
      this.lampX, this.lampY + this.lampHoogte / 2);
    ellipse(
      this.lampX + breedte, this.lampY,
      2 * straal * sin(rotatie),
      2 * straal);

    blendMode(BLEND);
  }
}
