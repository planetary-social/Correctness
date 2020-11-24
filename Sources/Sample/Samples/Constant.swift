
// MARK: Sampling Constant Values

public extension Samples {

    ///

    struct Constant<Element>: Sample {

        ///

        private let value: Element

        ///

        public init(for value: Element) {
            self.value = value
        }

        ///

        public func next() -> Element? {
            return value
        }

    }

}
