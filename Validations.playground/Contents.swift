//import Validations
import Foundation

var greeting = "Hello, playground"

//struct MatchCharacter: Validatable {
//  let input: String
//  let character: Character
//
//  var body: some Validation<Self> {
//    Validator.contains(\.input, \.character)
//  }
//}
//
//try MatchCharacter(input: "blob around the world", character: "a").validate() // success.
//try MatchCharacter(input: "blob jr.", character: "z").validate() // fails.


enum MyEnum {
  case ints([Int])
  case strings([String])
}


