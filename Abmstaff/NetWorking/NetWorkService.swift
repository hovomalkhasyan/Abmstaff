//
//  NetWorkService.swift
//  Abmstaff
//
//  Created by Hovo on 10/1/20.
//

import Foundation
import Alamofire


class NetWorkService {
   private static let baseUrl = "https://api.abmstaff.com/api/"
   private static let alamofireSessionMeneger = Alamofire.Session.default
    
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
                    let responseData = try JSONDecoder().decode(Response<T?>.self, from: json)
                    if responseData.success, let data = responseData.data {
                        complition(data)
                    } else {
                        if let message = responseData.messages.first?.value {
                            self.showAlert(title: message)
                        }
                    }
                    
                } catch {
                    print(error)
                }
                
            case.failure(let error):
                print(error.localizedDescription)
                self.showAlert(title: error.localizedDescription)
                
            }
        }
    }
    private class func showAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
}
