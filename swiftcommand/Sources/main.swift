import Foundation

// print("Hello, world, from Swift! Echoing stdin. CTRL-D to stop")

/*
 This function just cleanly echoes its input. 
 */

fileprivate 
func echo(fileHandle: FileHandle) -> Data {
    return fileHandle.readDataToEndOfFile()
}

/*

 `Greeter.service` implements a simple Alexa Custom Skill that says
 "Hello from Swift"

 */
let g = Greeter()
func greetResponse(fileHandle: FileHandle) -> Data {
    return g.service(fileHandle: fileHandle)
}

/*

USER: if you want to define your own Lambda function in swift, just
define a function `f:(FileHandle)->Data` and call it with `standardInput`.

Be sure your function `f` expects a String containing JSON and returns
a String containing JSON.

*/

// echo: reads a string and returns it exactly
let result = echo(fileHandle: FileHandle.standardInput)

// ALEXA: reads an Alexa Request envelope and returns a response
//readTransformPrint(transform:greetResponse)
//let result = greetResponse(fileHandle: FileHandle.standardInput)
FileHandle.standardOutput.write(result)
