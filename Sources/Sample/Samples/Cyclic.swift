//

import Foundation

//

public extension Samples {

    ///
    
    struct Cyclic<Element: Hashable>: Sample {
        
        ///
        
        internal let id = UUID()


        ///
        
        private let remainingValues: Generative<Element>

        ///
        
        public init<I: IteratorProtocol>(_ values: I) where Element == I.Element {

            var buffer: [Element] = []
            var input = values
            var take = { input.next() }

            self.remainingValues =
                .init {
                    while true {
                        if let value = take() {
                            buffer.append(value) // XXX: Might overflow!
                            return value
                        } else {
                            if buffer.isEmpty { break }
                            var input = buffer.makeIterator()
                            buffer = []
                            take = { input.next() }
                        }
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
    
    func cycle() -> Samples.Cyclic<Element> {
        if let cyclic = self as? Samples.Cyclic<Element> { return cyclic }
        return Samples.Cyclic(self)
    }

}

