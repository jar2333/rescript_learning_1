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

    // Lets even try some imperative algos:
    // Note: Circumventing the fact array access returns an Optional is a pain, but it's doable
    let insertionSort = (arr: array<int>) => {
        let n = Array.length(arr)

        let j = ref(0)
        let key = ref(0)
        for i in 1 to n-1 {
            Option.mapOr(
                arr[i],
                (),
                v => key := v
            )
            j := i - 1

            // Move elements of arr[0..i-1] that are greater than key 
            // to one position ahead of their current position
            while (j.contents >= 0 && Option.mapOr(arr[j.contents], false, v => v > key.contents)) {
                Option.mapOr(
                    arr[j.contents], 
                    (), 
                    Array.set(arr, j.contents + 1, ...)
                )

                j := j.contents - 1
            }
            arr[j.contents + 1] = key.contents;
        }
    }

    let unsorted_arr = [9, 2, 1, 6, 3, 1, 0, 6, 5]
    Console.log(unsorted_arr)
    insertionSort(unsorted_arr)
    Console.log(unsorted_arr)

    // By contrast, look at a quick sort:
    // We still suffer from the uglyness of Options
    // NOTE: Having more than 7 elements in the array blows up the call stack. Why? Is this THAT bloated?
    let rec quickSort = arr => {
        if Array.length(arr) <= 1 {
            arr
        }
        else {
            switch arr[Array.length(arr) / 2] {
                | Some(pivot) => {
                    let left   = arr->Array.filter(e => e < pivot)
                    let middle = arr->Array.filter(e => e == pivot) 
                    let right  = arr->Array.filter(e => e > pivot)
                    quickSort(left)->Array.concat(quickSort(middle))->Array.concat(quickSort(right))
                }
                | None => arr
            }
        }
    }

    let qs_arr = [6,1,4,2]
    Console.log(qs_arr)
    Console.log(quickSort(qs_arr))

    ()
}