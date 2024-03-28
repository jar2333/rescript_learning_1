let name: string = "Let bindings"

let test = () => {
    // Let binding
    let greeting = "hello!"
    Console.log(greeting)

    // Scoped bindings
    let displayGreeting = true
    let message = "Whatever :("
    if displayGreeting {
        let message = "Hello :)"
        Console.log(message)
    }
    else {
        Console.log(message)
    }

}