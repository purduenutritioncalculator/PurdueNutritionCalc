//
//  APICaller.swift
//  NutritionCalc
//
//  Created by Anderson David on 3/25/19.
//  Copyright © 2019 Anderson David. All rights reserved.
//

import Foundation

struct APICaller {
    
    static func getInfoForDiningCourt(diningCourt: String, date: String, completion: @escaping (DiningCourt) -> Void) {
        let decoder = JSONDecoder()
        var result:DiningCourt = DiningCourt()
        
        let url = URL(string: "https://api.hfs.purdue.edu/menus/v2/locations/\(diningCourt)/\(date)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                print("decoding...\n")
                result = try! decoder.decode(DiningCourt.self, from: data)
                completion(result)
            }
        }
        task.resume()
        
    }
    
}
