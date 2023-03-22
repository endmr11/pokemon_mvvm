//
//  NetworkManager.swift
//  PokemanApp
//
//  Created by Eren Demir on 20.03.2023.
//

import Foundation

import UIKit
import Alamofire

//MARK: - INTERFACE
protocol APIManagerProtocol {
    func apiRequest<T: Decodable>(endpoint: Endpoint, type: T.Type, params:[String:String],completer: @escaping (Result<T, NetworkError>) -> Void)
    func apiRequestWithAsync<T: Decodable>(endpoint: Endpoint, type: T.Type, params: [String:String]) async throws -> T?
}

final class APIManager: APIManagerProtocol {
    static let shared = APIManager()
    
    //MARK: - COMPLETER
    /// A classic http request. Completer.
    func apiRequest<T: Decodable>(endpoint: Endpoint, type: T.Type,params:[String:String], completer: @escaping (Result<T, NetworkError>) -> Void) {
        AF.request(endpoint.url,parameters: params).responseDecodable(of: T.self) { result in
            guard let result = result.value else {
                completer(.failure(.invalidData))
                return
            }
            completer(.success(result))
        }
    }
    
    //MARK: - ASYNC AWAIT
    /// A modern http request. Async Await
    func apiRequestWithAsync<T: Decodable>(endpoint: Endpoint, type: T.Type, params: [String:String]) async throws -> T? {
        let dataTask = AF.request(endpoint.url,parameters: params).serializingDecodable(T.self)
        let value = try await dataTask.value
        return value
    }
    
}

enum NetworkError: String, Error {
    case invalidData = "The data received from the server was invalid. Please try again."
}
