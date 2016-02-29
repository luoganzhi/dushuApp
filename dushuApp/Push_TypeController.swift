//
//  Push_TypeController.swift
//  dushuApp
//
//  Created by LGZwr on 16/2/28.
//  Copyright © 2016年 maizi. All rights reserved.
//

import UIKit

class Push_TypeController: UIViewController {
    
    var segmentControll1: AKSegmentedControl?
    var segmentControll2: AKSegmentedControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = RGB(231, g: 231, b: 231)
        
        let segmentLabel = UILabel(frame: CGRect(x: (SCREEN_WIDTH - 300) / 2, y: 20, width: 300, height: 20))
        segmentLabel.text = "请选择分类"
        segmentLabel.font = UIFont(name: MY_FONT, size: 17)//字体也要设置orz
        segmentLabel.textColor = RGB(82, g: 113, b: 131)
        segmentLabel.textAlignment = .Center
        segmentLabel.shadowOffset = CGSize(width: 0, height: 1)
        segmentLabel.shadowColor = UIColor.whiteColor()
        self.view.addSubview(segmentLabel)
        
        self.initSegment()

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
    
    //初始化segmentcontroller的方法
    func initSegment(){
        
        let buttonArray1 = [
            ["image": "ledger", "title": "文学", "font": MY_FONT],
            ["image": "drama masks", "title": "人文社科", "font": MY_FONT],
            ["image": "aperture", "title": "生活", "font": MY_FONT]
        ]
        
        self.segmentControll1 = AKSegmentedControl(frame: CGRect(x: 10, y: 60, width: SCREEN_WIDTH - 20, height: 37))
        self.segmentControll1?.initButtonWithTitleandImage(buttonArray1)
        self.view.addSubview(segmentControll1!)
        
        let buttonArray2 = [
            ["image": "atom", "title": "文学", "font": MY_FONT],
            ["image": "alien", "title": "科技", "font": MY_FONT],
            ["image": "fire element", "title": "网络流行", "font": MY_FONT]
        ]
        
        self.segmentControll2 = AKSegmentedControl(frame: CGRect(x: 10, y: 110, width: SCREEN_WIDTH - 20, height: 37))
        self.segmentControll2?.initButtonWithTitleandImage(buttonArray2)
        self.view.addSubview(segmentControll2!)

        self.segmentControll1?.addTarget(self, action: Selector("segementControllerAction:"), forControlEvents: .ValueChanged)
        self.segmentControll2?.addTarget(self, action: Selector("segementControllerAction:"), forControlEvents: .ValueChanged)
    }
    
    
    //设置segement的点击动作
    
    func segementControllerAction(segment: AKSegmentedControl){
        let index = segmentControll1?.selectedIndexes.firstIndex
        if segment == segmentControll1{
            segmentControll2?.setSelectedIndex(3)//取消第二个的选中状态
        }else{
            segmentControll1?.setSelectedIndex(3)
        }
    }
    
    
    
}
