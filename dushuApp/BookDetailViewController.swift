//
//  BookDetailViewController.swift
//  dushuApp
//
//  Created by LGZwr on 16/3/3.
//  Copyright © 2016年 maizi. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController ,BookTabBarDelegate,InputViewDelegate{

    var BookObject : AVObject?
    
    var BookTitleView : BookDetailView?
    
    var bookViewTabBar : BookTabBar!
    
    var bookTextView : UITextView!
    
    var input : InputView?
    
    var keyBoardHeight : CGFloat!
    
    var layView : UIView?
    
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
        
        self.isLove()

        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //查询是否已经点赞
    
    func isLove(){
        let query = AVQuery(className: "Love")
        query.whereKey("user", equalTo: AVUser.currentUser())
        query.whereKey("BookObject", equalTo: self.BookObject)
        query.findObjectsInBackgroundWithBlock { (results, error) -> Void in
            if results != nil && results.count != 0{
                let btn = self.bookViewTabBar?.viewWithTag(2) as? UIButton
                btn!.setImage(UIImage(named: "solidheart"), forState: .Normal)
                
            }
        }
        
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
    
    //InputViewDelegate
    
    func textViewHeightDidChange(height: CGFloat) {
        self.input?.height = height + 10
        self.input?.bottom = SCREEN_HIGHT - self.keyBoardHeight
        
    }
    
    func keyboardWillHide(inputView: InputView!, keyboardHeight: CGFloat, animationDuration duration: NSTimeInterval, animationCurve: UIViewAnimationCurve) {
        
        UIView.animateWithDuration(duration, delay: 0, options: .BeginFromCurrentState, animations: { () -> Void in
            self.input?.bottom = SCREEN_HIGHT + (self.input?.height)!
            self.layView?.alpha = 0
            }) { (finish) -> Void in
                self.layView?.hidden = true
        }
    }
    
    func keyboardWillShow(inputView: InputView!, keyboardHeight: CGFloat, animationDuration duration: NSTimeInterval, animationCurve: UIViewAnimationCurve) {
        self.keyBoardHeight = keyboardHeight
        UIView.animateWithDuration(duration, delay: 0, options: .BeginFromCurrentState, animations: { () -> Void in
            self.input?.bottom = SCREEN_HIGHT - keyboardHeight
            self.layView?.alpha = 0.2
            }) { (finsih) -> Void in
                
        }
    }
    
    func publishButtonDidClick(button: UIButton!) {
        ProgressHUD.show("")
        let object = AVObject(className: "discuss")
        object.setObject(self.input?.inputTextView?.text, forKey: "text")
        object.setObject(AVUser.currentUser(), forKey: "user")
        object.setObject(self.BookObject, forKey: "BookObject")
        object.saveInBackgroundWithBlock { (success, error) -> Void in
            if success {
                self.input?.inputTextView?.resignFirstResponder()
                ProgressHUD.showSuccess("评论成功")
                self.input?.inputTextView?.text = ""
                
            }
        }
    }
    
    
    //BookTabBarDelegate
    
    func comment(){
        if input == nil{
            input = NSBundle.mainBundle().loadNibNamed("InputView", owner: self, options: nil).last as? InputView
            input?.frame = CGRect(x: 0, y: SCREEN_HIGHT - 44, width: SCREEN_WIDTH, height: 44)
            input?.delegate = self
            self.view.addSubview(input!)
            
        }
        //设置键盘相应问题
        if layView == nil{
            layView = UIView(frame: self.view.frame)
            layView?.backgroundColor = UIColor.grayColor()
            layView?.alpha = 0
            let tap = UITapGestureRecognizer(target: self, action: Selector("tapInputView"))
            layView?.addGestureRecognizer(tap)
        }
        self.view.insertSubview(self.layView!, belowSubview: self.input!)
        layView?.hidden = false
        self.input?.inputTextView!.becomeFirstResponder()
    
    }
    
    //添加手势动作
    func tapInputView(){
        self.input?.inputTextView!.resignFirstResponder()
        
        
    }
    
    func commentControl(){
        let vc = commentViewController()
        vc.BookObject = self.BookObject
        //vc.tableview?.mj_header.beginRefreshing()
        GeneralFactory.addTitleWithTitle(vc, title1: "", title2: "关闭")
        self.presentViewController(vc, animated: true) { () -> Void in
            
        }
    
    }
    func likeBook(btn: UIButton){
        
        btn.enabled = false //点击后设置button不可点击,防止出错.
        let query = AVQuery(className: "Love")
        query.whereKey("user", equalTo: AVUser.currentUser())
        query.whereKey("BookObject", equalTo: self.BookObject)
        query.findObjectsInBackgroundWithBlock { (results, error) -> Void in
            if results != nil && results.count != 0{
                for var object in results {
                    object = object as! AVObject
                    object.deleteEventually()
                }
                btn.setImage(UIImage(named: "heart"), forState: .Normal)
                
            }else{
                let objet = AVObject(className: "Love")
                objet.setObject(AVUser.currentUser(), forKey: "user")
                objet.setObject(self.BookObject, forKey: "BookObject")
                objet.saveInBackgroundWithBlock({ (success, error) -> Void in
                    if success{
                        btn.setImage(UIImage(named: "solidheart"), forState: .Normal)
                    }else{
                        ProgressHUD.showError("操作失败")
                    }
                })
            
            }
            btn.enabled = true  //网络数据完成后设置button可以点击
        }
        
        
        
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
