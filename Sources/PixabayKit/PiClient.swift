import Foundation

public typealias PiResult = Result<PiSearch,Error>

open class PiClient{
    public static let shared = PiClient()
    
    public struct Config {
        public init(key: String) {
            self.key = key
        }
        
        var key:String
    }
    private static var config:Config?
    internal var config:Config

    public class func setup(_ config:Config){
        PiClient.config = config
    }
    
    private init() {
        guard let newConfig = PiClient.config else {
            fatalError("Error - you must call setup before accessing PxClient.shared")
        }
        config = newConfig
    }
    
    open func fetch(searchTerm:String? = nil,perPage:Int = 80, minSize:CGSize = .zero,completion:@escaping (PiResult)->Void) -> PiSearch {
        let search = PiSearch(searchTerm: searchTerm, perPage: perPage,minSize: minSize, completion: completion)
        search.getNextPage()
        return search
    }
}
