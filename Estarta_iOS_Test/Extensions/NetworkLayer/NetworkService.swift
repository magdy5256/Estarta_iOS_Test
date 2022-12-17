//
//  NetworkService.swift
//  Estarta_iOS_Test
//
//  Created by Magdy Khaled on 17/12/2022.
//

import Foundation
import Combine

protocol Request {
    var urlRequest: URLRequest { get }
}

/// An abstract service type that can have multiple implementation for example - a NetworkService that gets a resource from the Network or a DiskService that gets a resource from Disk
protocol Service {
    //    func callAPI<T:Any>(request: Request) -> AnyPublisher<BaseModel<T>, Error>
    
    func execute<T>(_ request: Request, decodingType: T.Type, queue: DispatchQueue, retries: Int) -> AnyPublisher<T, Error> where T: Decodable
    
    
    
}

/// A concrete implementation of Service class responsible for getting a Network resource
final class NetworkService: Service {
    static let shared = NetworkService()
    
    enum ServiceError: Error {
        case noData
    }
    
    
    func execute<T>(_ request: Request,
                       decodingType: T.Type,
                       queue: DispatchQueue = .main,
                       retries: Int = 0) -> AnyPublisher<T, Error> where T: Decodable {
           /// 3
        return URLSession.shared.dataTaskPublisher(for: request.urlRequest)
               .tryMap {
                   print($0.response.description)

                   return $0.data
               }
               .decode(type: T.self, decoder: JSONDecoder())
               .receive(on: queue)
               .retry(retries)
               .eraseToAnyPublisher()
       }
    
}

struct APIRequest: Request {
    var url: URL
    var parameters: [String: Any]? = nil
    var method: APIMethod
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: url)
        if let parameters = parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        }
        if method == .get {
            request.httpBody = nil
        }
        
        
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        return request
    }
}

enum APIMethod: String {
    case post = "POST"
    case get = "GET"
}
