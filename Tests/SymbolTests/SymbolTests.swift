// swiftlint:disable identifier_name

@testable import Symbol
import XCTest

final class SymbolTests: XCTestCase {

  var registry: Registry!

  override func setUp() {
    registry = .init()
  }

  override func tearDown() {
    XCTAssertEqual(registry.count, 0)
    XCTAssertEqual(Registry.shared.count, 0)
  }

  // MARK: - Init

  func test_multiton() {
    let a = Symbol("hello_multiton", registry: registry)
    let b = Symbol("hello_multiton", registry: registry)
    let c = Symbol("hello_multiton", registry: registry)

    XCTAssertTrue(a == b)
    XCTAssertTrue(b == c)
    XCTAssertEqual(registry.count, 1)
  }

  // MARK: - ExpressibleByStringLiteral

  func test_string_literal() {
    let a: Symbol = "hello_literal"
    let b = Symbol("hello_literal")

    XCTAssertEqual(a, b)
  }

  // MARK: - Codable

  func test_decodable() throws {
    let json = """
      {
        "id": "hello_decodable"
      }
      """

    struct Response: Decodable {
      let id: Symbol
    }

    let sut = try JSONDecoder().decode(Response.self, from: json.data(using: .utf8)!)

    XCTAssertEqual(sut.id, Symbol("hello_decodable"))
    XCTAssertEqual(String(sut.id), "hello_decodable")
  }

  func test_encodable() throws {
    struct Request: Encodable {
      let id: Symbol
    }

    let request = Request(id: "hello_encodable")

    let encoder = JSONEncoder()
    encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

    let sut = try encoder.encode(request)

    XCTAssertEqual(String(data: sut, encoding: .utf8), """
      {
        "id" : "hello_encodable"
      }
      """)
  }

  // MARK: - Equatable

  func test_equatable() {
    let a = Symbol("hello_equatable", registry: registry)
    let b = Symbol("hello_equatable", registry: registry)
    let c = Symbol("hell_equatable", registry: registry)

    XCTAssertEqual(a, b)
    XCTAssertNotEqual(a, c)
  }

  // MARK: - Hashable

  func test_hash_into() {
    var sut = Hasher()
    Symbol("hello_hash_into", registry: registry).hash(into: &sut)

    var ref = Hasher()
    "hello_hash_into".hash(into: &ref)

    XCTAssertEqual(sut.finalize(), ref.finalize())
  }

  // MARK: - CustomStringConvertible

  func test_description() {
    let symbol = Symbol("hello_description", registry: registry)
    XCTAssertEqual(symbol.description, ":hello_description")
  }

  // MARK: -

  func test_all() {
    let symbols = [
      Symbol("hello_all_1", registry: registry),
      Symbol("hello_all_2", registry: registry),
      Symbol("hello_all_3", registry: registry),
      Symbol("hello_all_4", registry: registry)
    ]
    _ = symbols

    let sut = Symbol.all(registry: registry).sorted(by: { $0.description < $1.description })

    XCTAssertEqual(sut.count, 4)
    XCTAssertEqual(String(sut[0]), "hello_all_1")
    XCTAssertEqual(String(sut[1]), "hello_all_2")
    XCTAssertEqual(String(sut[2]), "hello_all_3")
    XCTAssertEqual(String(sut[3]), "hello_all_4")
  }

}
