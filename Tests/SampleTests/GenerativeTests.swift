//

import XCTest
import Sample

///

final class GeneraiveTests: XCTestCase {
    
    ///
    
    func testNextIsConstantIfInputClosureReturnsConstant() {
        let generator = Samples.Generative<Int> { 42 }
        let maxTestAttempts = 7
        
        for attempt in (1...maxTestAttempts) {
            XCTAssertEqual(
                generator.next(), .some(42),
                "Generated value differs from the input constant (on attempt #\(attempt))"
            )
        }
    }
    
    ///
    
    func testNextReturnsOppositeOfThePreviousValue() {
        var value = true
        
        let generator =
            Samples.Generative<Bool> {
                let result = value
                value = !value
                return result
            }

        var previousValue = generator.next()
        let maxTestAttempts = 21
        
        for attempt in (1...maxTestAttempts) {
            let thisValue = generator.next()

            XCTAssertNotNil(
                thisValue,
                "Expected non-empty value (on attempt #\(attempt))"
            )

            XCTAssertNotEqual(
                thisValue, previousValue,
                "Generated value should be an opposite of the previous one (on attempt #\(attempt))"
            )
            
            previousValue = thisValue
        }
    }

    ///
    
    func testNextReturnsNextValueFromInputArray() {
        let elements = Array(25...50)
        var iterator = elements.makeIterator()
        let generator = Samples.Generative<Int> { iterator.next() }
        let generatedElements = Array(generator.prefix(elements.count))

        XCTAssertEqual(
            generatedElements, elements,
            "Generated list of values does not match the list of input elements"
        )
        
        XCTAssertNil(
            generator.next(),
            "Expected no more values after reading all of the input"
        )
    }

}
