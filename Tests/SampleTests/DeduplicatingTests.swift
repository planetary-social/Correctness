//

import XCTest
@testable import Sample

///

final class DeduplicatingTests: XCTestCase {

    ///
    
    func testNextReturnsNothingWhenInputIsEmpty() {
        XCTAssertNil(
            Samples.Enumerative(from: Samples.Empty<Bool>()).deduplicate().next(),
            "Expected no value while deduplicating empty input"
        )
    }

    ///
    
    func testNextAlwaysReturnsUniqueValue() {
        let elements = [1,1,1,2,2,3,4,5,5,4,1,3,2,2,2,4,4,5,5]
        let generator = Samples.Enumerative(from: elements).deduplicate()
        let generatedResults = Array(generator.prefix(5))

        XCTAssertEqual(
            generatedResults, [1,2,3,4,5],
            "Generated list of values differs from deduplicated input"
        )
        
        XCTAssertNil(
            generator.next(),
            "Expected no more values after deduplicating the whole input sequence"
        )
    }
    
    ///
    
    func testNextReturnsNothingAfterTooManyClashes() {
        let elements = [1,1,1,1,2,2,2,2,2,2,2,3,3,3,3,4,4]
        let generator = Samples.Enumerative(from: elements).deduplicate(maxRetriesOnClash: 5)
        let generatedResults = Array(generator.prefix(4))
        
        XCTAssertEqual(
            generatedResults, [1,2],
            "Generated list of values differs from deduplicated input with too many clashes"
        )
    }
    
    ///
    
    func testDeduplicationsDoNotAccumulate() {
        let elements = [1,1,1,2,2,2,3,3,3]
        let generator = Samples.Enumerative(from: elements)
        let deduplicated = generator.deduplicate()
        let deduplicatedTwice = deduplicated.deduplicate()
        
        XCTAssertEqual(
            deduplicatedTwice.id, deduplicated.id,
            "Chained deduplication is expected to have no effect"
        )
    }
    
    ///
    
    func testAlreadyDeduplicatedInputRemainsUnchanged() {
        let value = 42
        let generator = Samples.Enumerative(from: Samples.Constant(for: value)).deduplicate()
        let generatedResults = Array(generator.prefix(25))
        
        XCTAssertEqual(
            generatedResults, [value],
            "Already deduplicated input is expected to remain unchanged"
        )
    }
    
}
