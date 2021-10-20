@testable import Symbol
import XCTest

final class ReferenceTests: XCTestCase {

  // MARK: - Equatable

  func test_equal() {
    let a = Reference("hello")
    let b = a

    XCTAssertEqual(a, b)
  }

  func test_not_equal() {
    let a = Reference("hello")
    let b = Reference("world")
    let c = Reference("hello")

    XCTAssertNotEqual(a, b)
    XCTAssertNotEqual(b, c)
  }

  // MARK: - Hashable

  func test_hash_into() {
    var sut = Hasher()
    Reference("hello").hash(into: &sut)

    var ref = Hasher()
    "hello".hash(into: &ref)

    XCTAssertEqual(sut.finalize(), ref.finalize())
  }

}
