//
//  BookTabBar.swift
//  dushuApp
//
//  Created by LGZwr on 16/3/3.
//  Copyright © 2016年 maizi. All rights reserved.
//

import UIKit

protocol BookTabBarDelegate{
    func comment()
    func commentControl()
    func likeBook(btn: UIButton)
    func sharkAction()
    
}

class BookTabBar: UIView {
    
    var barNmae = ["Pen 4","chat 3","heart","box outgoing"]
    var delegate : BookTabBarDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
        for i in 0 ..< 4 {
            let btn = UIButton(frame: CGRect(x: (frame.width / 4) * CGFloat(i), y: 0, width: frame.width / 4, height: frame.height))
            btn.setImage(UIImage(named: barNmae[i]), forState: .Normal)
            self.backgroundColor = UIColor.whiteColor()
            btn.tag = i
            btn.addTarget(self, action: #selector(BookTabBar.BookTabBarAction(_:)), forControlEvents: .TouchUpInside)
            
            self.addSubview(btn)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetRGBStrokeColor(context, 213 / 255, 213 / 255, 213 / 255, 1)
        CGContextSetLineWidth(context, 0.5)
        for i in 1 ..< 4 {
            CGContextMoveToPoint(context, rect.width / 4 * CGFloat(i), 0)
            CGContextAddLineToPoint(context, rect.width / 4 * CGFloat(i), rect.height)
        }
        CGContextMoveToPoint(context, 8, 0)
        CGContextAddLineToPoint(context, rect.width - 16, 0)
        CGContextStrokePath(context)
    }
    
    func BookTabBarAction(btn: UIButton){
        switch(btn.tag){
        case 0:
            self.delegate?.comment()
            break
        case 1:
            self.delegate?.commentControl()
            break
        case 2:
            self.delegate?.likeBook(btn)
            break
        case 3:
            self.delegate?.sharkAction()
            break
        default:
            break
        
        }
    
    }
    
    

}
