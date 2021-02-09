//
//  ModelView.swift
//  Ozone
//
//  Created by Sofi on 09.02.2021.
//

import Foundation
import SwiftUI
import SwiftyJSON
import Alamofire



class ModelView: ObservableObject {
    @Published var perehod = 0
    @Published var gym:[Model] = []
    func SignUp(user:String, pass:String) {
        let url = "http://gym.areas.su/signup?username=\(user)&email=@3&password=\(pass)&weight=40&height=170"
        AF.request(url, method: .post).validate().responseJSON {[ self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                gym.append(Model(nam: "\(user)", pass: "\(pass)"))
                print("JSON: \(json)")
                
            case .failure(let error):
                print(error)
            }
        }

    }
    func SignIn(user:String, pass:String) {
        let url = "http://gym.areas.su/signin?username=\(user)&password=\(pass)"
        AF.request(url, method: .post).validate().responseJSON {[ self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if json["notice"]["token"].stringValue != "" {
                    perehod = 1
                    
                    
                } else if json["notice"]["answer"].stringValue  == "Error username or password" {
                    perehod = 2
                } else if json["notice"]["answer"].stringValue  == "User is active" {
                    perehod = 3
                }
                print("JSON: \(json)")
                
            case .failure(let error):
                print(error)
            }
        }

    }
}
