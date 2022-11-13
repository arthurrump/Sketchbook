class HuizenStapel {
  ArrayList<Huis> huizen;
  float stapelHoogte;
  int volgendeStijl;

  HuizenStapel(float y) {
    this.stapelHoogte = y;
    this.huizen = new ArrayList<Huis>();
    this.volgendeStijl = 1;
  }

  void update() {
    for (int i = 0; i < this.huizen.size(); i++) {
      this.huizen.get(i).update();
    }
  }

  void display() {
    for (int i = 0; i < this.huizen.size(); i++) {
      this.huizen.get(i).display();
    }
  }
  
  boolean muisIsOver(float muisX, float muisY) {
    for (int i = 0; i < this.huizen.size(); i++) {
      if (this.huizen.get(i).muisIsOver(muisX, muisY)) {
        return true;
      }
    }
    return false;
  }
  
  void mouseClicked(float muisX, float muisY) {
    for (int i = 0; i < this.huizen.size(); i++) {
      if (this.huizen.get(i).muisIsOver(muisX, muisY)) {
        this.huizen.get(i).mouseClicked(muisX, muisY);
      }
    }
  }
  
  void maakNieuwHuis() {
    Huis huis = new Huis(this.volgendeStijl, width / 2 - random(50, 150), height - this.stapelHoogte, min(0, height - this.stapelHoogte));
    this.huizen.add(huis);
    this.stapelHoogte += huis.hoogte;
    
    int stijl = int(random(Huis.aantalStijlen));
    if (stijl == this.volgendeStijl) {
      stijl = (stijl + 1) % Huis.aantalStijlen;
    }
    this.volgendeStijl = stijl;
  }
}
