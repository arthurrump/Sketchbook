import { Vector } from "p5";
import { Cell, CellType } from "./Cell";

export const CELL_HEIGHT = 22
export const CELL_WIDTH = 10
export const CELL_MARGIN = 2

export const PATTERNS = [
    [
        "                             ",
        " ###### ###### ###### ###### ",
        "     ## ##  ##     ## ##     ",
        " ###### ##  ## ###### ###### ",
        " ##     ##  ## ##         ## ",
        " ###### ###### ###### ###### ",
        "                             ",
    ],
    [
        "                                  ",
        " ######   ######  ######  ####### ",
        "      ## ##  ####      ## ##      ",
        "  #####  ## ## ##  #####   ##### ",
        " ##      ####  ## ##           ## ",
        " #######  ######  ####### ####### ",
        "                                  ",
    ],
    [
        "                             ",
        "  ####    ###    ####  ##### ",
        " ##  ##  ## ##  ##  ## ##    ",
        "     ## ##   ##     ## ##    ",
        "  ####  ##   ##  ####  ####  ",
        " ##     ##   ## ##        ## ",
        " ##      ## ##  ##     ## ## ",
        " ######   ###   ######  ###  ",
        "                             ",
    ]
]

export class Tree {
    private cells: Cell[][]

    private active: boolean = false
    private lastEvolution: number = 0

    private pointerDown: boolean = false
    private interactedCells: Cell[] = []
    private lastManualInteraction: number = 0
    
    constructor(topPosition: Vector, height: number, trunkHeight: number, startPattern?: string[]) {
        const width = height * 2 + 1
        const trunkWidth = height / 3 % 2 === 0 ? height / 3 - 1 : height / 3

        let fromPatternOrRandom : (y: number, x: number, p: number) => CellType
        if (startPattern) {
            const patternHeight = startPattern.length
            const patternWidth = startPattern[0].length
            
            if (patternWidth > ((height - patternHeight) * 2 + 1))
                throw new Error("Pattern is too wide for tree")
            
            const patternFirstPossibleRow = patternWidth % 2 === 0 ? patternWidth / 2 : (patternWidth - 1) / 2
            const patternY = floor(patternFirstPossibleRow + (height - patternHeight - patternFirstPossibleRow) / 2)
            const patternX = floor((width - patternWidth) / 2)
            
            fromPatternOrRandom = (y, x, p) => {
                if (patternY <= y && y < patternY + patternHeight && patternX <= x && x < patternX + patternWidth)
                    return startPattern[y - patternY][x - patternX] === '#' ? "light" : "tree"
                else
                return random() > p ? "light" : "tree"
            }
        } else {
            fromPatternOrRandom = (y, x, p) => random() > p ? "light" : "tree"
        }

        this.cells = new Array(height)
        for (let y = 0; y < height + trunkHeight; y++) {
            if (y < height) {
                // Build the tree
                this.cells[y] = new Array(width)
                for (let x = height - y; x < height + y + 1; x++) {
                    let px = topPosition.x + (x - height) * (CELL_WIDTH + CELL_MARGIN)
                    let py = topPosition.y + y * (CELL_HEIGHT + CELL_MARGIN)
                    this.cells[y][x] = new Cell(
                        new Vector(px, py),
                        CELL_WIDTH,
                        CELL_HEIGHT,
                        fromPatternOrRandom(y, x, 0.9)
                    )
                }
            } else {
                // Add the trunk
                this.cells[y] = new Array(width)
                for (let x = (width - trunkWidth) / 2; x < (width + trunkWidth) / 2; x++) {
                    let px = topPosition.x + (x - height) * (CELL_WIDTH + CELL_MARGIN)
                    let py = topPosition.y + y * (CELL_HEIGHT + CELL_MARGIN)
                    this.cells[y][x] = new Cell(
                        new Vector(px, py),
                        CELL_WIDTH,
                        CELL_HEIGHT,
                        "trunk"
                    )
                }
            }
        }
    }

    neighbours(y: number, x: number) {
        const result: Cell[] = []
        const pushIfNotUndefined = (y: number, x: number) => {
            if (this.cells[y] !== undefined && this.cells[y][x] !== undefined)
                result.push(this.cells[y][x])
        }
        pushIfNotUndefined(y - 1, x - 1) // above left
        pushIfNotUndefined(y - 1, x) // above
        pushIfNotUndefined(y - 1, x + 1) // above right
        pushIfNotUndefined(y, x + 1) // right
        pushIfNotUndefined(y + 1, x + 1) // under right
        pushIfNotUndefined(y + 1, x) // under
        pushIfNotUndefined(y + 1, x - 1) // under left
        pushIfNotUndefined(y, x - 1) // left
        return result
    }

    pointerPressed(pointer: Vector) {
        this.pointerDown = true
        this.interactedCells = []
        for (const row of this.cells) {
            for (const cell of row) {
                if (cell && cell.covers(pointer)) {
                    cell.toggle()
                    this.interactedCells.push(cell)
                    this.lastManualInteraction = millis()
                }
            }
        }
    }

    pointerDragged(pointer: Vector) {
        for (const row of this.cells) {
            for (const cell of row) {
                if (cell && cell.covers(pointer) && !this.interactedCells.includes(cell)) {
                    cell.toggle()
                    this.interactedCells.push(cell)
                    this.lastManualInteraction = millis()
                }
            }
        }
    }

    pointerReleased() {
        this.pointerDown = false
    }

    start() {
        this.active = true
    }

    stop() {
        this.active = false
    }

    isActive() {
        return this.active
    }

    update() {
        const now = millis()
        if (this.active && !this.pointerDown && now - this.lastEvolution > 1000 && now - this.lastManualInteraction > 3000) {
            this.evolve()
        }
    }
    
    evolve() {
        for (let y = 0; y < this.cells.length; y++) {
            for (let x = 0; x < this.cells[y].length; x++) {
                const cell = this.cells[y][x]
                if (cell) {
                    const n = this.neighbours(y, x)
                    const lightN = n.filter(cell => cell.isLight()).length
                    const trunkN = n.filter(cell => cell.isTrunk()).length
                    if (cell.isLight() && (lightN >= 4 || lightN < 2)) {
                        cell.toggleNext()
                    } else if (cell.isTree() && (lightN === 3 || random() * trunkN > 0.95)) {
                        cell.toggleNext()
                    }
                }
            }
        }

        // Actually swap over each cell state
        for (const row of this.cells) {
            for (const cell of row) {
                if (cell) cell.next()
            }
        }

        this.lastEvolution = millis()
    }

    display() {
        for (const row of this.cells) {
            for (const cell of row) {
                if (cell) cell.display()
            }
        }
    }
}
