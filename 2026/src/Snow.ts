import { Vector } from "p5"

class SnowFlake {
    private position: Vector
    private velocity: Vector
    private rotation: number
    private rotationVelocity: number
    private size: number
    private alpha: number

    constructor() {
        this.reset()
    }

    reset() {
        this.position = new Vector(random(640), random(-960))
        this.velocity = new Vector(random(-0.01, 0.01), random(0.05, 0.2))
        this.rotation = random(2 * PI)
        this.rotationVelocity = random(-0.0005, 0.0005)
        this.size = random (10, 20)
        this.alpha = random(100, 200)
    }

    display() {
        textAlign(CENTER, CENTER)
        textFont("CommitMono Bold")
        textSize(this.size)
        fill(250, 250, 250, this.alpha)
        push()
        translate(this.position)
        rotate(this.rotation)
        text("*", 0, 0)
        pop()
    }

    update() {
        this.position.y += deltaTime * this.velocity.y
        this.position.x += deltaTime * this.velocity.x
        this.rotation += deltaTime * this.rotationVelocity

        if (this.position.y > 960) {
            this.reset()
        }
    }
}

export class Snow {
    private flakes: SnowFlake[]

    constructor(flakeCount: number) {
        this.flakes = Array(flakeCount)
        for (let i = 0; i < flakeCount; i++) {
            this.flakes[i] = new SnowFlake()
        }
    }

    update() {
        for (const flake of this.flakes) {
            flake.update()
        }
    }

    display() {
        push()
        for (const flake of this.flakes) {
            flake.display()
        }
        pop()
    }
}