
// MARK: Custom Sample Generator

public extension Samples {

    ///

    struct Generative<Element>: Sample {

        ///

        private let generate: Factory

        ///
        
        public typealias Factory = () -> Element?

        ///

        public init(_ generator: @escaping Factory) {
            self.generate = generator
        }

        ///

        public func next() -> Element? {
            return generate()
        }

    }

}
