import Foundation

// print("Hello, world, from Swift! Echoing stdin. CTRL-D to stop")

/*
 This function just cleanly echoes its input. 
 */

fileprivate 
func echo(data: Data) -> Data {
    return data
}

/*

 `Greeter.service` implements a simple Alexa Custom Skill that says
 "Hello from Swift"

 */
let g = Greeter()
func greetResponse(data: Data) -> Data {
    return g.service(data: data)
}

/*

USER: if you want to define your own Lambda function in swift, just
define a function `f:(FileHandle)->Data` and call it with `standardInput`.

Be sure your function `f` expects a String containing JSON and returns
a String containing JSON.

*/

let data = FileHandle.standardInput.readDataToEndOfFile()

// echo: reads a string and returns it exactly
let result = echo(data: data)

// ALEXA: reads an Alexa Request envelope and returns a response
//readTransformPrint(transform:greetResponse)
//let result = greetResponse(data: data)
FileHandle.standardOutput.write(result)
