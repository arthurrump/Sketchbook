// A maze is a graph, where nodes are identified by a single number.
// The nodes in a 4 width, 3 height maze are numbered as:
// 8  9  10 11 
// 4  5  6  7  
// 0  1  2  3

class MazeGraph {
    private readonly width: number
    private readonly height: number

    // Edges indicate a lack of walls between two cells, which are stored in a
    // minimised adjacency matrix. The first index should always be the maximum
    // of the two and self-loops are not stored.
    private adjacencyMatrix: boolean[][]

    constructor(width: number, height: number) {
        this.width = width
        this.height = height

        this.adjacencyMatrix = new Array(width * height)
        for (let i = 0; i < width * height; i++) {
            this.adjacencyMatrix[i] = new Array(i)
        }
    }

    static random(width: number, height: number) {
        const graph = new MazeGraph(width, height)
        const visited: boolean[] = new Array(width * height)
        visited[0] = true
        const stack = [ 0 ]
        while (stack.length > 0) {
            const current = stack.pop()!
            const unvisitedNeighbours = graph.allNeighbours(current).filter(n => !visited[n])
            if (unvisitedNeighbours.length > 0) {
                stack.push(current)
                const randomNeighbour = random(unvisitedNeighbours)
                graph.removeWall(current, randomNeighbour)
                visited[randomNeighbour] = true
                stack.push(randomNeighbour)
            }
        }
        return graph
    }

    right(cell: number) {
        if (cell % this.width !== this.width - 1)
            return cell + 1
    }
    
    left(cell: number) {
        if (cell % this.width !== 0)
            return cell - 1
    }
    
    above(cell: number) {
        if (cell + this.width < this.width * this.height)
            return cell + this.width
    }
    
    under(cell: number) {
        if (cell - this.width >= 0)
            return cell - this.width
    }

    addEdge(cell1: number, cell2: number) {
        this.adjacencyMatrix[max(cell1, cell2)][min(cell1, cell2)] = true
    }

    removeEdge(cell1: number, cell2: number) {
        this.adjacencyMatrix[max(cell1, cell2)][min(cell1, cell2)] = false
    }

    hasEdge(cell1: number, cell2: number) {
        return cell1 === cell2 || this.adjacencyMatrix[max(cell1, cell2)][min(cell1, cell2)]
    }

    addWall(cell1: number, cell2: number) {
        this.removeEdge(cell1, cell2)
    }

    removeWall(cell1: number, cell2: number) {
        this.addEdge(cell1, cell2)
    }

    hasWall(cell1: number, cell2: number) {
        return !this.hasEdge(cell1, cell2)
    }

    allNeighbours(cell: number) {
        return [ 
            this.right(cell),
            this.left(cell),
            this.above(cell),
            this.under(cell) 
        ].filter(n => n !== undefined)
    }

    neighbours(cell: number) {
        return this.allNeighbours(cell).filter(n => this.hasEdge(cell, n))
    }

    toGrid() {
        const translateCell = (cell: number) => {
            const row = floor(cell / this.width)
            const col = cell % this.width
            const newWidth = 2 * this.width + 1
            const newRow = 2 * row + 1
            const newCol = 2 * col + 1
            return newRow * newWidth + newCol
        }

        const grid = new MazeGrid(2 * this.width + 1, 2 * this.height + 1)
        for (let i = 0; i < this.width * this.height; i++) {
            grid.setCell(translateCell(i), true)
        }

        for (let i = 0; i < this.width * this.height; i++) {
            const above = this.above(i)
            if (above !== undefined && this.hasEdge(i, above)) {
                grid.setCell(grid.above(translateCell(i))!, true)
            }
            const right = this.right(i)
            if (right !== undefined && this.hasEdge(i, right)) {
                grid.setCell(grid.right(translateCell(i))!, true)
            }
        }

        return grid
    }
}

class MazeGrid {
    readonly width: number
    readonly height: number

    // A maze is a grid, where cells are identified by a single number.
    // The cells in a 4 width, 3 height maze are numbered as:
    // 8  9  10 11 
    // 4  5  6  7  
    // 0  1  2  3
    private readonly cells: boolean[]

    constructor(width: number, height: number, cells = new Array<boolean>(width * height)) {
        this.width = width
        this.height = height

        this.cells = cells
    }

    right(cell: number) {
        if (cell % this.width !== this.width - 1)
            return cell + 1
    }
    
    left(cell: number) {
        if (cell % this.width !== 0)
            return cell - 1
    }
        
    above(cell: number) {
        if (cell + this.width < this.width * this.height)
            return cell + this.width
    }

    under(cell: number) {
        if (cell - this.width >= 0)
            return cell - this.width
    }
    
    allNeighbours(cell: number) {
        return [ 
            this.right(cell),
            this.left(cell),
            this.above(cell),
            this.under(cell) 
        ].filter(n => n !== undefined)
    }

    neighbours(cell: number) {
        return this.allNeighbours(cell).filter(this.getCell)
    }

    getCell(cell: number) {
        return this.cells[cell]
    }

    setCell(cell: number, value: boolean) {
        this.cells[cell] = value
    }

    getCells() {
        return [ ...this.cells ]
    }

    static stack(grids: MazeGrid[]) {
        const width = grids[0].width
        const height = grids.map(g => g.height).reduce((x, y) => x + y)
        return new MazeGrid(width, height, grids.reverse().map(g => g.getCells()).flat())
    }

    toString() {
        let results = [ "" ]
        for (let i = 0; i < this.width * this.height; i++) {
            results[results.length - 1] += this.getCell(i) ? " " : "#"
            if (i % this.width === this.width - 1) results.push("")
        }
        return results.reverse().join("\n")
    }

    static fromString(str: string) {
        const rows = str.split("\n").reverse()
        const width = rows[0].length
        const height = rows.length
        const grid = new MazeGrid(width, height)
        for (let row = 0; row < height; row++) {
            for (let col = 0; col < width; col++) {
                if (rows[row][col] === " ") {
                    grid.setCell(row * width + col, true)
                }
            }
        }
        return grid
    }
}

export class Maze {
    readonly CELL_SIZE = 17
    readonly WIDTH = 27
    readonly HEIGHT = 29

    private visible: boolean
    private opacity: number

    private grid: MazeGrid
    private playerPosition: number
    private playerMoving: "u" | "d" | "l" | "r" | undefined
    private playerLastMoved: number

    private playerColor = color(250, 250, 250)
    private startPosition = (this.WIDTH - 1) / 2
    private endPosition = (this.HEIGHT - 1) * this.WIDTH + (this.WIDTH - 1) / 2

    constructor() {
        this.visible = false
        this.opacity = 0

        const top = MazeGraph.random(13, 5).toGrid()
        top.setCell(10 * this.WIDTH + (this.WIDTH - 1) / 2, true)
        top.setCell(9 * this.WIDTH + (this.WIDTH - 1) / 2, true)
        top.setCell(this.WIDTH - 2, true)
        const middle = MazeGrid.fromString([
                "#                         #",
                "# ##### ##### ##### ##### #",
                "#     # #   #     # #     #",
                "# ##### #   # ##### ##### #",
                "# #     #   # #     #   # #",
                "# ##### ##### ##### ##### #",
                "#                         #",
            ].join("\n"))
        const bottom = MazeGraph.random(13, 5).toGrid()
        bottom.setCell((this.WIDTH - 1) / 2, true)
        bottom.setCell(this.WIDTH + (this.WIDTH - 1) / 2, true)
        bottom.setCell(10 * this.WIDTH + 1, true)
        this.grid = MazeGrid.stack([ top, middle, bottom ])

        this.playerPosition = this.startPosition
        this.playerMoving = undefined
        this.playerLastMoved = 0
    }

    setVisible(visible: boolean) {
        this.visible = visible
    }

    restart() {
        this.grid = MazeGraph.random(13, 14).toGrid()
        this.grid.setCell(this.startPosition, true)
        this.grid.setCell(this.endPosition, true)
        const tmp = this.startPosition
        this.startPosition = this.endPosition
        this.endPosition = tmp

        colorMode(HSB, 100)
        this.playerColor = color(random(100), 100, 100)
        colorMode(RGB)
    }

    update() {
        if (this.visible && this.opacity < 255) {
            this.opacity += 128 * deltaTime / 1000
        }

        if (this.playerMoving !== undefined && millis() - this.playerLastMoved > 200) {
            switch (this.playerMoving) {
                case "u":
                    const above = this.grid.above(this.playerPosition)
                    if (above !== undefined && this.grid.getCell(above))
                        this.playerPosition = above
                    break
                case "d":
                    const under = this.grid.under(this.playerPosition)
                    if (under !== undefined && this.grid.getCell(under))
                        this.playerPosition = under
                    break
                case "l":
                    const left = this.grid.left(this.playerPosition)
                    if (left !== undefined && this.grid.getCell(left))
                        this.playerPosition = left
                    break
                case "r":
                    const right = this.grid.right(this.playerPosition)
                    if (right !== undefined && this.grid.getCell(right))
                        this.playerPosition = right
                    break
            }

            this.playerLastMoved = millis()
            if (this.playerPosition == this.endPosition) 
                this.restart()
        }
    }

    display() {
        const x = (i: number) => i % this.WIDTH * this.CELL_SIZE
        const y = (i: number) => -floor(i / this.WIDTH) * this.CELL_SIZE

        fill(250, 250, 250, this.opacity)
        textFont("CommitMono Bold")
        textSize(this.CELL_SIZE * 1.5)
        textAlign(LEFT, BOTTOM)
        for (let i = 0; i < this.grid.width * this.grid.height; i++) {
            if (!this.grid.getCell(i)) {
                text("*", x(i), y(i))
            }
        }

        fill(red(this.playerColor), green(this.playerColor), blue(this.playerColor), this.opacity)
        text("o", x(this.playerPosition), y(this.playerPosition))
    }

    movingUp() {
        this.playerMoving = "u"
    }

    movingDown() {
        this.playerMoving = "d"
    }

    movingLeft() {
        this.playerMoving = "l"
    }

    movingRight() {
        this.playerMoving = "r"
    }

    stopMoving() {
        this.playerMoving = undefined
        this.playerLastMoved = 0
    }
}
