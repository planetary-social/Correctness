//

import XCTest
import Sample

///

final class ConstantTests: XCTestCase {
    
    ///
    
    func testNextAlwaysReturnsTheInputValue() {
        let input = "Yada, yada, yada!"
        let generator = Samples.Constant(for: input)
        let maxTestAttempts = 7
        
        for attempt in (1...maxTestAttempts) {
            XCTAssertEqual(
                generator.next(), .some(input),
                "Generated value differs from the input (on attempt #\(attempt))"
            )
        }
    }
    
}
