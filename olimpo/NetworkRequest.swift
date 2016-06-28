//
//  NetworkRequest.swift
//  olimpo
//
//  Created by Cem Türker on 30/04/16.
//  Copyright © 2016 Cem Türker. All rights reserved.
//

import Foundation

class NetworkRequest {
    let destinationUri:NSURL;
    var receivedData:NSMutableData?
    init(destinationUri:NSURL){
        self.destinationUri = destinationUri;
    }
    func initilizeData(){
        self.receivedData = NSMutableData();
        self.receivedData?.length = 0;
    }
    func addNewData(newData:NSData) {
        if receivedData != nil {
            self.receivedData?.appendData(newData);
        }
    }
}