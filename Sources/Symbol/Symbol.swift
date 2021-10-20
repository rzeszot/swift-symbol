import Foundation

public struct Symbol {
  fileprivate let reference: Reference

  init(_ string: String, registry: Registry) {
    reference = registry.reference(for: string)
  }

  public init(_ string: String) {
    self.init(string, registry: .shared)
  }
}

extension Symbol: ExpressibleByStringLiteral {
  public init(stringLiteral value: String) {
    self.init(value)
  }
}

extension String {
  public init(_ symbol: Symbol) {
    self = symbol.reference.string
  }
}


extension Symbol: Codable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    self.init(try container.decode(String.self))
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(reference.string)
  }
}

extension Symbol: Equatable {
  public static func == (lhs: Symbol, rhs: Symbol) -> Bool {
    lhs.reference == rhs.reference
  }
}

extension Symbol: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(reference)
  }
}

extension Symbol: CustomStringConvertible {
  public var description: String {
    ":" + reference.string
  }
}
