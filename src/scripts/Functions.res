let name = __MODULE__

let test = () => {

    // Functions declaration right now is limited to let binding of lambdas.
    let fn1 = () => {
        Console.log("Hi from fn1 :)")
    }
    fn1()

    // You can type functions in two different ways:
    // 1) Typing the let binding
    // 2) Typing the argument and the return type
    // 
    // The pros and cons:
    // 1) You must type the whole binding, no partial specification. Looks ugly.
    // 2) You can type only certain arguments of interest, or just the return. Looks better.

    let fn2: (int, string) => string = (i, s) => {
        s ++ Int.toString(i)
    }

    let fn3 = (i: int, s: string): string => {
        s ++ Int.toString(i)
    }

    Console.log(fn2(2, "Hello from fn"))
    Console.log(fn3(3, "Hello from fn"))

    // Functions are first-class in ReScript, no surprises here.
    // Note: To call a lambda, parenthesize it
    let sum = ((a, b) => {
        "Sum: "++String.make(a+b)
    })(1, 3)
    Console.log(sum)

    // Labelled arguments means that you don't have to worry about getting positional args wrong
    // They can also have default values!

    let fn4 = (~x="0": string, ~y: string) => {
        Console.log("Coordinates: " ++ x ++ ", " ++ y)
    }
    fn4(~x="1", ~y="2")

    // You can make aliases for the labelled arguments, using the as keyword
    let fn5 = (~configuration as conf: array<(string, 'a)>) => {
        Console.log("Booting up...")
        if conf->Array.length > 0 {
            Console.log("Configuration:")
            conf->Array.forEach(v => {
                let (key, value) = v
                Console.log(key ++ ": " ++ String.make(value))
            })
        }
    }
    fn5(~configuration=[("barnaby", 3), ("wallaby", 5)])


    // Optional labelled arguments are weird
    // From outside, it looks like you pass in either nothing at all or a raw value of type 'a
    // From inside, the raw value is always wrapped in an optional<'a>
    // Thus, it is nothing but a bit of syntactic sugar, but the type annotation in each case is different
    // Add =? to the end to denote an optional argument

    // The importance of the signature, from the manual:
    // The first line is the function's signature, we would define it like that in an interface file (see Signatures). 
    // The function's signature describes the types that the outside world interacts with, hence the type int for 
    // radius because it indeed expects an int when called.

    let drawCircle: (~length: int, ~radius: int=?) => unit =
        (~length: int, ~radius: option<int>=?) => {
            switch radius {
            | None => Console.log("A line of length "++Int.toString(length))
            | Some(r) => Console.log(`A cylinder of length ${Int.toString(length)} and diameter ${Int.toString(2*r)}`)
            }
        }

    drawCircle(~length=10)
    drawCircle(~length=4, ~radius=1)

    // If we have an item in an optional<'a> and we wish to quickly pass it to a function with an optional arg,
    // We can unwrap it with ?
    let potential_radius = None
    drawCircle(~length=22, ~radius=?potential_radius)
    ()

    // Mutually rescursive functions:

    let rec callSecond = (count) => {
        Console.log("Hello "++Int.toString(count))
        callFirst(count-1)
    }
    and callFirst = (count) => {
        if count > 0 {
            callSecond(count)
        }
    }

    callFirst(5)


    // Ignore function to discard the output of a function
    let three = () => 3
    three->ignore
}