//
//  GetRequest.swift
//  Latest
//
//  Created by Cédric Bahirwe on 20/04/2021.
//

import Foundation

enum LatestEndPoints {
    case apple
    case other
    
    var endpoint: String {
        switch self {
        case .apple:
            return ""
        default:
            return ""
        }
    }
}
enum LatestNetworkError: Error {
    case unknownError(message: String)
    case serverError
    case unableToDecodeData
}
struct GetRequest<ResponseStruct: Decodable>{
    let routeURL: URL
    
    init(baseUrl: String, _ path: LatestEndPoints){
        guard let url =  URL(string: "\(baseUrl)\(path.endpoint)") else {
            fatalError("Unable to convert the string to a valid url")
        }
        routeURL = url
        
        print("Accessing: ", routeURL)
    }
    
    init(_ fullRoutePath: String) {
        guard let url = URL(string: fullRoutePath) else {
            fatalError("Unable to convert the string to a valid url")
        }
        routeURL = url
        print("Accessing: ", routeURL)
    }
    
    func get(completion: @escaping(Result<ResponseStruct, LatestNetworkError>) -> Void){
        
        var request = URLRequest(url: routeURL)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let dataTask = URLSession.shared.dataTask(with: request){
            data, response, error in
            
            if let error = error{
                // Request failure is sent here with localized Description.
                // Bad request and internet failures or unreachable server often exits here
                completion(.failure(.unknownError(message: error.localizedDescription)))
            } else{
                // convert the response to httpUrlResponse
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(.serverError))
                    return
                }
                if !(200...299).contains(response.statusCode){
                    if let responseString = String(bytes: data!, encoding: .utf8) {
                        // The response body seems to be a valid UTF-8 string, so print that.
                        completion(.failure(.unknownError(message: responseString)))
                        print(responseString)
                    } else {
                        // Otherwise print a hex dump of the body.
                        completion(.failure(.serverError))
                        print(data! as NSData)
                    }
                } else {
                    do {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode(ResponseStruct.self, from: data!)
                        completion(.success(data))
                    } catch let error as NSError{
                        if let jsonData = try? JSONSerialization.jsonObject(with: data!, options: []){
                            print(jsonData)
                        }
                        // If server's response structure is different from local structure, error occurs
                        print("Can not decode: ", error.localizedDescription)
                        completion(.failure(.unableToDecodeData))
                    }
                }
            }
        }
        dataTask.resume()
    }
}
