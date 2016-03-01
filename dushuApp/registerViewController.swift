//
//  registerViewController.swift
//  dushuApp
//
//  Created by LGZwr on 16/2/29.
//  Copyright © 2016年 maizi. All rights reserved.
//

import UIKit

class registerViewController: UIViewController {

    @IBOutlet var topLayout: NSLayoutConstraint!
    @IBOutlet var userName: UITextField!
    @IBOutlet var passWord: UITextField!
    @IBOutlet var email: UITextField!
    
    
    @IBAction func register(sender: AnyObject) {
        let user = AVUser()
        user.username = self.userName.text
        user.password = self.passWord.text
        user.email = self.email.text
        
        //实例化user  然后进行注册
        
        user.signUpInBackgroundWithBlock { (success, error) -> Void in
            if success{
                ProgressHUD.showSuccess("注册成功")
                self.dismissViewControllerAnimated(true, completion: { () -> Void in
                    
                })
            }else{
                if error.code == 125{
                    ProgressHUD.showError("邮箱错误")
                }else if error.code == 203{
                    ProgressHUD.showError("该邮箱已注册")
                }else if error.code == 202{
                    ProgressHUD.showError("用户名已存在")
                }else{
                    ProgressHUD.showError("注册失败")
                }
            
            }
        }
        
        
    }
    
    @IBAction func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        XKeyBoard.registerKeyBoardHide(self)
        XKeyBoard.registerKeyBoardShow(self)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWillShowNotification(notification:NSNotification){
        UIView.animateWithDuration(0.3) { () -> Void in
            self.topLayout.constant = -100
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardWillHideNotification(notification:NSNotification){
        UIView.animateWithDuration(0.3) { () -> Void in
            self.topLayout.constant = 8
            self.view.layoutIfNeeded()
            
        }
    }

    

   
}
