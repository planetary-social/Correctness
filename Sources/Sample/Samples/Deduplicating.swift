//

import Foundation

//

public extension Samples {

    ///
    
    fileprivate static let dedupBaselineRetriesOnClash: UInt = 5
    
    ///
    
    struct Deduplicating<Element: Hashable>: Sample {
        
        ///
        
        internal let id = UUID()

        ///
        
        private let remainingValues: Generative<Element>

        ///
        
        public init<S: IteratorProtocol>(maxRetriesOnClash: UInt? = nil, _ sample: S) where S.Element == Element {

            let maxRetriesOnClash = maxRetriesOnClash ?? Samples.dedupBaselineRetriesOnClash

            var possibleValues = sample
            var alreadyClaimed = Set<Element>()

            self.remainingValues =
                .init {

                    for _ in 1...maxRetriesOnClash {
                        guard let newValue = possibleValues.next() else { break }
                        if alreadyClaimed.contains(newValue) { continue }
                        alreadyClaimed.insert(newValue)
                        return newValue
                    }

                    return nil

                }

        }
        
        ///

        public func next() -> Element? {
            return remainingValues.next()
        }

    }

}

//

public extension Sample where Element: Hashable {

    ///
    
    func deduplicate(maxRetriesOnClash: UInt? = nil) -> Samples.Deduplicating<Element> {
        if let deduplicated = self as? Samples.Deduplicating<Element> { return deduplicated }
        return Samples.Deduplicating(maxRetriesOnClash: maxRetriesOnClash, self)
    }

}
