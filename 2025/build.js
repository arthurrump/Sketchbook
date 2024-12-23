const { build, context } = require("esbuild")
const { copy } = require("esbuild-plugin-copy")

const entryPoints = [
    "src/index.html",
    "src/index.ts"
]

function config() {
    return {
        entryPoints,
        outdir: "dist",
        bundle: true,
        sourcemap: true,
        loader: {
            ".woff": "file",
            ".eot": "file",
            ".ttf": "file",
            ".html": "copy"
        },
        
        plugins: [
            copy({
                assets: {
                    from: [ "./src/resc/**/*" ],
                    to: [ "./resc" ]
                }
            })
        ],
        logLevel: "info"
    }
}

switch (process.argv[2]) {
    case "serve":
        (async () => {
            const ctx = await context({
                ...config(false),
                inject: [ "live-reload.js" ]
            })
            await ctx.watch()
            await ctx.serve({
                servedir: "dist"
            })
        })()
        break;
    case "build":
        build({
            ...config(true),
            minify: true
        })
        break;
    default:
        console.warn("Specify either serve or build as an argument.")
        break;
}
