//
//  AppRequests.swift
//  ReposListView
//
//  Created by Alexandru Dinu on 25/06/2019.
//  Copyright © 2019 noname. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

// Server
let server = "https://api.github.com"
// API
let authAPI = "/user"
let reposAPI = "/repositories"

class AppRequests {

    func basicAuthentication(username: String, password: String, completion: @escaping (DataResponse<Any>?) -> Void) {
        let credentialData = "\(username):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        let headers = ["Authorization": "Basic \(base64Credentials)"]

        Alamofire.request(server + authAPI,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers:headers)
            .validate()
            .responseJSON { response in
                if response.error != nil || response.data == nil {
                    completion(nil)
                }
                completion(response)
        }
    }

    func publicReposRequest(completion:@escaping (Result<[Repos]>)->Void) {
        Alamofire.request(server + reposAPI, method: .get).responseData { response in
            let decoder = JSONDecoder()
            let todo: Result<[Repos]> = decoder.decodeResponse(from: response)
            completion(todo)
        }
    }

    func downloadImage(imageUrl: String,completion:@escaping (Image?)->Void){
        Alamofire.request(imageUrl, method: .get).responseImage { response in
            guard let image = response.result.value else {
                // Handle error
                completion(nil)
                return
            }
            completion(image)
        }
    }
}


extension JSONDecoder {
    func decodeResponse<T: Decodable>(from response: DataResponse<Data>) -> Result<T> {
        guard response.error == nil else {
            print(response.error!)
            return .failure(response.error!)
        }

        guard let responseData = response.data else {
            print("didn't get any data from API")
            return .failure(NSError(domain: "backendError", code: 500, userInfo: nil))
        }

        do {
            let item = try decode(T.self, from: responseData)
            return .success(item)
        } catch {
            print("error trying to decode response")
            print(error)
            return .failure(error)
        }
    }
}



