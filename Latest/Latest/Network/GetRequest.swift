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
    var routeUrl: URL
    
    init(baseUrl: String, _ routeString: LatestEndPoints){
        guard let url =  URL(string: "\(baseUrl)\(routeString.endpoint)") else {
            fatalError("BASE_URL_ERROR_MESSAGE")
        }
        self.routeUrl = url
        
        print("Hitting >>> ", self.routeUrl)
    }
    
    init(_ fullRoutePath: String) {
        guard let url = URL(string: fullRoutePath) else {
            fatalError("BASE_URL_ERROR_MESSAGE")
        }
        self.routeUrl = url
        print("Hitting >>> ", self.routeUrl)

    }
    
    func get(completion: @escaping(Result<ResponseStruct, LatestNetworkError>) -> Void){
        
        var request = URLRequest(url: self.routeUrl)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let dataTask = URLSession.shared.dataTask(with: request){
            responseBody, response, error in
            
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
                    if let responseString = String(bytes: responseBody!, encoding: .utf8) {
                        // The response body seems to be a valid UTF-8 string, so print that.
                        completion(.failure(.unknownError(message: responseString)))
                        print(responseString)
                    } else {
                        // Otherwise print a hex dump of the body.
                        completion(.failure(.serverError))
                        print(responseBody! as NSData)
                    }
                } else{
                    // Request is successful and we've gotten the data, we try to decode the data here
                    do{
                        if let json = try? JSONSerialization.jsonObject(with: responseBody!, options: []){
                            print(json)
                        }
                        let decoder = JSONDecoder()
                        let data = try decoder.decode(ResponseStruct.self, from: responseBody!)
                        completion(.success(data))
                    } catch let error as NSError{
                        // If server's response structure is different from local structure, error occurs
                        print("An error occured when trying to decode the data >>>", error.localizedDescription)
                        completion(.failure(.unableToDecodeData))
                    }
                }
            }
        }
        dataTask.resume()
    }
}
