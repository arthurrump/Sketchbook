float licht;

Landschap landschap;
Vuurtoren vuurtoren;
AnsichtTekst tekst;

void setup() {
  size(1200, 800);
  colorMode(RGB, 255);
  
  this.licht = 1.0;
  
  this.landschap = new Landschap();
  this.vuurtoren = new Vuurtoren(400, 200);
  this.tekst = new AnsichtTekst(20, 690, 90);
}

void draw() {
  background(verdonker(#85C78E, this.licht));
  
  this.landschap.update();
  this.vuurtoren.update();
  
  this.landschap.display(licht);
  this.vuurtoren.display(licht);
  this.tekst.display();
  
  //noStroke();
  //fill(0, 0, 0, 200 - licht * 200);
  //rectMode(CORNER);
  //rect(0, 0, width, height);
}

color verdonker(color c, float light) {
  colorMode(HSB, 100);
  color result = color(hue(c), saturation(c), brightness(c) * map(light, 0, 1, 0.2, 1), alpha(c));
  colorMode(RGB, 255);
  return result;
}

void mouseMoved() {
  this.licht = float(height - mouseY) / height;
}
