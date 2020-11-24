//

import XCTest
import Sample

///

final class EnumerativeTests: XCTestCase {
    
    ///
    
    func testNextReturnsNextValueFromInputArray() {
        let elements = Array(10...25)
        let generator = Samples.Enumerative<Int>(from: elements)
        let generatedResults = Array(generator.prefix(elements.count))

        XCTAssertEqual(
            generatedResults, elements,
            "Generated list of values does not match the elements from the input sequence"
        )
        
        XCTAssertNil(
            generator.next(),
            "Expected no more values after reading the whole input sequence"
        )
    }

    ///
    
    enum IterableExample: CaseIterable & Equatable {
        case foo, bar, baz
    }

    ///
    
    func testNextReturnsOneOfTheCasesGivenAnEnum() {
        let generator = Samples.Enumerative(casesOf: IterableExample.self)
        let expectedElements = IterableExample.allCases
        let generatedResults = Array(generator.prefix(expectedElements.count))
        
        XCTAssertEqual(
            generatedResults, expectedElements,
            "Generated list of values does not match the list of enum cases"
        )
        
        XCTAssertNil(
            generator.next(),
            "Expected no more values after reading all of the cases"
        )
    }
    
}
