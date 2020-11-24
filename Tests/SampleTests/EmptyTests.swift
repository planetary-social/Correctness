//

import XCTest
import Sample

///

final class EmptyTests: XCTestCase {
    
    ///
    
    func testNextAlwaysReturnsNil() {
        let generator = Samples.Empty<Float>()
        let maxTestAttempts = 7
        
        for attempt in (1...maxTestAttempts) {
            XCTAssertNil(
                generator.next(),
                "Got an unexpected value from an empty sample (on attempt #\(attempt))"
            )
        }
    }
    
}
