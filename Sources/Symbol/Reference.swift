class Reference: Hashable {
  let string: String

  init(_ string: String) {
    self.string = string
  }

  // MARK: - Equatable

  static func == (lhs: Reference, rhs: Reference) -> Bool {
    lhs === rhs
  }

  // MARK: - Hashable

  func hash(into hasher: inout Hasher) {
    hasher.combine(string)
  }
}
