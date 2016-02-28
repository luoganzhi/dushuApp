//
//  Push_TypeController.swift
//  dushuApp
//
//  Created by LGZwr on 16/2/28.
//  Copyright © 2016年 maizi. All rights reserved.
//

import UIKit

class Push_TypeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func sure(){
        
    }
    
    func close(){
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }    
    }
}
