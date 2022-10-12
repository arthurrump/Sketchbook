class Lamp {
  Lichtkegel links, rechts;
  float rotatie;

  Lamp(int lampX, int lampY, int lampHoogte) {
    int breedte = 600;
    int straal = 60;

    this.links = new Lichtkegel(lampX, lampY, lampHoogte, breedte, straal, PI);
    this.rechts = new Lichtkegel(lampX, lampY, lampHoogte, breedte, straal, 0);
  }

  void draai(float rotatieDelta) {
    this.rotatie = (this.rotatie + rotatieDelta) % TWO_PI;
  }

  void displayVoor() {
    if (this.rotatie <= PI) {
      // De rechterkegel komt naar voren vanaf 0 graden, en blijft dus
      // voor in de eerste helft van de rotatie.
      this.rechts.display(this.rotatie);
    } else {
      this.links.display(this.rotatie);
    }
  }

  void displayAchter() {
    if (this.rotatie <= PI) {
      // De linkerkegel gaat naar achteren vanaf 0 graden
      this.links.display(this.rotatie);
    } else {
      this.rechts.display(this.rotatie);
    }
  }
}
