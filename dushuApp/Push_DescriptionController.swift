//
//  Push_DescriptionController.swift
//  dushuApp
//
//  Created by LGZwr on 16/2/28.
//  Copyright © 2016年 maizi. All rights reserved.
//

import UIKit

typealias Push_DescriptionControllerBlock = (description: String) -> Void

class Push_DescriptionController: UIViewController {
    
    var textView : JVFloatLabeledTextView?
    var callBakc : Push_DescriptionControllerBlock?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.textView = JVFloatLabeledTextView(frame: CGRect(x: 8, y: 58, width: SCREEN_WIDTH - 16, height: SCREEN_HIGHT - 58 - 8))
        
        self.textView?.placeholder = "    在这里填写详细的评价,介绍~~~~"
        self.textView?.font = UIFont(name: MY_FONT, size: 17)
        self.textView?.tintColor = UIColor.redColor()
        self.textView?.becomeFirstResponder()
        
        
        XKeyBoard.registerKeyBoardHide(self)//注册键盘的消失
        XKeyBoard.registerKeyBoardShow(self)//注册键盘的出现
        
        self.view.addSubview(self.textView!)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func sure(){
        
        callBakc!(description: (textView?.text)!)
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    func close(){
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    
    //键盘遮挡
    
    func keyboardWillHideNotification(notification:NSNotification){
        textView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
    }
    
    func keyboardWillShowNotification(notification:NSNotification){
        let rect = XKeyBoard.returnKeyBoardWindow(notification)
        textView?.contentInset = UIEdgeInsetsMake(0, 0, rect.size.height, 0)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
