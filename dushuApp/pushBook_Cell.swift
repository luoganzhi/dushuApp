//
//  pushBook_Cell.swift
//  dushuApp
//
//  Created by LGZwr on 16/3/3.
//  Copyright © 2016年 maizi. All rights reserved.
//

import UIKit

class pushBook_Cell: SWTableViewCell {
    
    var BookName : UILabel?
    var Editor : UILabel?
    var More : UILabel?
    
    
    var BookCover : UIImageView?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //重写Cell
    override  init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        for view in self.contentView.subviews{
            view.removeFromSuperview()
        }
        
        
        BookName = UILabel(frame: CGRect(x: 78, y: 8, width: 242, height: 25))
        Editor = UILabel(frame: CGRect(x: 78, y: 33, width: 242, height: 25))
        More = UILabel(frame: CGRect(x: 78, y: 66, width: 242, height: 25))
        BookCover = UIImageView(frame: CGRect(x: 8, y: 9, width: 56, height: 70))
        
        BookName?.font = UIFont(name: MY_FONT, size: 15)
        Editor?.font = UIFont(name: MY_FONT, size: 15)
        More?.font = UIFont(name: MY_FONT, size: 13)
        More?.textColor = UIColor.grayColor()
        
        self.contentView.addSubview(BookName!)
        self.contentView.addSubview(Editor!)
        self.contentView.addSubview(More!)
        self.contentView.addSubview(BookCover!)
        
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
