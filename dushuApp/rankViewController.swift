//
//  rankViewController.swift
//  dushuApp
//
//  Created by LGZwr on 16/2/27.
//  Copyright © 2016年 maizi. All rights reserved.
//

import UIKit

class rankViewController: UIViewController {
    
    var loginKey: Bool = true  //设置是否打开注册界面的设置

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AVUser.logOut()//登出
        if loginKey == true{
            if AVUser.currentUser() == nil{             //判断是否登陆了
                let story = UIStoryboard(name: "Login", bundle: nil)
                let stortvc = story.instantiateViewControllerWithIdentifier("Login")
            
                self.presentViewController(stortvc, animated: true) { () -> Void in
                
                }
            }
        }
        
//        self.view.backgroundColor = UIColor.whiteColor()
//        let cgpoint = CGPoint(x: self.view.center.x, y: self.view.center.y - 100)
        
//        let label = UILabel(frame: CGRectMake(0,0,300,40))
//        label.center = cgpoint
//        label.textAlignment = NSTextAlignment.Center
//        label.adjustsFontSizeToFitWidth = true
//        label.font = UIFont(name: MY_FONT, size: 40)
//        label.text = "哈哈，我是CommandZ!!!!!"
//        label.textColor = UIColor.blueColor()
//        self.view.addSubview(label)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
