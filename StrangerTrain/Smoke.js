class Smoke {
    particles;

    constructor() {
        this.particles = [];
    }

    create(position) {
        this.particles.push(new SmokeParticle(position.copy().sub(random() * 10)));
        this.particles.push(new SmokeParticle(position.copy().sub(random() * 5)));
        this.particles.push(new SmokeParticle(position.copy()));
        this.particles.push(new SmokeParticle(position.copy().add(random() * 5)));
        this.particles.push(new SmokeParticle(position.copy().add(random() * 10)));
    }

    update(windForce) {
        for (let i = this.particles.length; i--; i >= 0) {
            this.particles[i].update(windForce);
            if (this.particles[i].isDead()) {
                this.particles.splice(i, 1);
            }
        }
    }

    display() {
        for (let particle of this.particles) {
            particle.display();
        }
    }
}
