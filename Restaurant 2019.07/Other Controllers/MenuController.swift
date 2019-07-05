//
//  MenuController.swift
//  Restaurant 2019.07
//
//  Created by Denis Bystruev on 05/07/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class MenuController {
    let baseURL = URL(string: "http://server.getoutfit.ru:8090")!
    
    func fetchCategories(completion: @escaping ([String]?) -> Void) {
        let categoryURL = baseURL.appendingPathComponent("categories")
        let task = URLSession.shared.dataTask(with: categoryURL) { data, response, error in
            guard let data = data else {
                completion(nil)
                return
            }
            guard let jsonDictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                completion(nil)
                return
            }
            let categories = jsonDictionary["categories"] as? [String]
            completion(categories)
        }
        task.resume()
    }
    
    func fetchMenuItems(forCategory categoryName: String, completion: @escaping ([MenuItem]?) -> Void) {
        let initialMenuURL = baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: initialMenuURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        guard let menuURL = components.url else {
            completion(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: menuURL) { data, response, error in
            guard let data = data else {
                completion(nil)
                return
            }
            let jsonDecoder = JSONDecoder()
            let menuItems = try? jsonDecoder.decode(MenuItems.self, from: data)
            completion(menuItems?.items)
        }
        task.resume()
    }
    
    func submitOrder(forMenuIDs menuIds: [Int], completion: @escaping (Int?) -> Void) {
        let orderURL = baseURL.appendingPathComponent("order")
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let data = ["menuIds": menuIds]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(nil)
                return
            }
            let jsonDecoder = JSONDecoder()
            let preparationTime = try? jsonDecoder.decode(PreparationTime.self, from: data)
            completion(preparationTime?.prepTime)
        }
        task.resume()
    }
    
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.host = baseURL.host
        guard let imageURL = components?.url else {
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard let data = data else {
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
}
