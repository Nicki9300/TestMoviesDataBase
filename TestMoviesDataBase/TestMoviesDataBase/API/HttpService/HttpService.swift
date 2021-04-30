//
//  HttpService.swift
//  TestMoviesDataBase
//
//  Created by Коля Мамчур on 27.04.2021.
//

import Foundation
import Alamofire

typealias IdResponseBlock = (_ swiftObj: Any?, _ error: Error?) -> Void

enum QueueQos {
    case background
    case defaultQos
}

protocol CustomErrorProtocol: Error {
    var localizedDescription: String { get }
    var code: Int { get }
}

struct CustomError: CustomErrorProtocol {
    
    var localizedDescription: String
    var code: Int
    
    init(localizedDescription: String, code: Int) {
        self.localizedDescription = localizedDescription
        self.code = code
    }
}

class HttpService {

    func serverError() -> CustomError {
        return CustomError(localizedDescription: "Could not access the server", code: 500)
    }
}

extension HttpService {
    
    func cancellAllRequests() {
        
        Alamofire.Session.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            
            sessionDataTask.forEach { $0.cancel() }
            uploadData.forEach { $0.cancel() }
            downloadData.forEach { $0.cancel() }
        }
    }
    
    func query(_ url: URLConvertible,
               method: HTTPMethod = .get,
               parameters: Parameters? = nil,
               encoding: ParameterEncoding = URLEncoding.default,
               headers: HTTPHeaders? = nil,
               queue: QueueQos,
               resp: @escaping IdResponseBlock) {
        
        let queueQos: DispatchQueue
        
        switch queue {
        case QueueQos.defaultQos:
            queueQos = DispatchQueue(label: "com.queueDefault", qos: .default, attributes: [.concurrent])
        case QueueQos.background:
            queueQos = DispatchQueue(label: "com.queueBackground", qos: .background, attributes: [.concurrent])
        }

        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        AF.request(url,
                                 method: method,
                                 parameters: parameters,
                                 encoding: encoding,
                                 headers: headers
        ).validate().responseData(queue: queueQos) { (response) in
            
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            guard let statusCode = response.response?.statusCode else {
                print("ERROR: Not Found status code")
                return resp(nil, CustomError(localizedDescription: "Not Found status code", code: 0))
            }
            
            switch response.result {
            case .success(let value):
                return resp(value, nil)
            case .failure( _):
                return resp(nil, self.parseError(response.data, statusCode: statusCode))
            }
        }
    }
    

    private func parseError(_ data: Data?, statusCode: Int) -> CustomError {
        guard let data = data else { return serverError() }
        
        do {
            let model = try JSONDecoder().decode(ErrorRequest.self, from: data)
            print(model.error)
            switch model.error {
            case "No such user":
                return CustomError(localizedDescription: "errorEnterDate", code: statusCode)
            case "Passwords dont match":
                return CustomError(localizedDescription: "errorEnterDate", code: statusCode)
            default:
                return CustomError(localizedDescription: model.error, code: statusCode)
            }
        } catch let error {
            print(error)
            return serverError()
        }
    }
}
