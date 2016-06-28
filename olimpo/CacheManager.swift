//
//  CollectionCache.swift
//
//
//  Created by Cem Türker on 05/04/16.
//  Copyright © 2016 Cem Türker. All rights reserved.
//

import Foundation
import UIKit

class CacheQueue<T>
{
    var queue : [T?]!;
    var limit:Int!
    var tail:Int;
    var head:Int;
    init(limit:Int)
    {
        self.limit = limit;
        queue = [T?](count:limit, repeatedValue: nil);
        tail = 0;
        head = 0;
    }
    subscript(index:Int)->T?
        {
        get{
            return queue[index];
        }
    }
    func isQueueFull() -> Bool
    {
        return ((head + 1)%limit) == tail;
    }
    func isQueueEmpty() -> Bool
    {
        return tail == head;
    }
    func enQueue(t:T) -> Int
    {
        if !isQueueFull()
        {
            let tmp:Int = head;
            queue[head] = t;
            head = (head + 1) % limit;
            return tmp;
        }
        return -1;
    }
    func deQueue() -> Int{
        if !isQueueEmpty() {
            let tmp:Int = tail;
            queue[tail] = nil;
            tail = (tail + 1) % limit;
            return tmp;
        }
        return -1;
    }
    func removeAllValues(){
        tail = 0;
        head = 0;
        queue.removeAll(keepCapacity: false);
        queue = [T?](count:limit, repeatedValue: nil);
    }
    
}

class CacheManager<T>
{
    var cacheQeue : CacheQueue<T>;
    var dictionaryMap : Dictionary<String,Int>;
    let cacheRelease:CacheReleaseDelegate;
    init(capacity:Int, cacheRelease:CacheReleaseDelegate)
    {
        cacheQeue = CacheQueue(limit: capacity);
        dictionaryMap = Dictionary();
        self.cacheRelease = cacheRelease;
    }
    func cacheNewItem(key:String,value : T)
    {
        objc_sync_enter(self);
        if self.cacheQeue.isQueueFull()
        {
            let index = self.cacheQeue.deQueue();
            self.removeKeyValuePair(index);
        }
        let index = self.cacheQeue.enQueue(value);
        if index != -1 {
            self.dictionaryMap[key] = index;
        }
        objc_sync_exit(self);
        
    }
    private func removeKeyValuePair(index:Int)
    {
        objc_sync_enter(self);
        for (key,value) in dictionaryMap
        {
            if index == value {
                cacheRelease.keyWillBeReleasedFromCache(key);
                dictionaryMap.removeValueForKey(key);
            }
        }
        objc_sync_exit(self);
    }
    func getKeyPairValue (key : String) -> T? {
        var returnValue:T? = nil;
        objc_sync_enter(self);
        if let index = self.dictionaryMap[key] {
            returnValue = self.cacheQeue[index];
        }
        objc_sync_exit(self);
        return returnValue;
    }
    
    func removeAllKeyAndValuePairs(){
        objc_sync_enter(self);
        for (key,_) in dictionaryMap {
            cacheRelease.keyWillBeReleasedFromCache(key);
        }
        dictionaryMap.removeAll();
        cacheQeue.removeAllValues();
        objc_sync_exit(self);
    }
}
