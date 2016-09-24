//
//  DataManager.swift
//  TopApps
//
//  Created by Attila on 2015. 11. 10..
//  Copyright © 2015. -. All rights reserved.
//

import Foundation

open class DataManager {
  
    open class func loadDataFromJsonFile(_ fileName: String, success: @escaping ((_ data: Data) -> Void)) {
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async(execute: {
            let filePath = Bundle.main.path(forResource: fileName, ofType:"json")
            // swiftlint:disable:next force_try
            let data = try! Data(contentsOf: URL(fileURLWithPath: filePath!),
                                   options: NSData.ReadingOptions.uncached)
            success(data)
        })
    }
  
    open class func loadDataFromURL(_ url: URL, completion:@escaping (_ data: Data?, _ error: NSError?) -> Void) {
        let session = URLSession.shared
    
        let loadDataTask = session.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            if let responseError = error {
                completion(nil, responseError as NSError?)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    let statusError = NSError(domain: "com.raywenderlich",
                                              code: httpResponse.statusCode,
                                              userInfo: [NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    completion(nil, statusError)
                } else {
                    completion(data, nil)
                }
            }
        }) 
    
        loadDataTask.resume()
    }

}
