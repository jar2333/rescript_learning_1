let name = __MODULE__

type alias = int
type vector2<'a> = ('a, 'a)

type rec tree<'a> = {
  val: 'a,
  children: array<tree<'a>>
}

// Figure out currying so I can add an indent counter here!!!
let pretty_print = (t) => {
    let base = "    "
    let rec helper: (int, tree<string>) => string = (count, t) => {
        let {val: v, children: ch} = t

        let ind = String.repeat(base, count)

        let print_children = (ch) => {
            switch ch {
                | [] => "[]"
                | _  => {
                    let rest = ch->
                                Array.map(helper(count+1, ...))->
                                Array.joinWith(`,\n${ind}`)
                    `
                    [
                    ${ind}    ${rest}
                    ]
                    `
                }
            }
        }
        `
        ${ind}{
        ${ind}    val: ${v}
        ${ind}    children: ${print_children(ch)}
        ${ind}}
        `
    }
    helper(0, t)
}

let test = () => {

    // Type alias
    let x: alias = 10

    Console.log(x)

    // Type parameters / Generics
    let v: vector2<int> = (1, 2)

    Console.log(v)

    // Recursive trees
    let rec fmap: (('a => 'b), tree<'a>) => tree<'b> = (f, t) => {
        let {val: v, children: c} = t
        {
            val: f(v),
            children: Array.map(c, fmap(f, ...))
        }
    }

    let t = {
        val: 0,
        children: [
            {
                val: 1,
                children: []
            },
            {
                val: 2,
                children: [
                    {
                        val: 3,
                        children: []
                    }
                ]
            }
        ]
    }

    let mapped_t = fmap((v) => {
        String.repeat("a", v)
    }, t)

    Console.log(mapped_t)

    ()
}