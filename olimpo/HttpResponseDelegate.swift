//
//  NetworkCallback.swift
//  olimpo
//
//  Created by Cem Türker on 26/04/16.
//  Copyright © 2016 Cem Türker. All rights reserved.
//

import Foundation

protocol HttpResponseDelegate{
    func httpRequestFinishedWithSuccess(data:NSData?, url:NSURL);
    func httpRequestFailedWithReason(url:NSURL, error:NSError);
    func httpRequestFailedWithStatusCode(url:NSURL, response:NSHTTPURLResponse);
}