//
//  NetWorkService.swift
//  Abmstaff
//
//  Created by Hovo on 10/1/20.
//

import Foundation
import Alamofire


class NetWorkService {
    static let baseUrl = "https://api.abmstaff.com/api/"
    static let alamofireSessionMeneger = Alamofire.Session.default
    
    class func getHeaders() -> HTTPHeaders? {
        if let token = UserDefaults.standard.value(forKey: "token") as? String {
            return  ["Authorization": "Bearer \(token)"]
        }
        return nil
    }
    class func request<T:Codable>(url: String, method: HTTPMethod, param:Parameters?, encoding: JSONEncoding, complition: @escaping (T) -> Void ) {
        alamofireSessionMeneger.request(baseUrl + url, method: method, parameters: param, encoding: encoding , headers: getHeaders()).responseJSON { (resp) in
            switch resp.result {
            case.success(let data):
                print(data)
                do {
                    let json = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    let responseData = try JSONDecoder().decode(Response<T>.self, from: json)
                    if responseData.success {
                        complition(responseData.data)
                    } else {
                        print(responseData.messages.first?.value)
                    }
                    
                } catch {
                    print(error)
                }
                
            case.failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
   private class func showAlert() {
        let alert = UIAlertController(title: "Password or Email is incorrect", message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(alertAction)
    }
    
}
