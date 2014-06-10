//
//  main.swift
//  wwdcdownloader
//
//  Created by Les Stroud on 6/8/14.
//  Copyright (c) 2014 Les Stroud. All rights reserved.
//

import Foundation



func parseJSON(data:NSData) -> Dictionary<String, AnyObject>?{
    var error: NSError?
    var json = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.AllowFragments, error:&error) as? Dictionary<String, AnyObject>
    
    if let dict = json {
        return json;
    } else {
        println("Unable to parse json from data provided.")
        println(error)
        return nil
    }
}

func getJSON(location:String!, completion:(NSData)->Void){
    let url = NSURL(string:location)
    var data = NSData(contentsOfURL: url)
    completion(data)
}

func getJSONBackground(location:String!, completion:(NSData)->Void){
    //var data = NSData.dataWithContentsOfFile("/Users/les/Documents/development/repos/github/wwdcdownloader/wwdcdownloader/wwdcdownloader/testdata.json", options: .DataReadingMappedIfSafe, error: nil)
    var done = false
    let session = NSURLSession.sharedSession()

    let itunesJson = session.dataTaskWithURL(url, completionHandler: {(data: NSData!, response: NSURLResponse!, error: NSError!) in
        //    var json = NSJSONSerialization.JSONObjectWithData(data!, options: 0, error: nil)
        //println(data)
        println("Received result")
        completion(data)
        done = true
    })

    itunesJson.resume()

    while (itunesJson.state == NSURLSessionTaskState.Running) && !done{
        NSThread.sleepForTimeInterval(0.1)
    }
}

let url = NSURL(string:"https://itunes.apple.com/search?term=apple&media=software")
//getJSON("https://itunes.apple.com/search?term=apple&media=software", {(data:NSData) -> Void in
//        if let json = parseJSON(data){
//            println(json.description)
//        } else {
//            println("Failed")
//        }
//
//    }
//)
getJSONBackground("https://itunes.apple.com/search?term=apple&media=software", {(data:NSData) -> Void in
    if let json = parseJSON(data){
        println(json.description)
    } else {
        println("Failed")
    }
    
    }
)





