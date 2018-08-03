//
//  MissingPilgrimage.swift
//  HajHack
//
//  Created by Dalal on 8/1/18.
//  Copyright © 2018 Dalal. All rights reserved.
//

import Foundation
import UIKit

struct MissingPilgrimage{
    var name:String?
    var period:String?
    var image:UIImage?
    var id:String?
    var informationHistory:[MessageUpdate]?
}


struct  PMessage{
    var message:String?
    var name:String?
    var image:UIImage?
    var read:Bool?
}

struct  MessageUpdate{
    var name:String?
    var date:String?
    var image:UIImage?
    var message:String?
    var time:String?
    
}
