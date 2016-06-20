//
//  loginViewController.swift
//  dushuApp
//
//  Created by LGZwr on 16/2/29.
//  Copyright © 2016年 maizi. All rights reserved.
//

import UIKit

class loginViewController: UIViewController {

    @IBOutlet var userName: UITextField!
    @IBOutlet var passWord: UITextField!
    
    @IBOutlet var topLayout: NSLayoutConstraint!
    
    @IBAction func login(sender: AnyObject) {
        
        AVUser.logInWithUsernameInBackground(self.userName.text, password: self.passWord.text) { (user, error) -> Void in
            if error == nil{
                self.dismissViewControllerAnimated(true, completion: { () -> Void in
                    
                })
            }else{
                if error.code == 210{
                    ProgressHUD.showError("用户名或密码错误")
                }else if error.code == 211{
                    ProgressHUD.showError("不存在该用户")
                }else if error.code == 216{
                    ProgressHUD.showError("未验证邮箱")
                }else if error.code == 1{
                    ProgressHUD.showError("操作频繁")
                }else{
                    ProgressHUD.showError("登陆失败")
                }
                
            
            }
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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //注册键盘出现和消失
    
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
