//
//  JServiceConnector.swift
//  GiveMeTrivia
//
//  Created by William Cho on 5/26/16.
//  Copyright © 2016 wc. All rights reserved.
//

import Foundation

class JServiceConnector {
    
    static let cacheURL = NSURLCache(memoryCapacity: 5 * 1024, diskCapacity: 5 * 1024, diskPath: "JServiceCache")
    static let session: NSURLSession = {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        config.requestCachePolicy = NSURLRequestCachePolicy.ReturnCacheDataElseLoad
        config.URLCache = cacheURL
        return NSURLSession(configuration: config)
    }()
    
    class func connect(uri: String, completionHandler:(AnyObject?, NSURLResponse?, NSError?) -> Void) {
        print(uri)
        guard let url = NSURL(string: uri) else {
            completionHandler(nil, nil, nil)
            return
        }
        let request = NSURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReturnCacheDataElseLoad, timeoutInterval: 30.0)
        session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
            var json: AnyObject?
            do {
                if let data = data {
                    print(NSString(data: data, encoding: NSUTF8StringEncoding))
                } else {
                    print("Empty Data")
                }
                
                json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
            } catch _ {
                print("JSON Serialization Error")
            }
            
            completionHandler(json, response, error)
        }).resume()
    }
    
    class func getRandomClues(count: Int, callback: ([JSClue]) -> Void) {
        let uri = JServiceAPI(option: .Random(count: count)).getUri()
        connect(uri) { (json, response, error) in
            guard let json = json as? [Payload] else {
                print("Error parsing random clues")
                return
            }
            let clues = JServiceParser.parseClueList(json)
            dispatch_async(dispatch_get_main_queue(), {
                callback(clues)
            })
        }
    }
    
    class func getCategoryClues(id: Int, callback: (JSCategory, [JSClue]) -> Void) {
        let uri = JServiceAPI(option: .Category(id: id)).getUri()
        connect(uri) { (json, response, error) in
            guard let json = json as? Payload
                , cluesJson = json["clues"] as? [Payload]
                , category = JServiceParser.parseCategory(json) else {
                print("Error parsing category clues")
                return
            }
            
            let clues = JServiceParser.parseClueList(cluesJson)
            clues.forEach({ $0.category = category })
            dispatch_async(dispatch_get_main_queue(), {
                callback(category, clues)
            })
        }
    }
    
    class func getCategories(count: Int, offset: Int, callback: ([JSCategory]) -> Void) {
        let uri = JServiceAPI(option: .Categories(count: count, offset: offset)).getUri()
        connect(uri) { (json, response, error) in
            guard let json = json as? [Payload] else {
                print("Error parsing categories")
                return
            }
            let categories = JServiceParser.parseCategoryList(json)
            dispatch_async(dispatch_get_main_queue(), {
                callback(categories)
            })
        }
    }
    
    
}