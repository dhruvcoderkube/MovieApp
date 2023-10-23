//
// Copyright (c) 2023 YASSIR. All rights reserved.
//

import Foundation
import SwiftyJSON

struct MovieDetails {
    
    let adult: Bool?
    let backdropPath: String?
    let belongsToCollection: BelongsToCollection?
    let budget: Int?
    let genres: [Genres]?
    let homepage: String?
    let id: Int?
    let imdbId: String?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompanies]?
    let productionCountries: [ProductionCountries]?
    let releaseDate: String?
    let revenue: Int?
    let runtime: Int?
    let spokenLanguages: [SpokenLanguages]?
    let status: String?
    let tagline: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    
    init(_ json: JSON) {
        adult = json["adult"].boolValue
        backdropPath = json["backdrop_path"].stringValue
        belongsToCollection = BelongsToCollection(json["belongs_to_collection"])
        budget = json["budget"].intValue
        genres = json["genres"].arrayValue.map { Genres($0) }
        homepage = json["homepage"].stringValue
        id = json["id"].intValue
        imdbId = json["imdb_id"].stringValue
        originalLanguage = json["original_language"].stringValue
        originalTitle = json["original_title"].stringValue
        overview = json["overview"].stringValue
        popularity = json["popularity"].doubleValue
        posterPath = json["poster_path"].stringValue
        productionCompanies = json["production_companies"].arrayValue.map { ProductionCompanies($0) }
        productionCountries = json["production_countries"].arrayValue.map { ProductionCountries($0) }
        releaseDate = json["release_date"].stringValue
        revenue = json["revenue"].intValue
        runtime = json["runtime"].intValue
        spokenLanguages = json["spoken_languages"].arrayValue.map { SpokenLanguages($0) }
        status = json["status"].stringValue
        tagline = json["tagline"].stringValue
        title = json["title"].stringValue
        video = json["video"].boolValue
        voteAverage = json["vote_average"].doubleValue
        voteCount = json["vote_count"].intValue
    }
}


struct SpokenLanguages {
    
    let englishName: String?
    let iso6391: String?
    let name: String?
    
    init(_ json: JSON) {
        englishName = json["english_name"].stringValue
        iso6391 = json["iso_639_1"].stringValue
        name = json["name"].stringValue
    }
}


struct ProductionCountries {
    
    let iso31661: String?
    let name: String?
    
    init(_ json: JSON) {
        iso31661 = json["iso_3166_1"].stringValue
        name = json["name"].stringValue
    }
}


struct BelongsToCollection {
    
    let id: Int?
    let name: String?
    let posterPath: String?
    let backdropPath: String?
    
    init(_ json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        posterPath = json["poster_path"].stringValue
        backdropPath = json["backdrop_path"].stringValue
    }
}


struct Genres {
    
    let id: Int?
    let name: String?
    
    init(_ json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
    }
}


struct ProductionCompanies {
    
    let id: Int?
    let logoPath: Any?
    let name: String?
    let originCountry: String?
    
    init(_ json: JSON) {
        id = json["id"].intValue
        logoPath = json["logo_path"]
        name = json["name"].stringValue
        originCountry = json["origin_country"].stringValue
    }
}
