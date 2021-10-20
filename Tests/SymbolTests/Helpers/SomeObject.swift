class SomeObject: Hashable {
  private let value: Int

  init(_ value: Int) {
    self.value = value
  }

  // MARK: - Equatable

  static func == (lhs: SomeObject, rhs: SomeObject) -> Bool {
    lhs.value == rhs.value
  }

  // MARK: - Hashable

  func hash(into hasher: inout Hasher) {
    hasher.combine(value)
  }
}
