import { Vector } from "p5"

export class Button {
    private text: string
    private onPressed: () => void
    private onReleased: () => void

    private position: Vector
    private width: number
    private height: number

    private isPressed: boolean
    private opacity: number

    constructor(text: string, position: Vector, width: number, height: number, onPressed: () => void, onReleased: () => void) {
        this.text = text
        this.onPressed = onPressed
        this.onReleased = onReleased
        this.position = position
        this.width = width
        this.height = height
        this.isPressed = false
        this.opacity = 0
    }

    update() {
        if (this.opacity < 255) {
            this.opacity += 255 * deltaTime / 1000
        }
    }

    display() {
        push()
        if (this.isPressed) fill(250, 250, 250, 75 * this.opacity / 255)
        else noFill()
        stroke(250, 250, 250, this.opacity)
        strokeWeight(5)
        rect(this.position.x, this.position.y, this.width, this.height, 0.1 * min(this.width, this.height))
        pop()

        push()
        fill(250, 250, 250, this.opacity)
        textFont("CommitMono Bold")
        textAlign(CENTER, CENTER)
        textSize(this.height * 0.9)
        text(this.text, this.position.x + this.width / 2, this.position.y + this.height / 2)
        pop()
    }

    isOver(pointer: Vector) {
        return this.position.x < pointer.x && 
            pointer.x < this.position.x + this.width &&
            this.position.y < pointer.y && 
            pointer.y < this.position.y + this.height
    }

    pressed(pointer: Vector) {
        if (this.isOver(pointer)) {
            this.onPressed()
            this.isPressed = true
        }
    }

    released() {
        if (this.isPressed) {
            this.onReleased()
            this.isPressed = false
        }
    }
}