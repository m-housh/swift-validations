/// Ensures one of the validators succeds to validate a value.
///
/// **Example**
/// ```
/// let oneOrTwo = ValidatorOf<Int> {
///   OneOf {
///     Equals(1)
///     Equals(2)
///   }
/// }
///
/// try oneOrTwo.validate(1) // success.
/// try oneOrTwo.validate(2) // success.
/// try oneOrTwo.validate(3) // fails.
/// ```
///
public struct OneOf<Value>: Validator {

  @usableFromInline
  let validator: any Validator<Value>

  @inlinable
  init(_ validator: any Validator<Value>) {
    self.validator = validator
  }

  /// Create a one of validator using builder syntax.
  /// **Example**
  /// ```
  /// let oneOrTwo = ValidatorOf<Int> {
  ///   OneOf {
  ///     Equals(1)
  ///     Equals(2)
  ///   }
  /// }
  ///
  /// try oneOrTwo.validate(1) // success.
  /// try oneOrTwo.validate(2) // success.
  /// try oneOrTwo.validate(3) // fails.
  /// ```
  ///
  @inlinable
  public init<V: Validator>(@OneOfBuilder<Value> builder: @escaping () -> V)
  where V.Value == Value {
    self.init(builder())
  }

  @inlinable
  public func validate(_ value: Value) throws {
    try validator.validate(value)
  }
}
