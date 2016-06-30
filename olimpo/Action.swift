//
//  ActionBuilder.swift
//  olimpo
//
//  Created by Cem Türker on 23/04/16.
//  Copyright © 2016 Cem Türker. All rights reserved.
//

import Foundation
import UIKit

class Action {
    var url:String?;
    var placeHolder:UIImage?;
    var error:UIImage?;
    var imageViewContentMode:UIViewContentMode?;
    var newSize:CGSize?;
    init(){
        
    }
    
    func applyContentModeTo(imageView:UIImageView) {
        if imageViewContentMode != nil {
            imageView.contentMode = imageViewContentMode!;
        }
    }
}