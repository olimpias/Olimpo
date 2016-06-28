//
//  CacheReleaseDelegate.swift
//  olimpo
//
//  Created by Cem Türker on 27/04/16.
//  Copyright © 2016 Cem Türker. All rights reserved.
//

import Foundation

protocol CacheReleaseDelegate {
    func keyWillBeReleasedFromCache(key:String);
}