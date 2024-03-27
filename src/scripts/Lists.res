let name = __MODULE__

let test = () => {

    // Lists! They are not as efficient here as in OCaml and Haskell, due to being interpreted on top of JS
    // This means that they should only be used when most necessary, or when doing pure functional programming.
    // Nevertheless, they retain their OCaml API, so are very pleasant to do FP with.

    let fst_lst: list<int> = list{1, 2, 3}
    Console.log(fst_lst)

    // NOTE: NO CONS OPERATOR???? NO WAY
    // Bug I encountered and had issues debugging: was returning lst: list<'a>, and checker was still okaying the function. sus.
    let rec fmap: (list<'a>, 'a => 'b) => list<'b> = (lst: list<'a>, f: 'a => 'b) => {
        switch lst {
            | list{} => list{}
            | list{hd, ...xs} => (List.add(fmap(xs, f), f(hd)) : list<'b>)
        }
    }

    let snd_lst = fst_lst->fmap(i => String.repeat("a", i))
    Console.log(snd_lst)


    // Lets define a merge sort!
    let mergeSort: list<'a> => list<'a> = lst => {
        let size = List.length(lst)

        let rec helper = (lst, len) => {
            switch lst {
                | list{} | list{_} => lst
                | _ => {
                    let mid_point = len/2
                    let (left, right) = Option.getOr(
                        lst->List.splitAt(mid_point), 
                        (lst, list{})
                    )
                    let sorted_left  = helper(left, mid_point)
                    let sorted_right = helper(right, len - mid_point)

                    // Walk both lists element by element, rearranging based on comparison
                    let rec walk = (l, r) => {
                        switch (l, r) {
                            | (_, list{}) => l
                            | (list{}, _) => r
                            | (list{lh, ...lxs}, list{rh, ...rxs}) => {
                                if lh <= rh {
                                    walk(lxs, r)->List.add(lh)
                                }
                                else {
                                    walk(l, rxs)->List.add(rh)
                                }
                            }
                        }
                    }
                    walk(sorted_left, sorted_right)
                } 
            }
        }
        helper(lst, size)
    }

    let unsorted_lst = list{3, 6, 7, 2, 4, 12, 1}
    Console.log(unsorted_lst->List.toArray)
    Console.log(mergeSort(unsorted_lst)->List.toArray)

    ()
}