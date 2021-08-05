//
//  File.swift
//  
//
//  Created by Rob Jonson on 03/08/2021.
//

import Foundation
import Alamofire
import HSHelpers

public class PiSearch {
    let searchTerm:String?
    let perPage:Int
    let completion:(PiResult)->Void
    let minSize:CGSize
    
    public var photos:[PiPhoto]=[]
    public var maxPhotos:Int?
    
    init (searchTerm: String? = nil, perPage: Int = 200, minSize:CGSize = .zero, completion: @escaping (PiResult)->Void){
        self.minSize = minSize
        self.searchTerm = searchTerm
        self.perPage = [3, perPage, 200].sorted()[1]
        self.completion = completion
    }
    
    private var lastPage:Int = 0
    private var fetching:Bool = false
    private var lastResult:PiSearchResponse?
    public func getNextPage() {
        if fetching {return}
        
        if let maxPhotos = maxPhotos, photos.count >= maxPhotos {
            return
        }
        
        
        if lastResult.isNotNil, let maxPhotos = maxPhotos, photos.count >= maxPhotos {
            //not the first search, and no more pages available
            return
        }
        
        fetching = true
        let nextPage = lastPage + 1
        
        let url = url(page: nextPage)

        PiClient.shared.sessionManager.request(url,
                   method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of:PiSearchResponse.self) {
                [weak self] response in
                self?.fetching = false
                
                switch response.result {
                case .failure(let error):
                    if let string = response.data?.utf8String {
                        print(string)
                    }
                    
                    self?.completion(PiResult.failure(error))
                    break
                case .success(let response):
                    self?.process(response)
                    self?.lastPage = nextPage
                    if let self = self {
                        self.completion(PiResult.success(self))
                    }
                    break
                }
            }
    }
    
    private func process(_ response:PiSearchResponse){
        photos.append(contentsOf: response.photos)
        maxPhotos = response.totalResults
        lastResult = response
    }
    
    
    func url(page:Int) -> URL {
        var urlC = URLComponents(string: "https://pixabay.com/api/")!
        urlC["key"]=PiClient.shared.config.key
        urlC["image_type"]="photo"
        urlC["page"]="\(page)"
        urlC["per_page"]="\(perPage)"
        urlC["min_width"]="\(minSize.width.int)"
        urlC["min_height"]="\(minSize.height.int)"
        
        
        if let searchTerm = searchTerm {
            urlC["q"]=searchTerm
        }
        else {
            urlC["category"]="backgrounds"
        }

        
        return urlC.url!
    }
}
