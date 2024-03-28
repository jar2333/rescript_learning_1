// import the method in js_snippets.js
@module("./js_snippets.js") 
external someJsFunctionThatThrows: () => unit = "someJsFunctionThatThrows"

exception ExampleException(string)
exception CustomException

let name = __MODULE__

let test = () => {

    // You can raise exceptions, defining them beforehand
    let exn1 = (count) => {
        if count < 0 {
            raise(CustomException)
        }
        else {
            Console.log("Count: "++Int.toString(count))
        }
    }

    // It can be caught using try-catch syntax
    try { 
        exn1(-1)
    } catch {
        | CustomException => Console.log("Caught exception!")
    }

    // You can also use pattern matching to match on an exception
    // This is very nice, since it allows easy wrapping of Exception-based
    // APIs to one using Result or Option
    // Notice how try-catch seems to be merely syntactic sugar.
    
    let wrap = (count) => switch exn1(count) {
        | () => Console.log("No exception!")
        | exception CustomException => Console.log("Yes exception!")
    }

    wrap(1)
    wrap(-1)

    // You can define custom exceptions which are similar to variants (can be pattern matched, hold data) 

    try {
        raise(ExampleException("Big error"))
    } catch {
        | ExampleException(s) => Console.log("Exception caught: "++s)
    }

    // JS exceptions are encapsulated by the standard library's Js.Exn module. 
    // Js.Exn.Error holds the exception object. Use functions in the API to access its data

    let catch_js = (f) => try {
        f() 
    } catch {
        | Js.Exn.Error(obj) => {
            switch Js.Exn.message(obj) {
                | Some(m) => Console.log("Caught a JS exception! Message: " ++ m)
                | None => ()
            }
        }
    }

    // Catch an exception from a function imported from JS
    catch_js(someJsFunctionThatThrows)

    // You can also raise JS exceptions from ReScript
    catch_js(() => {
        Js.Exn.raiseError("JS Exception from ReScript!!")
    })

    // ReScript exceptions can also be caught from JS, although that hopefully wont be needed much (check manual)
    // The exception on the JS side takes the shape of an object with minimum fields:
    // {RE_EXN_ID, Error, ...}
    // where ... includes any data you have put in the exception, and Error contains the usual debug information

    ()
}