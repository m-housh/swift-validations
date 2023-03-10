import Foundation

/// A type that can validate a value or throw an error.  You can conform to this protocol by either
/// implementing the `validate(_: Value)` method, or by supplying a validator in the `body`
/// property.
///
///  **Example using the `validate(_: Value)` implementatin.**
///  ```swift
///     struct Always<Value>: Validator {
///        func validate(_ value: Value>) throws {
///         // do nothing
///        }
///     }
///  ```
///
///   **Example using the `body` property.**
///   ```swift
///   struct User {
///     let name: String
///     let email: String
///   }
///
///   struct BlobValidator: Validation {
///
///     typealias Value = User
///
///     var body: some Validation<User> {
///       Validator {
///         Validator.validate(\.name, with: String.equals("Blob"))
///         Validator.validate(\.email, with: String.equals("blob@example.com"))
///       }
///     }
///   }
///
///   let blob = User(name: "Blob", email: "blob@example.com")
///   let notBlob = User(name: "Blob Jr.", email: "blob.jr@example.com")
///
///   let validator = BlobValidator()
///
///   try validator.validate(blob) // success.
///   try validator.validate(notBlob) // throws.
///
///   ```
///
public protocol Validation<Value> {

  associatedtype Value
  associatedtype _Body
  typealias Body = _Body

  /// Validate the value or throw an error.
  ///
  /// - Parameters:
  ///   - value: The value to validate.
  func validate(_ value: Value) throws

  /// Implement the validation using / building a validator.
  @ValidationBuilder<Value>
  var body: Body { get }
}

extension Validation where Body == Swift.Never {

  @_transparent
  public var body: Body {
    fatalError("\(Self.self) has no body.")
  }
}

extension Validation where Body: Validation, Body.Value == Value {

  @inlinable
  public func validate(_ value: Value) throws {
    try self.body.validate(value)
  }
}
