class Fire {
  ArrayList<FireParticle> particles;
  
  Fire() {
    particles = new ArrayList<FireParticle>();
  }
  
  void update(PVector startPosition) {
    particles.add(new FireParticle(noise(frameCount), startPosition.copy(), new PVector(0, 0)));
    
    for (int i = particles.size() - 1; i >= 0; i--) {
      particles.get(i).update();
      
      if (particles.get(i).isDead()) {
        particles.remove(i);
      }
    }
  }
  
  void display() {
    for (int i = 0; i < particles.size(); i++) {
      particles.get(i).display();
    }
  }

}
