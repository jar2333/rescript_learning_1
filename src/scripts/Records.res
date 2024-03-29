let name = __MODULE__

type worker = {
  name: string,
  job: string,
  happy: boolean
}

type user = {
    username: string,
    mutable displayname: string, // Mutable field
    email?: string // Optional field
}

// you can now spread one or more record types into a new record type
type job_site_user = {
    ...worker,
    ...user,
    resume_link: string
}

type color = Red | Blue | Green | Yellow | Orange | Purple

type fruit = {
    color: color,
    price: float
}

type vegetable = {
    color: color,
    price: float
}


let test = () => {

    // Records are just like OCaml records
    let a = {
        name: "jonesy",
        job: "software developer",
        happy: true
    }

    // The type is inferred to be the nearest type that matches the shape
    // If this is correct, no need to manually annotate using a constructor or whatnot
    // Otherwise, if the type resides in another file or is above the nearest, explicity annotate!
    let b: worker = a
    assert a == b

    // Immutable update syntax (create a copy while changing some attributes):
    let c = {
        ...b,
        happy: false
    }

    // Access syntax
    assert c.happy == false

    // Record types can have mutable fields
    let user: user = {
        username: "jar2333",
        displayname: "jar2333"
    }
    Console.log(user)

    user.displayname = "Jose Ramos"
    Console.log(user)

    // Optional fields can be initialized or not
    let user2: user = {
        username: "woofer",
        displayname: "Woofler Woofington",
        email: "woof@dog.net"
    }

    // In an immutable update, you can set the value like in assignment
    let user3: user = {
        ...user2,
        email: "barker@gmail.com"
    }

    // You can also set it with an optional, if you unwrap with ?
    let user4: user = {
        ...user2,
        email: ?Some("borker@hotmail.com")
    }

    // ... this ends up useful to unset a field
    let user5: user = {
        ...user2,
        email: ?None
    }

    // Like optional function arguments, this ends up as syntactic sugar over an option type
    // For the purposes of pattern matching the field itself, you treat it as an optional
    let check_email = (u) => switch u.email {
        | Some(e) => Console.log("email: "++e)
        | None => Console.log("no email")
    }
    check_email(user2)
    check_email(user5)


    // However, when pattern matching the whole record, it is treated as the underlying type
    let is_woofdog = (u) => switch u {
        | {username:_, displayname: _, email:"woof@dog.net"} => true
        | _ => false
    }
    is_woofdog(user2)->Console.log
    is_woofdog(user5)->Console.log

    // As before, you can use ? to actually match on the underlying option
    let has_email = (u) => switch u {
        | {username:_, displayname:_, email:?None} => false
        | _ => true
    }
    has_email(user2)->Console.log
    has_email(user5)->Console.log

    // You can spread two record types into another, similar to Go struct embeds!
    // See above type definition
    let job_site_user: job_site_user = {
        username: "jamo",
        displayname: "Jonesy Montserrat",
        name: "Jonathan Alouette Montserrat",
        happy: false,
        email: "jamo@hotmail.com"
    }

    // You can coerce a record type to another iff they both share the same fields of the same types
    let tomato: vegetable = {
        color: Red,
        price: 2.99
    }

    let evaluate_fruit = (v: fruit) => {
        let {color:_, price: p} = v
        if p > 5.0 {
            Console.log("Too expensive!")
        }
        else {
            Console.log("Cheap enough!")
        }
    } 
    // We coerce tomato to be of type fruit >:)
    evaluate_vegetable(tomato :> fruit)


    // We can generally coerce a record type to another if the type's fields are a superset of the target record type's
    has_email(job_site_user :> user)->Console.log

    // You can coerce a record field of type optional<'a> to an optional record field of type 'a

    ()
}