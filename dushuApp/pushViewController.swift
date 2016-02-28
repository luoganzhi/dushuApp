//
//  pushViewController.swift
//  dushuApp
//
//  Created by LGZwr on 16/2/27.
//  Copyright © 2016年 maizi. All rights reserved.
//

import UIKit

class pushViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavgationBar()
        self.view.backgroundColor = UIColor.whiteColor()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setNavgationBar(){
        let navigationView = UIView(frame: CGRectMake(0,-20,SCREEN_WIDTH,65))
        navigationView.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.addSubview(navigationView)
        
        let addBookBtn = UIButton(frame: CGRectMake(20,20,SCREEN_WIDTH,45))
        addBookBtn.setImage(UIImage(named: "plus circle"), forState: UIControlState.Normal)
        addBookBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        addBookBtn.setTitle("     新建书评", forState: .Normal)
        addBookBtn.titleLabel?.font = UIFont(name: MY_FONT, size: 15)
        addBookBtn.contentHorizontalAlignment = .Left    //调整字体位置
        addBookBtn.addTarget(self, action: Selector("pushNewBook"), forControlEvents: UIControlEvents.TouchUpInside)
        navigationView.addSubview(addBookBtn)
        
        
    }
    
    func pushNewBook(){
    
        let vc = pushNewBookController()
        GeneralFactory.addTitleWithTitle(vc, title1: "关闭", title2: "发布")
        self.presentViewController(vc, animated: true) { () -> Void in
            
        }
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
