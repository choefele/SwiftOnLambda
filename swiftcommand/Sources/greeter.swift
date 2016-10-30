import Foundation
import AlexaSkillsKit
//import SwiftyJSON

typealias ActiveJSONSerialization = Foundation.JSONSerialization
//typealias ActiveJSONSerialization = SwiftyJSON.LclJSONSerialization

//
// MARK: Greeter skill
//

let APP_ID = "com.alexisgallagher.swiftgreeter"

// commented out code is work-in-progress:

/*
 
 typealias AlexaIntentHandler = (intent:AlexaIntent,
 session:AlexaSession,
 response:AlexaResponse) -> Void
 
 let SPEECH_OUTPUT = "Hello World!"
 
 
 func helloResponseFunction(intent:AlexaIntent,session:AlexaSession,response:AlexaResponse) {
 response.tell(SPEECH_OUTPUT)
 }
 
 class GreeterService : AlexaSkill {
 
 // TODO: use APP_ID on initialization
 
 func onLaunch(intent:AlexaIntent,session:AlexaSession,response:AlexaResponse) {
 helloResponseFunction(intent:intent,session:session,response:response)
 }
 
 /// maps intent names to intent handlers
 var intentHandlers:[String:AlexaIntentHandler] {
 return ["HelloWorldIntent":helloResponseFunction]
 }
 }
 
 //
 // MARK: AlexaSkills API
 //
 
 protocol AlexaSkill {
 func onLaunch(intent:AlexaIntent,session:AlexaSession,response:AlexaResponse)
 var intentHandlers:[String:AlexaIntentHandler]
 }
 
 
 typealias AmazonEvent = [String:Any]
 typealias AmazonContext = [String:Any]
 
 func serviceHandler(event:AmazonEvent,context:AmazonContext) {
 let greeterService = GreeterService()
 greeterService.execute(event:event,context:context)
 }
 
 */

/**
 Parses the top-level JSON value passed in as part of the
 Alexa JSON interface
 
 */
func serviceRequest() -> StandardResponse
{
  // generate output speech
  let outputSpeech = OutputSpeech.plain(text: "Hello from Swift")
  let standardResponse = StandardResponse(outputSpeech: outputSpeech, shouldEndSession: true)
    
  return standardResponse
}

public class Greeter
{
  public init() { }
  
  /**
   FileHandle->Data wrapper for the service method above.
   
   */
  public func service(fileHandle: FileHandle) -> Data {
    guard let requestParser = try? RequestParser(fileHandle: fileHandle),
        let requestType = requestParser.parseRequestType() else {
            return "error parsing JSON".data(using: .utf8)!
    }
    
    let standardResponse: StandardResponse
    switch requestType {
    // LATER: here we would process details in a launch request or intent request object
    default:
        standardResponse = serviceRequest()
    }
    
    let responseGenerator = ResponseGenerator(standardResponse: standardResponse)
    guard let jsonData = try? responseGenerator.generateJSON(options: .prettyPrinted) else {
        return "error generating JOSN".data(using: .utf8)!
    }
    
    return jsonData
  }
}
/*
 Questions:
 
 - does AMZ check timestamp security before passing to lambda handlers? or is that the rsponsibility of my lambda func when it processes the request? Is this checked for certification?
 
 - AMZ published any schema of all these types? Protocol buffers schema?
 
 - AMZ published nginx config for auth anywhere?
 
 
 */

