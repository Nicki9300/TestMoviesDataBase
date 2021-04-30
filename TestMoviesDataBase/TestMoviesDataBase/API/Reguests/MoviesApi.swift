//
//  MoviesApi.swift
//  TestMoviesDataBase
//
//  Created by Коля Мамчур on 27.04.2021.
//

import Alamofire

class MoviesApi: RestClient {
    
    func fetchMovies(withPage: Int, resp: @escaping IdResponseBlock) {
        
        let url = BaseRequests.baseURL + MovieRequests.movie + MovieRequests.topRated + MovieRequests.apiKeyTitle + MovieRequests.apiKeyValue + MovieRequests.page + String(withPage)
        
        http.query(url, queue: .defaultQos) { (data, error) in
            self.response(data, error, modelCls: ResultMovies.self, resp: resp)
        }
    }
}


