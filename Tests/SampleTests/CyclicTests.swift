//

import XCTest
@testable import Sample

///

final class CyclicTests: XCTestCase {

    ///
    
    func testNextReturnsNothingWhenInputIsEmpty() {
        XCTAssertNil(
            Samples.Empty<Bool>().cycle().next(),
            "Expected no value while cycling through empty input"
        )
    }
    
    ///
    
    func testNextReturnsInfinitelyUsingSingleValueInput() {
        let value = 42
        let elements = [value]
        let generator = Samples.Enumerative(from: elements).cycle()
        let generatedResults = Array(generator.prefix(3))

        XCTAssertEqual(
            generatedResults, Array(repeating: value, count: 3),
            "Generated list of values differs from cyclic input"
        )
    }

    ///
    
    func testNextReturnsValuesCyclicallyAfterEndOfInput() {
        let elements = [1,2,3]
        let generator = Samples.Enumerative(from: elements).cycle()
        let generatedResults = Array(generator.prefix(7))

        XCTAssertEqual(
            generatedResults, elements + elements + Array(elements.prefix(1)),
            "Expected generated values to be repetition of the single input value"
        )
    }
    
    ///
    
    func testCyclingDoesNotAccumulate() {
        let elements = [1,2,3]
        let generator = Samples.Enumerative(from: elements)
        let cyclic = generator.cycle()
        let cyclicTwice = cyclic.cycle()
        
        XCTAssertEqual(
            cyclicTwice.id, cyclic.id,
            "Chained cycles are expected to have no effect"
        )
    }
    
    ///
    
    func testAlreadyInfiniteInputRemainsUnchanged() {
        let value = 42
        let limit = 25
        let generator = Samples.Enumerative(from: Samples.Constant(for: value)).cycle()
        let generatedResults = Array(generator.prefix(limit))
        
        XCTAssertEqual(
            generatedResults, Array(repeating: value, count: limit),
            "Already infinite input is expected to remain unchanged"
        )
    }
    
}
