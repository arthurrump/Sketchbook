float valVersnelling = 3;

Achtergrond achtergrond;
HuizenStapel huizen;
Titel titel;

void setup() {
  size(600, 900);
  
  this.achtergrond = new Achtergrond();
  this.huizen = new HuizenStapel(100);
  this.titel = new Titel();
}

void draw() {
  this.huizen.update();
  
  this.achtergrond.display();
  this.huizen.display();
  this.titel.display();
}

void mouseClicked() {
  if (mouseButton == LEFT) {
    if (this.huizen.muisIsOver(mouseX, mouseY)) {
      this.huizen.mouseClicked(mouseX, mouseY);
    } else {
      this.huizen.maakNieuwHuis();
    }
  } else if (mouseButton == RIGHT) {
    if (this.huizen.muisIsOver(mouseX, mouseY)) {
      this.huizen.mouseRightClicked(mouseX, mouseY);
    }
  } //<>//
}
