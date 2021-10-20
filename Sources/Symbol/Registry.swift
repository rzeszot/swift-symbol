import Foundation

class Registry {

  // MARK: - Singleton

  static let shared: Registry = .init()

  // MARK: -

  private var references: [String: Weak<Reference>] = [:]

  private func cleanup() {
    for (key, value) in references where value.object == nil {
      references[key] = nil
    }
  }

  var count: Int {
    cleanup()
    return references.count
  }

  // MARK: -

  func reference(for string: String) -> Reference {
    cleanup()

    if let weaked = references[string], let reference = weaked.object {
      return reference
    } else {
      let reference = Reference(string)
      references[string] = Weak(reference)
      return reference
    }
  }

}
