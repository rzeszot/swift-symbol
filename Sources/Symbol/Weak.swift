struct Weak<T: AnyObject> {
  weak var object: T?

  init(_ object: T) {
    self.object = object
  }
}

extension Weak: Equatable where T: Equatable {

}

extension Weak: Hashable where T: Hashable {

}
