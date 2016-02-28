//
//  Push_TitleController.swift
//  dushuApp
//
//  Created by LGZwr on 16/2/28.
//  Copyright © 2016年 maizi. All rights reserved.
//

import UIKit

typealias Push_TitleCallBack = (Title: String) -> Void

class Push_TitleController: UIViewController {
    
    var textFiled : UITextField?
    
    var callBack : Push_TitleCallBack?
    /*
    实现回调的方法
    1: 闭包block
    2: delegate
    3: 通知NSNotifection
    
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.textFiled = UITextField(frame: CGRect(x: 15, y: 60, width: SCREEN_WIDTH - 30, height: 30))
        self.textFiled?.borderStyle = .RoundedRect
        self.textFiled?.placeholder = "书评标题"
        self.textFiled?.font = UIFont(name: MY_FONT, size: 14)
        self.textFiled?.becomeFirstResponder()
        self.view.addSubview(self.textFiled!)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sure(){
        self.callBack?(Title: self.textFiled!.text!)
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    func close(){
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }

}
