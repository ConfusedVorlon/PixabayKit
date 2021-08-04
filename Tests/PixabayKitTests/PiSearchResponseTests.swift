    import XCTest

    
    @testable import PixabayKit
    
    final class PiSearchResponseTests: XCTestCase {
        
        func testDecodeSearchResponse() {
            
            let searchResponse = Bundle.module.url(forResource: "searchResult", withExtension: "json")!
            let data = try! Data(contentsOf: searchResponse)

            let decoder = JSONDecoder()
            let search = try! decoder.decode(PiSearchResponse.self, from: data)
            
            XCTAssertEqual(search.totalResults, 43)
            
        }
        
    }
    
