// swiftlint:disable identifier_name

@testable import Symbol
import XCTest

final class WeakTests: XCTestCase {

  func test_dealloc_if_no_strong_reference() {
    let sut = Weak(SomeObject(42))

    XCTAssertNil(sut.object)
  }

  func test_dealloc_if_strong_reference() {
    let object = SomeObject(42)
    let sut = Weak(object)

    XCTAssertNotNil(sut.object)
  }

  // MARK: - Equatable

  func test_equatable() {
    let a = SomeObject(42)
    let b = SomeObject(42)
    let c = SomeObject(1000)

    XCTAssertEqual(Weak(a), Weak(b))
    XCTAssertNotEqual(Weak(a), Weak(c))
  }

  // MARK: - Hashable

  func test_hash_into() {
    var sut = Hasher()
    let object = SomeObject(42)
    let weakObject = Weak(object)
    weakObject.hash(into: &sut)

    var ref = Hasher()
    Optional(42).hash(into: &ref)

    XCTAssertEqual(sut.finalize(), ref.finalize())
  }

}
