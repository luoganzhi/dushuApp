//
//  GeneralFactory.swift
//  dushuApp
//
//  Created by LGZwr on 16/2/27.
//  Copyright © 2016年 maizi. All rights reserved.
//

import UIKit

class GeneralFactory: NSObject {
    
    
    static func addTitleWithTitle(target:UIViewController,title1:String = "关闭",title2 : String = "确认"){
        
        let but1 = UIButton(frame: CGRectMake(10,20,40,20))
        but1.setTitle(title1, forState: .Normal)
        but1.setTitleColor(MAIN_RED, forState: .Normal)
        but1.contentHorizontalAlignment = .Left
        but1.titleLabel?.font = UIFont(name: MY_FONT, size: 14)
        but1.tag = 1234
        target.view.addSubview(but1)
        
        let but2 = UIButton(frame: CGRectMake(SCREEN_WIDTH - 50,20,40,20))
        but2.setTitle(title2, forState: .Normal)
        but2.setTitleColor(MAIN_RED, forState: .Normal)
        but2.contentHorizontalAlignment = .Right
        but2.titleLabel?.font = UIFont(name: MY_FONT, size: 14)
        but2.tag = 1235
        target.view.addSubview(but2)
        
        but1.addTarget(target, action: Selector("close"), forControlEvents: .TouchUpInside)
        but2.addTarget(target, action: Selector("sure"), forControlEvents: .TouchUpInside)
        
        
        
    }

}
