//
//  REST.swift
//  GitHubChallenge
//
//  Created by Kaique Alves on 21/03/20.
//  Copyright © 2020 Kaique Alves. All rights reserved.
//

import Foundation

enum GithubError{
    case url
    case taskError(error: Error)
    case noResponse
    case noData
    case responseStatusCode(Code: Int)
    case invalidJSON
    case duplicatedEmail
    case noValueTransfer
    case responseStatusCodeTransfer
}

public class REST{
    private static var basePath = "https://api.github.com/search/repositories?q=language:swift&sort=stars&per_page=10&page="
    
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Content-Type": "application/json"] //ja entende que é um json
        config.timeoutIntervalForRequest = 30.0 //tempo maximo de espera para uma requisicao
        config.httpMaximumConnectionsPerHost = 5 //maximo de conexoes simultaneas da sessao
        return config
    }()
    
    private static var session = URLSession(configuration: configuration)
    
    
    class func loadAGitHubList(page: Int = 1, onComplete: @escaping (GitHub, Int)->Void, onError: @escaping(GithubError) ->Void){
        
        guard let url = URL(string: basePath + String(page)) else {
            onError(.url)
            return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil{
                guard let response = response  as? HTTPURLResponse else {
                    onError(.noResponse)
                    return}
                
                
                if response.statusCode == 200{
                    guard let data = data else {return}
                    //print(String(data: data, encoding: .utf8)!)
                    do{
                        let gits = try JSONDecoder().decode(GitHub.self, from: data)
                        onComplete(gits, response.statusCode)
                    } catch{
                        print(error.localizedDescription)
                        print(error)
                        onError(.invalidJSON)
                    }
                }else{
                    print ("Algum status inválido pelo servidor")
                    onError(.responseStatusCode(Code: response.statusCode))
                }
            }
            else{
                onError(.taskError(error: error!))
            }
        }
        dataTask.resume()
    }
}
