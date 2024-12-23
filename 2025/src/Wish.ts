import { Font } from "p5"

export class Wish {
    private font: Font

    private titleFade: number
    private wishFade: number

    constructor(font: Font) {
        this.font = font
        this.titleFade = 0
        this.wishFade = 0
    }

    update() {
        if (this.titleFade < 255) {
            this.titleFade += 128 * deltaTime / 1000
        } else if (this.wishFade < 255) {
            this.wishFade += 128 * deltaTime / 1000
        }
    }

    isDone() {
        return this.titleFade >= 255 && this.wishFade >= 255
    }

    display() {
        textAlign(CENTER, TOP)
        textFont(this.font)

        fill(250, 250, 250, this.titleFade)
        let title = "Fijne feestdagen!"
        if (window.location.hash === "#en") title = "Happy holidays!"
        textSize(100)
        text(title, 0, 0)
        
        fill(250, 250, 250, this.wishFade)
        let wish = "En een levendig 2025"
        if (window.location.hash === "#en") wish = "And a lively 2025"
        textSize(70)
        text(wish, -12, 105)
    }
}
