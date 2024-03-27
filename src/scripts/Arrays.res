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
    Console.log("Imperative insertion sort (featuring getUnsafe & setUnsafe):")

    let insertionSort = (arr: array<int>) => {
        open Array

        let n = length(arr)

        let j = ref(0)
        let key = ref(0)
        for i in 1 to n-1 {
            key := arr->getUnsafe(i)
            j := i - 1

            // Move elements of arr[0..i-1] that are greater than key 
            // to one position ahead of their current position
            while (j.contents >= 0 && arr->getUnsafe(j.contents) > key.contents) {
                arr->set(j.contents + 1, arr->getUnsafe(j.contents))
                j := j.contents - 1
            }
            arr->setUnsafe(j.contents + 1, key.contents);
        }
    }

    let unsorted_arr = [9, 2, 1, 6, 3, 1, 0, 6, 5]
    Console.log(unsorted_arr)
    insertionSort(unsorted_arr)
    Console.log(unsorted_arr)

    // By contrast, look at a quick sort:
    // We still suffer from the uglyness of Options
    // NOTE: Having more than 7 elements in the array blows up the call stack. Why? Is this THAT bloated?
    Console.log("Quick sort using filters/concats")

    let rec quickSort = (arr) => {
        open Array
        if length(arr) <= 1 {
            arr
        }
        else {
            let pivot  = arr->getUnsafe(length(arr) / 2) 
            let left   = arr->filter(e => e < pivot)
            let middle = arr->filter(e => e == pivot) 
            let right  = arr->filter(e => e > pivot)
            quickSort(left)->concat(quickSort(middle))->concat(quickSort(right))
        }
    }

    let qs_arr = [6,1,4,2]
    Console.log(qs_arr)
    Console.log(quickSort(qs_arr))

    ()
}