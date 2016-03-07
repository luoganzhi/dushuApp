//
//  discussCell.swift
//  dushuApp
//
//  Created by LGZwr on 16/3/5.
//  Copyright © 2016年 maizi. All rights reserved.
//

import UIKit

class discussCell: UITableViewCell {
    
    var avatorImage: UIImageView?
    
    var nameLabel: UILabel?
    
    var detailLabel: UILabel?
    
    var dateLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        for view in self.contentView.subviews {
//            view.removeFromSuperview()
//        }
        
        
    }
    func initFrame(){
        avatorImage = UIImageView(frame: CGRect(x: 8,y: 8,width: 40,height: 40))
        
        avatorImage?.layer.cornerRadius = 20
        avatorImage?.layer.masksToBounds = true
        self.contentView.addSubview(avatorImage!)
        
        nameLabel = UILabel(frame: CGRect(x: 56, y: 8, width: SCREEN_WIDTH - 56 - 8, height: 15))
        nameLabel?.font = UIFont(name: MY_FONT, size: 13)
        self.contentView.addSubview(nameLabel!)
        
        dateLabel = UILabel(frame: CGRect(x: 56, y: self.frame.height - 10 - 8, width: SCREEN_WIDTH - 56 - 8, height: 10))
        dateLabel?.font = UIFont(name: MY_FONT, size: 13)
        dateLabel?.textColor = UIColor.grayColor()
        self.contentView.addSubview(dateLabel!)
//        if detailLabel == nil{
        detailLabel = UILabel(frame: CGRect(x: 56, y: 30, width: SCREEN_WIDTH - 56 - 8, height: self.frame.height - 10 - 13 - 16))
        detailLabel?.font = UIFont(name: MY_FONT, size: 13)
        self.contentView.addSubview(detailLabel!)
//        }else{
//            self.removeFromSuperview()
//            detailLabel = UILabel(frame: CGRect(x: 56, y: 30, width: SCREEN_WIDTH - 56 - 8, height: self.frame.height - 10 - 13 - 16))
//            detailLabel?.font = UIFont(name: MY_FONT, size: 13)
//            self.contentView.addSubview(detailLabel!)
//            
//        }

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
