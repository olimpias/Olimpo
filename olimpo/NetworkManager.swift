//
//  NetworkManager.swift
//  olimpo
//
//  Created by Cem Türker on 22/04/16
//  Copyright © 2016 Cem Türker. All rights reserved.
//
//  Configures network requests.
//

import Foundation


class NetworkManager:NSObject, NSURLSessionDataDelegate   {
    private let operationQueue:NSOperationQueue;
    private static let MAX_CONCURRENT_THREAD = 5; //Default value
    private var configuration:NSURLSessionConfiguration = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier("com.olimpo.backgroundSession");
    private var session:NSURLSession?;
    private let networkCallback:HttpResponseDelegate;
    private var networkMap = Dictionary<NSURLSessionTask,NetworkRequest>();
    init(networkCallback:HttpResponseDelegate) {
        //configuration.allowsCellularAccess = true;
        self.networkCallback = networkCallback;
        self.operationQueue = NSOperationQueue();
        super.init();
        operationQueue.maxConcurrentOperationCount = NetworkManager.MAX_CONCURRENT_THREAD;
        self.session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: operationQueue);
    }
    
    func cancelAllOpertions(){
        operationQueue.cancelAllOperations();
    }
    //Creates  networkRequest object with given url parameter.
    func downloadDataFromGivenUrl(url:NSURL){
        let networkRequest = NetworkRequest(destinationUri: url);
        let dataTask = session!.dataTaskWithURL(url);
        networkMap[dataTask] = networkRequest;
        dataTask.resume();
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        if let networkRequest = networkMap[dataTask] {
            networkRequest.addNewData(data);
        }
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveResponse response: NSURLResponse, completionHandler: (NSURLSessionResponseDisposition) -> Void) {
        let httpResponse:NSHTTPURLResponse = response as! NSHTTPURLResponse;
        let networkRequest = networkMap[dataTask]
        if networkRequest != nil {
            if  httpResponse.statusCode == 200 {
                networkRequest!.initilizeData();
            }else{
                networkMap.removeValueForKey(dataTask);
                self.networkCallback.httpRequestFailedWithStatusCode(networkRequest!.destinationUri, response: httpResponse);
            }
        }
        completionHandler(NSURLSessionResponseDisposition.Allow);
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        if let networkrequest = networkMap[task] {
            if (error != nil) {
                print(error);
                self.networkCallback.httpRequestFailedWithReason(networkrequest.destinationUri, error: error!);
            }else{
                self.networkCallback.httpRequestFinishedWithSuccess(networkrequest.receivedData, url: networkrequest.destinationUri);
            }
        }
        networkMap.removeValueForKey(task);
        
    }
    
    
    
}