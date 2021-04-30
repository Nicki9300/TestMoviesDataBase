//
//  InternetService.swift
//  TestMoviesDataBase
//
//  Created by Коля Мамчур on 27.04.2021.
//


import Foundation
import Alamofire

class InternetService {
    
    private let net = NetworkReachabilityManager()
    
    static let shared = InternetService()
    var internetHandler: ((_ flag: Bool) -> Void)?
    
    private init() {}

    func checkInternetConnect() -> Bool {
        return net?.isReachable ?? false
    }
    
}
