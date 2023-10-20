//
//  RootClass.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on April 30, 2022
//
import Foundation
import SwiftyJSON

struct ConFigurations {

	let images: Images?
	let changeKeys: [String]?

	init(_ json: JSON) {
		images = Images(json["images"])
		changeKeys = json["change_keys"].arrayValue.map { $0.stringValue }
	}
}


struct Images {

    let baseUrl: String?
    let secureBaseUrl: String?
    let backdropSizes: [String]?
    let logoSizes: [String]?
    let posterSizes: [String]?
    let profileSizes: [String]?
    let stillSizes: [String]?

    init(_ json: JSON) {
        baseUrl = json["base_url"].stringValue
        secureBaseUrl = json["secure_base_url"].stringValue
        backdropSizes = json["backdrop_sizes"].arrayValue.map { $0.stringValue }
        logoSizes = json["logo_sizes"].arrayValue.map { $0.stringValue }
        posterSizes = json["poster_sizes"].arrayValue.map { $0.stringValue }
        profileSizes = json["profile_sizes"].arrayValue.map { $0.stringValue }
        stillSizes = json["still_sizes"].arrayValue.map { $0.stringValue }
    }
}
