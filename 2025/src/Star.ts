import { Color, Vector } from "p5"

export class Star {
    private position: Vector
    private size: number

    private rotation: number
    private noiseOffset: number
    private baseBrightness: number
    private color: Color

    constructor(position: Vector, size: number) {
        this.position = position
        this.size = size

        this.rotation = random(HALF_PI)
        this.noiseOffset = random(128)
        this.baseBrightness = random(100, 205)
        this.color = color(250, 255, 220, this.baseBrightness)
    }

    update() {
        this.color.setAlpha(this.baseBrightness + 100 * (noise(this.position.x + this.position.y, (this.noiseOffset + frameCount) / 60) - 0.5))
    }

    display() {
        push()
        translate(this.position)
        rotate(this.rotation)

        drawingContext.shadowColor = this.color
        drawingContext.shadowBlur = 20

        rectMode(CENTER)
        noStroke()
        fill(this.color)

        quad(0, -this.size / 2, this.size / 4, 0, 0, this.size / 2, -this.size / 4, 0)
        quad(0, -this.size / 4, this.size / 2, 0, 0, this.size / 4, -this.size / 2, 0)

        pop()
    }
}
