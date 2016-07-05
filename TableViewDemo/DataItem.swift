//
//  DataItem.swift
//  TableViewDemo
//
//  Created by Nathan Bahl on 7/4/16.
//  Copyright © 2016 Nathan Bahl. All rights reserved.
//

import UIKit

class DataItem {
    
    var title: String
    var subtitle: String
    var image: UIImage?
    
    init(title:String, subtitle:String, imageName:String?){
        self.title = title
        self.subtitle = subtitle
        
        if let imageName = imageName{
            
            if let img = UIImage(named: imageName){
                image = img
                
            }
            
        }
        
    }
    
    
}
