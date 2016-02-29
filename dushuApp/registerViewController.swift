//
//  registerViewController.swift
//  dushuApp
//
//  Created by LGZwr on 16/2/29.
//  Copyright © 2016年 maizi. All rights reserved.
//

import UIKit

class registerViewController: UIViewController {

    @IBOutlet var userName: UITextField!
    @IBOutlet var passWord: UITextField!
    @IBOutlet var email: UITextField!
    
    
    @IBAction func register(sender: AnyObject) {
    }
    
    @IBAction func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
