//
//  Utils.swift
//  olimpo
//
//  Created by Argela on 30/06/16.
//  Copyright © 2016 olim. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    static func resizeImage(image:UIImage,newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0);
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height));
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    }
}
