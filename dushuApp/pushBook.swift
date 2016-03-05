//
//  pushBook.swift
//  dushuApp
//
//  Created by LGZwr on 16/3/1.
//  Copyright © 2016年 maizi. All rights reserved.
//

import UIKit

class pushBook: NSObject {
    
    //定义一个上传的类方法
    static func pushBookInBackground(dict: NSDictionary){
        
        
        
        let obj = AVObject(className: "Book")
        obj.setObject(dict["BookName"], forKey: "BookName")
        obj.setObject(dict["BookEditor"], forKey: "BookEditor")
        //obj.setObject(obj["BookCover"], forKey: "BookCover")
        obj.setObject(dict["title"], forKey: "title")
        obj.setObject(dict["score"], forKey: "score")
        obj.setObject(dict["type"], forKey: "type")
        obj.setObject(dict["detailType"], forKey: "detailType")
        obj.setObject(dict["description"], forKey: "description")
        obj.setObject(AVUser.currentUser(), forKey: "user")
        
        let image = dict["BookCover"] as? UIImage
        let coverFile = AVFile(data: UIImagePNGRepresentation(image!))
        coverFile.saveInBackgroundWithBlock { (success, error) -> Void in
            
            if success{
                obj.setObject(coverFile, forKey: "cover")
                print("hah")
                obj.saveInBackgroundWithBlock({ (success, error) -> Void in
                    if success{
                        NSNotificationCenter.defaultCenter().postNotificationName("pushBookNotification", object: nil, userInfo: ["success": "true"])
                        
                    }else {
                        NSNotificationCenter.defaultCenter().postNotificationName("pushBookNotification", object: nil, userInfo: ["success": "false"])
                    }
                })
            }else{
                    NSNotificationCenter.defaultCenter().postNotificationName("pushBookNotification", object: nil, userInfo: ["success": "false"])
                
            }
        }
    }

}

/*
"BookName": self.BookTitle?.BookName,
"BookEditor": self.BookTitle?.BookEditor,
"BookCover": self.BookTitle?.BookOver?.currentImage,
"title": self.Book_Title,
"score": self.score?.show_star,
"type": self.type,
"detailType": self.detailType,
"description": self.Book_Description
*/