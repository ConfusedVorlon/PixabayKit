//
//  File.swift
//  
//
//  Created by Rob Jonson on 03/08/2021.
//

import Foundation
import Codextended

public struct PiPhoto: Codable {
    public let id:Int
    public let photoPage:URL
    public let tags:String
    public let preview:URL
    public let previewWidth:Int
    public let previewHeight:Int
    public let webformat:URL
    public let webformatWidth:Int
    public let webformatHeight:Int
    public let largeImage:URL
    private let _fullHD:URL?
    private let _url:URL?
    public let width:Int
    public let height:Int
    public let views:Int
    public let downloads:Int
    public let likes:Int
    public let comments:Int
    public let userId:Int
    public let user:String
    public let userImage:URL?
    public var userURL:URL {
        let base = URL(string: "https://pixabay.com/users/")!
        return base.appendingPathComponent(user)
    }
    
    
    public var fullHD:URL {
        if let _fullHD = _fullHD {
            return _fullHD
        }
        print("Warning - Your key isn't returning high res images. Providing Large")
        return largeImage
    }
    
    public var url:URL {
        if let _url = _url {
            return _url
        }
        print("Warning - Your key isn't returning high res images. Providing Large")
        return largeImage
    }

    
    enum CodingKeys: String, CodingKey {
        case id
        case photoPage="pageURL"
        case tags
        case preview="previewURL"
        case previewWidth
        case previewHeight
        case webformat="webformatURL"
        case webformatWidth
        case webformatHeight
        case largeImage="largeImageURL"
        case _fullHD="fullHDURL"
        case _url="imageURL"
        case width="imageWidth"
        case height="imageHeight"
        case views
        case downloads
        case likes
        case comments
        case userId="user_id"
        case user
        case userImage="userImageURL"
    }
    
    public init(from decoder: Decoder) throws {
        id = try decoder.decode(CodingKeys.id)
        
        photoPage = try decoder.decode(CodingKeys.photoPage)
        tags   = try decoder.decode(CodingKeys.tags)
        preview    = try decoder.decode(CodingKeys.preview)
        previewWidth    = try decoder.decode(CodingKeys.previewWidth)
        previewHeight    = try decoder.decode(CodingKeys.previewHeight)
        webformat    = try decoder.decode(CodingKeys.webformat)
        webformatWidth    = try decoder.decode(CodingKeys.webformatWidth)
        webformatHeight    = try decoder.decode(CodingKeys.webformatHeight)
        largeImage    = try decoder.decode(CodingKeys.largeImage)
        _fullHD   = try decoder.decodeIfPresent(CodingKeys._fullHD)
        _url    = try decoder.decodeIfPresent(CodingKeys._url)
        width    = try decoder.decode(CodingKeys.width)
        height    = try decoder.decode(CodingKeys.height)
        views    = try decoder.decode(CodingKeys.views)
        downloads   = try decoder.decode(CodingKeys.downloads)
        likes   = try decoder.decode(CodingKeys.likes)
        comments    = try decoder.decode(CodingKeys.comments)
        userId   = try decoder.decode(CodingKeys.userId)
        user   = try decoder.decode(CodingKeys.user)
        //sometimes userImage is "" which doesn't decode as a URL
        userImage   = try? decoder.decode(CodingKeys.userImage)
    }
}
