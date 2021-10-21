// swiftlint:disable identifier_name

@testable import Symbol
import XCTest

final class RegistryTests: XCTestCase {

  var sut: Registry!

  override func setUp() {
    super.setUp()
    sut = .init()
  }

  // MARK: -

  func test_returns_the_same_reference_for_the_same_strings() {
    let a = sut.reference(for: "hello")
    let b = sut.reference(for: "hello")

    XCTAssertEqual(a, b)
  }

  func test_returns_the_same_reference_for_different_strings() {
    let a = sut.reference(for: "hello")
    let b = sut.reference(for: "world")

    XCTAssertNotEqual(a, b)
  }

  // MARK: -

  func test_automatic_deallocation() {
    func foo() {
      let object = sut.reference(for: "hello")
      _ = object
      XCTAssertEqual(sut.count, 1)
    }

    XCTAssertEqual(sut.count, 0)
    foo()
    XCTAssertEqual(sut.count, 0)
  }

  func test_automatic_deallocation_2() {
    func foo() {
      XCTAssertEqual(sut.count, 1)
      let hello = sut.reference(for: "hello")
      _ = hello
      XCTAssertEqual(sut.count, 1)
      let world = sut.reference(for: "world")
      _ = world
      XCTAssertEqual(sut.count, 2)
    }

    XCTAssertEqual(sut.count, 0)
    let hello = sut.reference(for: "hello")
    _ = hello
    XCTAssertEqual(sut.count, 1)
    foo()
    XCTAssertEqual(sut.count, 1)
  }
}
