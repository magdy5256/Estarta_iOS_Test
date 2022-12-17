//
//  ResultsModel.swift
//  Estarta_iOS_Test
//
//  Created by Magdy Khaled on 17/12/2022.
//

import Foundation

struct ResultsModel : Codable {

    let pagination : Pagination?
    let results : [Result]?


    enum CodingKeys: String, CodingKey {
        case pagination
        case results = "results"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        pagination = try Pagination(from: decoder)
        results = try values.decodeIfPresent([Result].self, forKey: .results)
    }


}

struct Result : Codable, Identifiable {
    
    let createdAt : String?
    let imageIds : [String]?
    let imageUrls : [String]?
    let imageUrlsThumbnails : [String]?
    let name : String?
    let price : String?
    let id : String?


    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case imageIds = "image_ids"
        case imageUrls = "image_urls"
        case imageUrlsThumbnails = "image_urls_thumbnails"
        case name = "name"
        case price = "price"
        case id = "uid"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        imageIds = try values.decodeIfPresent([String].self, forKey: .imageIds)
        imageUrls = try values.decodeIfPresent([String].self, forKey: .imageUrls)
        imageUrlsThumbnails = try values.decodeIfPresent([String].self, forKey: .imageUrlsThumbnails)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        id = try values.decodeIfPresent(String.self, forKey: .id)

    }


}


struct Pagination : Codable {

    let key : String?


    enum CodingKeys: String, CodingKey {
        case key = "key"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        key = try values.decodeIfPresent(String.self, forKey: .key)
    }


}
