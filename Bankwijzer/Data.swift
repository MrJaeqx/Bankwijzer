//
//  GetData.swift
//  Bankwijzer
//
//  Created by Fhict on 30/04/15.
//  Copyright (c) 2015 Fhict. All rights reserved.
//

import Foundation

let TopAppURL = "http://larsjaeqx.nl/alwaysconnected/values.php"

class Data{
    
    class func getDataWithSuccess(success: ((Data: NSData!) -> Void)) {
        loadDataFromURL(NSURL(string: TopAppURL)!, completion:{(data, error) -> Void in
            if let urlData = data {
                success(Data: urlData)
            }
        })
    }
    
    class func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSError?) -> Void) {
        var session = NSURLSession.sharedSession()
        
        // Use NSURLSession to get data from an NSURL
        let loadDataTask = session.dataTaskWithURL(url, completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            if let responseError = error {
                completion(data: nil, error: responseError)
            } else if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    completion(data: nil, error: nil)
                    // do error handling
                } else {
                    completion(data: data, error: nil)
                }
            }
        })
        
        loadDataTask.resume()
    }
}
