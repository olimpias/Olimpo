//
//  MediaController.swift
//  olimpo
//
//  Created by Cem Türker on 16/04/16.
//  Copyright © 2016 Cem Türker. All rights reserved.
//

import Foundation
import UIKit

class MediaController : HttpResponseDelegate, CacheReleaseDelegate {
    
    private var mediaCachingMap = Dictionary<String,Action>();
    private var imageViewMap = Dictionary<UIImageView,String>();
    var collectionCacheManager:CacheManager<UIImage>?;
    let backgroundQueue:dispatch_queue_t = dispatch_queue_create("com.olimpo", DISPATCH_QUEUE_CONCURRENT);
    init() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MediaController.didReceiveMemoryWarning(_:)), name: UIApplicationDidReceiveMemoryWarningNotification, object: nil);
    }
    
    func addNewAction(action:Action,imageView:UIImageView) {
        if collectionCacheManager == nil{
            collectionCacheManager =  CacheManager<UIImage>(capacity: Olimpo.MAX_CAPACITY_VALUE, cacheRelease: self);
        }
        if action.url != nil {
            action.applyContentModeTo(imageView);
            imageView.image = action.placeHolder != nil ? action.placeHolder! : nil;
            imageViewMap[imageView] = action.url!;
            mediaCachingMap[action.url!] = action;
        }
        
    }
    
    func nofityImageView(key:String){
        if let action  = self.mediaCachingMap[key] {
            for (imageView,url) in self.imageViewMap {
                if url == action.url {
                    dispatch_async(dispatch_get_main_queue()) { () -> Void in
                        action.applyContentModeTo(imageView);
                        imageView.image = self.collectionCacheManager?.getKeyPairValue(key);
                        
                    };
                }
            }
        }
        
    }
    
    func notifyImageViewWithError(key:String)  {
        if let action  = self.mediaCachingMap[key] {
            for (imageView,url) in self.imageViewMap {
                if url == action.url {
                    dispatch_async(dispatch_get_main_queue()) { () -> Void in
                        action.applyContentModeTo(imageView);
                        imageView.image = action.error != nil ? action.error : nil;
                    };
                }
            }
        }
        
    }
    //Changes imageview's image with given key(url) value
    func changeImageInImageView(imageView:UIImageView, key:String){
        imageViewMap[imageView] = key;
        if let action = mediaCachingMap[key] {
            action.applyContentModeTo(imageView);
            if let image = self.collectionCacheManager?.getKeyPairValue(key) {
                imageView.image = image;
            }else{
                action.applyContentModeTo(imageView);
                imageView.image = action.placeHolder != nil ? action.placeHolder! : nil;
            }
        }
    }
    
    func isCacheContains(action:Action) -> Bool {
        return mediaCachingMap[action.url!] != nil &&  collectionCacheManager!.getKeyPairValue(action.url!) != nil;
    }
    
    //Changes action according to given action url
    //This method should not be called before checking action with isCacheContains method!
    func updateActionData(action:Action){
        mediaCachingMap[action.url!] = action;
    }
    
    //MARK: HttpResponseDelegate
    
    func httpRequestFinishedWithSuccess(data:NSData?, url:NSURL){
        if data != nil {
            dispatch_async(backgroundQueue, { () -> Void in
                if var image = UIImage(data: data!) {
                    if self.collectionCacheManager != nil {
                        if let action  = self.mediaCachingMap[url.absoluteString] {
                            if action.newSize != nil {
                                image = Utils.resizeImage(image, newSize: action.newSize!);
                            }
                        }
                        self.collectionCacheManager!.cacheNewItem(url.absoluteString, value: image);
                        self.nofityImageView(url.absoluteString);
                    } 
                }
            });
            
        }
    }
    
    func httpRequestFailedWithReason(url:NSURL, error:NSError){
        print("\(error.description) for \(url.absoluteString)");
        notifyImageViewWithError(url.absoluteString);
    }
    
    func httpRequestFailedWithStatusCode(url:NSURL, response:NSHTTPURLResponse){
        print("http response is \(response.statusCode) for \(url.absoluteString)");
        notifyImageViewWithError(url.absoluteString);
    }
    
    //MARK: CacheReleaseDelegate
    
    func keyWillBeReleasedFromCache(key:String){
        objc_sync_enter(mediaCachingMap);
        mediaCachingMap.removeValueForKey(key);
        objc_sync_exit(mediaCachingMap);
    }
    
    //MARK: DidReceiveMemoryWarningNotification
    
    dynamic func didReceiveMemoryWarning(notification:NSNotification){
        if collectionCacheManager != nil {
            collectionCacheManager!.removeAllKeyAndValuePairs();
        }
    }
    
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
}