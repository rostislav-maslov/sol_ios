//
//  RequestService.swift
//  SOL
//
//  Created by Rostislav Maslov on 26.05.2021.
//

import Foundation

class RequestService {
    
    internal func  requestJson<R:Encodable, T:Codable>(url:String, method: String, requestBody: R, responseFunc: @escaping ApiResponseProtocol<T>) {
        // prepare json data
        let jsonData:Data? = try? JSONEncoder().encode(requestBody)
        
        // create post request
        let url = URL(string: url)!
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        // insert json data to the request
        if (requestBody is EmptyRequest) == false && jsonData != nil {
            request.httpBody = jsonData
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let token: String? = DefaultStore.store.token.getAccessToken()

        if token != nil {
            request.addValue(token!, forHTTPHeaderField: "X-Auth-Token")
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                responseFunc(nil, BaseApiErrorResponse(), false)
                return
            }
            
            var status: Bool = false
            var code: Int = -1
            
            if let httpResponse = response as? HTTPURLResponse {
                if ( httpResponse.statusCode == 200 || httpResponse.statusCode == 201) {
                    status = true
                }
                code = httpResponse.statusCode
            }
            
            let responseObj = try? JSONDecoder().decode(BaseApiResponse<T>.self, from: data)
            var errorObj:BaseApiErrorResponse? = nil
            
            if responseObj == nil {
                errorObj = try? JSONDecoder().decode(BaseApiErrorResponse.self, from: data)
            }
            
            responseFunc(responseObj, errorObj, status)
            print("===========================")
            print("\(request.httpMethod ?? "") \(request.url)")
            print("HEADERS \n \(request.allHTTPHeaderFields)")
            
            var str = ""
            if request.httpBody != nil {
                str = String(decoding: request.httpBody!, as: UTF8.self)
            }
            print("BODY \n \(str)")
            print("----------------------------")
            print("CODE \n \(code)")
            print("responseObj \n \(responseObj)")
            print("errorObj \n \(errorObj)")
            print("===========================")
        }
        
        task.resume()
    }
    
    internal func  requestFormUrl<T:Codable>(url:String, method: String, responseFunc: @escaping ApiResponseProtocol<T>) {
        // prepare json data
        //let jsonData = try? JSONEncoder().encode(request)
        // create post request
        let url = URL(string: url)!
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        // insert json data to the request
        //request.httpBody = jsonData
        //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.addValue("application/json", forHTTPHeaderField: "Accept")
        let token: String? = DefaultStore.store.token.getAccessToken()

        if token != nil {
            request.addValue(token!, forHTTPHeaderField: "X-Auth-Token")
        }
                
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                responseFunc(nil, BaseApiErrorResponse(), false)
                return
            }
            
            var status: Bool = false
            var code: Int = -1
            
            if let httpResponse = response as? HTTPURLResponse {
                if ( httpResponse.statusCode == 200 || httpResponse.statusCode == 201) {
                    status = true
                }
                code = httpResponse.statusCode
            }
            
            let responseObj = try? JSONDecoder().decode(BaseApiResponse<T>.self, from: data)
            var errorObj:BaseApiErrorResponse? = nil
            
            if responseObj == nil {
                errorObj = try? JSONDecoder().decode(BaseApiErrorResponse.self, from: data)
            }
            
            responseFunc(responseObj, errorObj, status)
            
            print("===========================")
            print("\(request.httpMethod ?? "") \(String(describing: request.url))")
            print("HEADERS \n \(String(describing: request.allHTTPHeaderFields))")
            var str = ""
            if request.httpBody != nil {
                str = String(decoding: request.httpBody!, as: UTF8.self)
            }
            print("BODY \n \(str)")
            print("----------------------------")
            print("CODE \n \(code)")
            print("responseObj \n \(responseObj)")
            print("errorObj \n \(errorObj)")
            print("===========================")
        }
        
        task.resume()
    }
    
}
