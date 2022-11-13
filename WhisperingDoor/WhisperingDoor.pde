float valVersnelling = 3;

Achtergrond achtergrond;
Titel titel;
ArrayList<Huis> huizen;
float stapelHoogte = 100;

void setup() {
  size(600, 900);
  
  this.achtergrond = new Achtergrond();
  this.huizen = new ArrayList<Huis>();
  this.titel = new Titel();
}

void draw() {
  for (int i = 0; i < this.huizen.size(); i++) {
    this.huizen.get(i).update();
  }
  
  achtergrond.display();
  
  for (int i = 0; i < this.huizen.size(); i++) {
    this.huizen.get(i).display();
  }
  
  this.titel.display();
}

void mouseClicked() {
  Huis huis = new Huis(int(random(Huis.aantalStijlen)), width / 2 - random(50, 150), height - this.stapelHoogte, min(0, height - this.stapelHoogte));
  this.huizen.add(huis);
  this.stapelHoogte += huis.hoogte;
}
