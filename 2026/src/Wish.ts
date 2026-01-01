export class Wish {
    private titleFade: number
    private wishFade: number
    private status: "fadein" | "fadeout"

    constructor() {
        this.titleFade = 0
        this.wishFade = 0
        this.status = "fadein"
    }

    update() {
        if (this.status === "fadein") {
            if (this.titleFade < 255) {
                this.titleFade += 128 * deltaTime / 1000
            } else if (this.wishFade < 255) {
                this.wishFade += 128 * deltaTime / 1000
            }
        } else if (this.status === "fadeout") {
            if (this.wishFade > 0) {
                this.wishFade -= 255 * deltaTime / 1000
            }
        }
    }

    isTitleDone() {
        return this.titleFade >= 255
    }

    isDone() {
        return this.titleFade >= 255 && this.wishFade >= 255
    }

    fadeOut() {
        this.status = "fadeout"
    }

    display() {
        textAlign(CENTER, TOP)
        textFont("CommitMono Bold")

        fill(250, 250, 250, this.titleFade)
        let title = "Gelukkig\nnieuwjaar!"
        if (window.location.hash === "#en") title = "Happy\nnew year!"
        textSize(80)
        text(title, 0, 50)
        
        fill(250, 250, 250, this.wishFade)
        let wish = "Dat je in 2026\nje weg mag vinden."
        if (window.location.hash === "#en") wish = "That you may find\nyour way in 2026."
        textSize(40)
        text(wish, 0, 810)
    }
}
