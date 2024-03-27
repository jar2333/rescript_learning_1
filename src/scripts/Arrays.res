let name = __MODULE__

let test = () => {
    // JavaScript arrays! They are wonderful, since they resemble Python lists.
    let arr = [1, 2, 3]

    // You can mutate these. It compiles to basic JS mutable arrays!
    arr->Array.push(4)

    switch Array.last(arr) {
        | Some(4) => Console.log("mutable")
        | Some(_) | None => Console.log("immutable") 
    }

    // It provides a parameterized constructor which taps into the dynamic typing of JS
    // NOTE: Do not forget that named args in ReScript/OCaml must be labeled
    let threes: array<string> = Array.make(~length=3, "three")
    threes->Array.forEach(Console.log)


    // The wonderful JS Array API is provided here in full. Go nuts!
    let a = [1, 2, 3]
    let b = [6, 7, 9]
    let c = Array.concat(a, b)

    let d = c->Array.map(v => String.make(v)++": "++String.repeat("a", v))
    Console.log(d)

    ()
}