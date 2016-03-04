//
//  BookDetailViewController.swift
//  dushuApp
//
//  Created by LGZwr on 16/3/3.
//  Copyright © 2016年 maizi. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController ,BookTabBarDelegate{

    var BookObject : AVObject?
    
    var BookTitleView : BookDetailView?
    
    var bookViewTabBar : BookTabBar!
    
    var bookTextView : UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.navigationController?.navigationBar.tintColor = UIColor.grayColor()
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: -60), forBarMetrics: .Default)
        
        self.initBookTitleView()
        
        bookViewTabBar = BookTabBar(frame: CGRect(x: 0, y: SCREEN_HIGHT - 40, width: SCREEN_WIDTH, height: 40))
        //bookViewTabBar.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(bookViewTabBar)
        bookViewTabBar.delegate = self
        
        bookTextView = UITextView(frame: CGRect(x: 0, y: 64 + SCREEN_HIGHT / 4, width: SCREEN_WIDTH, height: SCREEN_HIGHT - SCREEN_HIGHT / 4 - 40 - 64))
        bookTextView.text = BookObject!["description"] as? String
        bookTextView.editable = false
        
        self.view.addSubview(bookTextView)

        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //初始化BookTitleView
    func initBookTitleView(){
        self.BookTitleView = BookDetailView(frame: CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HIGHT / 4))
        self.view.addSubview(BookTitleView!)
        
        let coverFile = self.BookObject!["cover"] as? AVFile
        self.BookTitleView?.BookCover?.sd_setImageWithURL(NSURL(string: (coverFile?.url)!), placeholderImage: UIImage(named: "Cover"))
        
        BookTitleView?.BookName?.text = (BookObject!["BookName"] as! String)
        BookTitleView?.BookEditor?.text = "作者:" + (BookObject!["BookEditor"] as! String)
        
        let user = BookObject!["user"] as? AVUser
        user?.fetchInBackgroundWithBlock({ (returnUser, error) -> Void in
            self.BookTitleView?.UserName?.text = "编者:" + (returnUser as! AVUser).username
        })
        
        let date = BookObject!["createdAt"] as! NSDate
        let formate = NSDateFormatter()
        formate.dateFormat = "yy-MM-dd"
        BookTitleView?.date?.text = formate.stringFromDate(date)
        
        let scroeString = BookObject!["score"] as! String
        BookTitleView?.score?.show_star = Int(scroeString)!
        
        BookTitleView?.more?.text = "65个喜欢.5次评论.15000次浏览"
        
        
    
    }
    
    
    //delegate
    
    func comment(){
    
    }
    func commentControl(){
    
    }
    func likeBook(){
    
    }
    func sharkAction(){
    
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
