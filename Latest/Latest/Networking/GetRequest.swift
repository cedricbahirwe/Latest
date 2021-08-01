//
//  GetRequest.swift
//  Latest
//
//  Created by Cédric Bahirwe on 20/04/2021.
//

import Foundation

enum LatestEndPoints {
    
    enum NewsAPI: String {
        case everything = "everything"
        case topheadLines = "top-headlines"
    }
}

enum LatestNetworkError: Error {
    case unknownError(message: String)
    case serverError
    case unableToDecodeData
    var message: String {
        switch  self {
        case .unknownError(let message):  return message
        case .serverError: return "Unable to contact the server for the moment."
        case .unableToDecodeData: return "We are currently facing an issue with the data."
        }
    }
}


struct NewsAPiError: Error, Decodable {
    var message: String
}
struct GetRequest<ResponseStruct: Decodable>{
    let routeURL: URL
    
    

    func requestData(completion: @escaping(Result<ResponseStruct, LatestNetworkError>) -> Void){
        
        var request = URLRequest(url: routeURL)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let dataTask = URLSession.shared.dataTask(with: request){
            data, response, error in
            
            if let error = error {
                completion(.failure(.unknownError(message: error.localizedDescription)))
            } else {
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(.serverError))
                    return
                }
                let decoder = JSONDecoder()

                if !(200...299).contains(response.statusCode) {
                    if let _ = String(bytes: data!, encoding: .utf8) {
                        let data = try! decoder.decode(NewsAPiError.self, from: data!)
                        completion(.failure(.unknownError(message: data.message)))
                    } else {
                        completion(.failure(.serverError))
                        print(data! as NSData)
                    }
                } else {
                    do {
                        let data = try decoder.decode(ResponseStruct.self, from: data!)
                        completion(.success(data))
                    } catch let error as NSError{
                        if let jsonData = try? JSONSerialization.jsonObject(with: data!, options: []){
                            print(jsonData)
                        } else {
                            print("Can not decode: ", error.localizedDescription)
                        }
                        completion(.failure(.unableToDecodeData))
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    static func requestDatum(request: URLComponents, completion: @escaping(Result<ResponseStruct, LatestNetworkError>) -> Void){
        var request =  URLRequest(url: request.url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let dataTask = URLSession.shared.dataTask(with: request){
            data, response, error in
            
            if let error = error {
                completion(.failure(.unknownError(message: error.localizedDescription)))
            } else {
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(.serverError))
                    return
                }
                let decoder = JSONDecoder()

                if !(200...299).contains(response.statusCode) {
                    if let _ = String(bytes: data!, encoding: .utf8) {
                        let data = try? decoder.decode(NewsAPiError.self, from: data!)
                        completion(.failure(.unknownError(message: data!.message)))
                    } else {
                        completion(.failure(.serverError))
                        print(data! as NSData)
                    }
                } else {
                    do {
                        let data = try decoder.decode(ResponseStruct.self, from: data!)
                        completion(.success(data))
                    } catch let error as NSError{
                        if let jsonData = try? JSONSerialization.jsonObject(with: data!, options: []){
                            print(jsonData)
                        } else {
                            print("Can not decode: ", error.localizedDescription)
                        }
                        completion(.failure(.unableToDecodeData))
                    }
                }
            }
        }
        dataTask.resume()
    }
}


extension URLRequest {
    
}
