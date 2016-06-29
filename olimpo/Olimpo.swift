//
//  Olimpo.swift
//  olimpo
//
//  Created by Cem Türker on 26/04/16.
//  Copyright © 2016 Cem Türker. All rights reserved.
//

import Foundation
import UIKit


class Olimpo  {
    private let networkManager:NetworkManager;
    private let mediaController:MediaController;
    private static let sharedInstance:Olimpo = Olimpo();
    static var MAX_CAPACITY_VALUE:Int = 30; //shouldnt be changed after calling load method...
    private init() {
        mediaController = MediaController();
        networkManager = NetworkManager(networkCallback: mediaController);
    }
    //Creates new action with imageview
    private func callNewAction(action:Action, imageView:UIImageView){
        if action.url != nil {
            if mediaController.isCacheContains(action){
                mediaController.updateActionData(action);
                mediaController.changeImageInImageView(imageView, key: action.url!);
            }else{
                if let url:NSURL = NSURL(string: action.url!) {
                    networkManager.downloadDataFromGivenUrl(url);
                    mediaController.addNewAction(action,imageView: imageView);
                }
            }
        }
    }
    
    static func load(url:String) -> ActionBuilder {
        let actionBuilder:ActionBuilder = ActionBuilder().build();
        actionBuilder.url(url);
        return actionBuilder;
    }
    
    class ActionBuilder {
        private let action:Action;
        init(){
            action = Action();
        }
        func into(imageView:UIImageView) -> Void {
            Olimpo.sharedInstance.callNewAction(action,imageView:imageView);
        }
        
        func placeHolder(placeHolder:UIImage) -> ActionBuilder {
            action.placeHolder = placeHolder;
            return self;
        }
        
        func error(error:UIImage) -> ActionBuilder {
            action.error = error;
            return self;
        }
        
        func contentMode(mode:UIViewContentMode) -> ActionBuilder {
            action.imageViewContentMode = mode;
            return self;
        }
        
        private func url(url:String) -> ActionBuilder {
            action.url = url;
            return self;
        }
        
        private func build() -> ActionBuilder {
            return self;
        }
    }
    
}


