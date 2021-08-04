//
//  File.swift
//  
//
//  Created by Rob Jonson on 03/08/2021.
//

import XCTest
import Foundation

@testable import PixabayKit

final class PiPhotoTests: XCTestCase {

    
    func testDecodingPhPhoto() {
        
        let string = """
            {
                    "id": 195893,
                    "pageURL": "https://pixabay.com/en/blossom-bloom-flower-195893/",
                    "type": "photo",
                    "tags": "blossom, bloom, flower",
                    "previewURL": "https://cdn.pixabay.com/photo/2013/10/15/09/12/flower-195893_150.jpg",
                    "previewWidth": 150,
                    "previewHeight": 84,
                    "webformatURL": "https://pixabay.com/get/35bbf209e13e39d2_640.jpg",
                    "webformatWidth": 640,
                    "webformatHeight": 360,
                    "largeImageURL": "https://pixabay.com/get/ed6a99fd0a76647_1280.jpg",
                    "fullHDURL": "https://pixabay.com/get/ed6a9369fd0a76647_1920.jpg",
                    "imageURL": "https://pixabay.com/get/ed6a9364a9fd0a76647.jpg",
                    "imageWidth": 4000,
                    "imageHeight": 2250,
                    "imageSize": 4731420,
                    "views": 7671,
                    "downloads": 6439,
                    "likes": 5,
                    "comments": 2,
                    "user_id": 48777,
                    "user": "Josch13",
                    "userImageURL": "https://cdn.pixabay.com/user/2013/11/05/02-10-23-764_250x250.jpg",
                }
            """
        let data = string.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let photo = try! decoder.decode(PiPhoto.self, from: data)
        
        XCTAssertEqual(photo.id, 195893)
        XCTAssertEqual(photo.width, 4000)
        XCTAssertEqual(photo.height, 2250)
        XCTAssertEqual(photo.url, URL(string:"https://pixabay.com/get/ed6a9364a9fd0a76647.jpg")!)
        XCTAssertEqual(photo.user, "Josch13")
        XCTAssertEqual(photo.userURL, URL(string:"https://pixabay.com/users/Josch13")!)


        XCTAssertEqual(photo.url, URL(string: "https://pixabay.com/get/ed6a9364a9fd0a76647.jpg")!)
        XCTAssertEqual(photo.preview, URL(string: "https://cdn.pixabay.com/photo/2013/10/15/09/12/flower-195893_150.jpg")!)
    }
    
    func testHandlesMissingFullRes() {
        let string = """
            {
                    "id": 195893,
                    "pageURL": "https://pixabay.com/en/blossom-bloom-flower-195893/",
                    "type": "photo",
                    "tags": "blossom, bloom, flower",
                    "previewURL": "https://cdn.pixabay.com/photo/2013/10/15/09/12/flower-195893_150.jpg",
                    "previewWidth": 150,
                    "previewHeight": 84,
                    "webformatURL": "https://pixabay.com/get/35bbf209e13e39d2_640.jpg",
                    "webformatWidth": 640,
                    "webformatHeight": 360,
                    "largeImageURL": "https://pixabay.com/get/ed6a99fd0a76647_1280.jpg",
                    "imageWidth": 4000,
                    "imageHeight": 2250,
                    "imageSize": 4731420,
                    "views": 7671,
                    "downloads": 6439,
                    "likes": 5,
                    "comments": 2,
                    "user_id": 48777,
                    "user": "Josch13",
                    "userImageURL": "https://cdn.pixabay.com/user/2013/11/05/02-10-23-764_250x250.jpg",
                }
            """
        let data = string.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let photo = try! decoder.decode(PiPhoto.self, from: data)
    
        //returns fullHDURL
        XCTAssertEqual(photo.url, URL(string: "https://pixabay.com/get/ed6a9369fd0a76647_1920.jpg")!)
    }
    
    
}


