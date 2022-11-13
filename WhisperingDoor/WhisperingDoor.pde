Achtergrond achtergrond;
ArrayList<Huis> huizen;

void setup() {
  size(600, 900);
  
  this.achtergrond = new Achtergrond();
  this.huizen = new ArrayList<Huis>();
}

void draw() {
  achtergrond.display();
  
  for (int i = 0; i < this.huizen.size(); i++) {
    this.huizen.get(i).display();
  }
}
