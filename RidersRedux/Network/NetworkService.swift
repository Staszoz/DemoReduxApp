//
//  NetworkService.swift
//  RidersRedux
//
//  Created by Станислав Калиберов on 25.02.2018.
//  Copyright © 2018 Станислав Калиберов. All rights reserved.
//

import Foundation


func getURL<T: Decodable>(url: URL, completion: ((T) -> ())?) {
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        let value = try! JSONDecoder().decode(T.self, from: data!)
        completion?(value)
    }
    
    task.resume()
}

