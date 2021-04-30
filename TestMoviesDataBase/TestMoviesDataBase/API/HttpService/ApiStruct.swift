//
//  ApiStruct.swift
//  TestMoviesDataBase
//
//  Created by Коля Мамчур on 27.04.2021.
//

struct BaseRequests {
    static let baseURL = "https://api.themoviedb.org/3/"
}

struct MovieRequests {
    static let imagePath = "https://image.tmdb.org/t/p/w92"
    static let movie = "movie/"
    static let topRated = "top_rated?"
    static let apiKeyTitle = "api_key="
    static let apiKeyValue = "f910e2224b142497cc05444043cc8aa4"
    static let page = "&page="
    static let search = "search/"
    static let language = "language=en-US&"
    static let query = "query="
    static let noAdult = "&include_adult=false"
}

