/**
 * -------------------------------
 * Run all tests from each module
 * -------------------------------
 */
module type Test = {
    let test: () => unit
    let name: string
}

module MakeRunnable = (M : Test) => {
    let run = () => {
        Console.log("=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=")
        Console.log("Running test: " ++ M.name)
        M.test()
        Console.log("=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=")
    } 
}

module L = MakeRunnable(Let)
L.run()

module T = MakeRunnable(Types)
T.run()

module A = MakeRunnable(Arrays)
A.run()

module Li = MakeRunnable(Lists)
Li.run()

module Fs = MakeRunnable(Functions)
Fs.run()


