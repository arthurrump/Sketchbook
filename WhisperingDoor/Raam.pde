class Raam {

  float x;
  float y;
  float offsetX;
  float offsetY;
  float hoogte;
  float breedte;
  color kozijnKleur;
  
  boolean lichtAan;
  
  Raam(float basisX, float basisY, float offsetX, float offsetY, float breedte, float hoogte, color kozijnKleur) {
    this.x = basisX + offsetX;
    this.y = basisY + offsetY;
    this.offsetX = offsetX;
    this.offsetY = offsetY;
    this.breedte = breedte;
    this.hoogte = hoogte;
    this.kozijnKleur = kozijnKleur;
  }

  void display() {
    stroke(this.kozijnKleur);
    strokeWeight(2);
    if (this.lichtAan) {
      fill(#F7F0AC);
    } else {
      fill(#343224);
    }
    rect(this.x, this.y, this.breedte / 2, this.hoogte / 2);
    rect(this.x + this.breedte / 2, this.y, this.breedte / 2, this.hoogte / 2);
    rect(this.x + this.breedte / 2, this.y + this.hoogte / 2, this.breedte / 2, this.hoogte / 2);
    rect(this.x, this.y + this.hoogte / 2, this.breedte / 2, this.hoogte / 2);
  }
  
  void update(float basisX, float basisY) {
    this.x = basisX + this.offsetX;
    this.y = basisY + this.offsetY;
  }
  
  boolean muisIsOver(float muisX, float muisY) {
    return (
      this.x <= muisX && muisX <= this.x + this.breedte &&
      this.y <= muisY && muisY <= this.y + this.hoogte
    );
  }
  
  void schakelLicht() {
    this.lichtAan = !this.lichtAan;
  }
  
  void mouseClicked() {
    this.schakelLicht();
  }
}
