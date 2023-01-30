/// Represents a type that can validate itself.
///
/// ```
/// struct User {
///   let name: String
///   let email: String
/// }
///
/// extension User: Validatable {
///   var body: some Validator<Self> {
///     Validation {
///       Not(Equals(\.name, ""))
///       Not(Equals(\.email, ""))
///     }
///   }
/// }
///
/// let blob = User(name: "Blob", email: "blob@example.com")
/// try blob.validate() // success.
///
/// let invalid = User(name: "", email: "blob.jr@example.com")
/// try invalid.validate() // error.
/// ```
/// 
public protocol Validatable: Validator where Value == Self {
  func validate() throws
}

extension Validatable {
  
  @inlinable
  public func validate() throws {
    try self.validate(self)
  }
}