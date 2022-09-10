class Landschap {
  int horizon;
  
  int duinenStartLinks, duinenStartRechts;
  int aantalDuinlijnen;
  float[][] duinen;
  color[] duinKleuren;
  
  int aantalGolflijnen;
  float[][] golven;
  color[] golfKleuren;
  
  color luchtKleurDonker;
  color luchtKleurLicht;

  Landschap() {
    this.horizon = 120;
    
    this.luchtKleurDonker = #0C1F26;
    this.luchtKleurLicht = #50CDFF;
    
    this.duinenStartLinks = 460;
    this.duinenStartRechts = 660;
    this.aantalDuinlijnen = 3;
    
    this.duinKleuren = new color[] {
      #E6B225, #BF941F, #997206
    };

    this.duinen = new float[this.aantalDuinlijnen][];
    for (int i = 0; i < this.aantalDuinlijnen; i++) {
      this.duinen[i] = new float[width + 1];
      for (int x = 0; x <= width; x++) {
        this.duinen[i][x] = 
          lerp(this.duinenStartLinks - i * 80, this.duinenStartRechts - i * 80, float(x) / width)
          - 140 * noise(x / 150. + 3 * i * width);
      }
    }
    
    this.aantalGolflijnen = 5;
    this.golfKleuren = new color[] {
      #449EFF, #40A2E6, #66CEFA, #6ACEE6, #96F2FA
    };
    this.golven = new float[this.aantalGolflijnen][];
    for (int i = 0; i < this.aantalGolflijnen; i++) {
      this.golven[i] = new float[width + 1];
    }
    
    this.update();
  }

  void update() {
    for (int i = 0; i < this.aantalGolflijnen; i++) {
      for (int x = 0; x <= width; x++) {
        this.golven[i][x] = 
          this.horizon + i * 60 
          + 70 * noise(x / 500. + 1.5 * (i + 10) * width, frameCount / 300.);
      }
    }
  }

  void display(float licht) {
    noStroke();
    
    fill(verdonker(lerpColor(this.luchtKleurDonker, this.luchtKleurLicht, licht), licht));
    quad(0, this.duinenStartLinks, 0, 0, width, 0, width, this.duinenStartRechts);
    
    color zonKleur = lerpColor(#ff0000, #ffff00, licht);
    fill(zonKleur);
    circle(2./3 * width, (1.0 - licht) * (0.6 * height) - 40, 100);
    for (int i = 0; i < 10; i++) {
      fill(zonKleur, 255 - i / 10.0 * 255);
      circle(2./3 * width, (1.0 - licht) * (0.6 * height) - 40, 100 + (i + 1) * 3 * licht);
    }
    
    
    for (int i = 0; i < this.aantalGolflijnen; i++) {
      fill(verdonker(this.golfKleuren[i], licht));
      beginShape();
      vertex(0, this.duinenStartLinks);
      for (int x = 0; x <= width; x++) {
        vertex(x, this.golven[i][x]);
      }
      vertex(width, this.duinenStartRechts);
      endShape();
    }
    
    for (int i = this.aantalDuinlijnen - 1; i >= 0; i--) {
      fill(verdonker(this.duinKleuren[i], licht));
      beginShape();
      vertex(0, this.duinenStartLinks);
      for (int x = 0; x <= width; x++) {
        vertex(x, this.duinen[i][x]);
      }
      vertex(width, this.duinenStartRechts);
      endShape();
    }
  }
}
