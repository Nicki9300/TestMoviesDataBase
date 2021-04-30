//
//  RestClient.swift
//  TestMoviesDataBase
//
//  Created by Коля Мамчур on 27.04.2021.
//

import Alamofire

class RestClient: NSObject {
    
    let http = HttpService()
    
    let dataIsNil = CustomError.init(localizedDescription: "Error parsing", code: 0)
    
    func response<P: Codable>(_ response: Any?, _ error: Error?, modelCls: P.Type, key: String? = nil, resp: @escaping IdResponseBlock) {
        
        if let error = error {
            return resp(nil, error)
        }
        
        guard let data = response as? Data else {
            return resp(nil, error)
        }
        
        do {
            let model = try JSONDecoder().decode(modelCls.self, from: data)
            return resp(model, nil)
        } catch {
            print("error: ", error)
            return resp(nil, self.dataIsNil)
        }
    }
    
    func cancellRequests() {
        http.cancellAllRequests()
    }
}
