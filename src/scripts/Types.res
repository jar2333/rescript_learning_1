let name = __MODULE__

type alias = int
type vector2<'a> = ('a, 'a)

type rec tree<'a> = {
  val: 'a,
  children: array<tree<'a>>
}

let test = () => {

    // Type alias
    let x: alias = 10

    Console.log(x)

    // Type parameters / Generics
    let v: vector2<int> = (1, 2)

    Console.log(v)

    // Recursive trees
    let rec fmap = (f: 'a => 'b, t: tree<'a>): tree<'b> => {
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