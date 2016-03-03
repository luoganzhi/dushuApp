//
//  BookDetailView.swift
//  dushuApp
//
//  Created by LGZwr on 16/3/3.
//  Copyright © 2016年 maizi. All rights reserved.
//

import UIKit

class BookDetailView: UIView {
    
    var VIEW_WIDTH: CGFloat!
    var VIEW_HIGHT: CGFloat!
    
    var BookName: UILabel?
    var BookEditor: UILabel?
    var UserName: UILabel?
    var date: UILabel?
    var more: UILabel?
    var score: LDXScore?
    var BookCover: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        VIEW_WIDTH = frame.width
        VIEW_HIGHT = frame.height
        self.backgroundColor = UIColor.whiteColor()
        
        BookCover = UIImageView(frame: CGRect(x: 8, y: 8, width: (VIEW_HIGHT - 16) / 1.273, height: VIEW_HIGHT - 16))
        self.addSubview(BookCover!)
        
        BookName = UILabel(frame: CGRect(x: (VIEW_HIGHT - 16) / 1.273 + 16, y: 8, width: VIEW_WIDTH - (VIEW_HIGHT - 16) / 1.273 - 16, height: VIEW_HIGHT / 4))
        BookName?.font = UIFont(name: MY_FONT, size: 18)
        self.addSubview(BookName!)
        
        BookEditor = UILabel(frame: CGRect(x: (VIEW_HIGHT - 16) / 1.273 + 16, y: 8 + VIEW_HIGHT / 4, width: VIEW_WIDTH - (VIEW_HIGHT - 16) / 1.273 - 16, height: VIEW_HIGHT / 4))
        BookEditor?.font = UIFont(name: MY_FONT, size: 18)
        self.addSubview(BookEditor!)
        
        UserName = UILabel(frame: CGRect(x: (VIEW_HIGHT - 16) / 1.273 + 16, y: 24 + VIEW_HIGHT / 4 + VIEW_HIGHT / 6, width: VIEW_WIDTH - (VIEW_HIGHT - 16) / 1.273 - 16, height: VIEW_HIGHT / 6))
        UserName?.font = UIFont(name: MY_FONT, size: 13)
        UserName?.textColor = RGB(35, g: 87, b: 139)
        self.addSubview(UserName!)
        
        date = UILabel(frame: CGRect(x: (VIEW_HIGHT - 16) / 1.273 + 16, y: 16 + VIEW_HIGHT / 4 + VIEW_HIGHT / 6 * 2, width: 80, height: VIEW_HIGHT / 6))
        date?.font = UIFont(name: MY_FONT, size: 13)
        date?.textColor = UIColor.grayColor()
        self.addSubview(date!)
        
        score = LDXScore(frame: CGRect(x: (VIEW_HIGHT - 16) / 1.273 + 16 + 80, y: 16 + VIEW_HIGHT / 4 + VIEW_HIGHT / 6 * 2, width: 80, height: VIEW_HIGHT / 6))
       
        score?.isSelect = false
        score?.normalImg = UIImage(named: "btn_star_evaluation_normal")
        score?.highlightImg = UIImage(named: "btn_star_evaluation_press")
        score?.max_star = 5
        score?.show_score = 5   //?
        self.addSubview(score!)
        
        more = UILabel(frame: CGRect(x: (VIEW_HIGHT - 16) / 1.273 + 16, y: 8 + VIEW_HIGHT / 4 + VIEW_HIGHT / 6 * 3, width: VIEW_WIDTH - (VIEW_HIGHT - 16) / 1.273 - 16, height: VIEW_HIGHT / 6))
        more?.font = UIFont(name: MY_FONT, size: 13)
        more?.textColor = UIColor.grayColor()
        self.addSubview(more!)
        
        
        
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    //重写线条样式
    override func drawRect(rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 0.5)
        CGContextSetRGBFillColor(context, 231 / 255, 231 / 255, 231 / 255, 1)
        CGContextMoveToPoint(context, 8, VIEW_HIGHT - 2)
        CGContextAddLineToPoint(context, VIEW_WIDTH - 8, VIEW_HIGHT - 2)
        CGContextStrokePath(context)
        
    }
    

}
