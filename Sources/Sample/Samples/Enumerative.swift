
// MARK: Iterable and Enumerative Sampling

public extension Samples {

    ///

    struct Enumerative<Element>: Sample {

        ///
        
        private let remainingValues: Generative<Element>
        
        ///
        
        public init<S: Sequence>(from sequence: S) where Element == S.Element {
            var iterator = sequence.lazy.makeIterator()
            self.remainingValues = .init { iterator.next() }
        }

        ///

        public func next() -> Element? {
            return remainingValues.next()
        }

    }

}

//

extension Samples.Enumerative where Element: CaseIterable {
    
    ///
    
    public init(casesOf enumeration: Element.Type) {
        self.init(from: enumeration.allCases)
    }
    
}
