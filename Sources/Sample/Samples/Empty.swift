
// MARK: Sample Devoid of Elements

public extension Samples {

    ///

    struct Empty<Element>: Sample {

        ///
        
        public init() { }

        ///

        public func next() -> Element? {
            return nil
        }

    }

}
