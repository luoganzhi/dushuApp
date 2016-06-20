//
//  BookTitleView.swift
//  dushuApp
//
//  Created by LGZwr on 16/2/27.
//  Copyright © 2016年 maizi. All rights reserved.
//

import UIKit

//可选 delegate协议
@objc protocol BookTitleDelegate{
    optional func chioceCover()
    
}



class BookTitleView: UIView {

    var BookOver : UIButton?
    
    var BookName : JVFloatLabeledTextField?
    
    var BookEditor : JVFloatLabeledTextField?
    
    weak var delegate : BookTitleDelegate? //申明协议弱引用,不然内存泄露
    
    override init(frame : CGRect){
        
        super.init(frame: frame)
        
        //设置弹出界面的界面
        self.BookOver = UIButton(frame: CGRectMake(8,0,110,141))//封面比例110，141
        self.BookOver?.setImage(UIImage(named: "Cover"), forState: .Normal)
        self.addSubview(self.BookOver!)
        self.BookOver?.addTarget(self, action: #selector(BookTitleDelegate.chioceCover), forControlEvents: .TouchUpInside)
        
        self.BookName = JVFloatLabeledTextField(frame: CGRectMake(128,8+40,SCREEN_WIDTH-128-15,30))
        self.BookEditor = JVFloatLabeledTextField(frame: CGRectMake(128,8+40+30+30,SCREEN_WIDTH-128-15,30))
        
        self.BookName?.placeholder = "书名"
        self.BookEditor?.placeholder = "作者"
        
        //设置浮动标签
        self.BookName?.floatingLabelFont = UIFont(name: MY_FONT, size: 14)
        self.BookEditor?.floatingLabelFont = UIFont(name: MY_FONT, size: 14)
        
        //设置placeholder
        self.BookName?.font = UIFont(name: MY_FONT, size: 14)
        self.BookEditor?.font = UIFont(name: MY_FONT, size: 14)

        
        self.addSubview(self.BookName!)
        self.addSubview(self.BookEditor!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not implemeted")
    }
    
    
    func chioceCover(){
        self.delegate?.chioceCover?()
        
    }
}
