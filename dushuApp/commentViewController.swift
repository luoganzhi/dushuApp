//
//  commentViewController.swift
//  dushuApp
//
//  Created by LGZwr on 16/3/5.
//  Copyright © 2016年 maizi. All rights reserved.
//

import UIKit

class commentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,InputViewDelegate {
    
    var tableview: UITableView?
    var dataArrary = NSMutableArray()
    var BookObject: AVObject?
    var keyBoard: CGFloat?
    var input: InputView?
    var layView: UIView?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        let btn = self.view.viewWithTag(1234)
        btn?.hidden = true
        let textLabel = UILabel(frame: CGRect(x: 0, y: 20, width: SCREEN_WIDTH, height: 44))
        textLabel.text = "讨论区"
        textLabel.font = UIFont(name: MY_FONT, size: 17)
        textLabel.textAlignment = .Center
        textLabel.textColor = MAIN_RED
        self.view.addSubview(textLabel)
        
        self.tableview = UITableView(frame: CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HIGHT - 64 - 44))
        self.tableview?.registerClass(discussCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableview?.delegate = self
        self.tableview?.dataSource = self
        self.tableview?.tableFooterView = UIView()
        self.view.addSubview(self.tableview!)
        
        self.input = NSBundle.mainBundle().loadNibNamed("InputView", owner: self, options: nil).last as? InputView
        self.input!.frame = CGRect(x: 0, y: SCREEN_HIGHT - 44, width: SCREEN_WIDTH, height: 44)
        self.input!.delegate = self
        self.view.addSubview(input!)
        
        self.layView = UIView(frame: self.view.frame)
        self.layView?.backgroundColor = UIColor.grayColor()
        self.layView?.alpha = 0
        let tap = UITapGestureRecognizer(target: self, action: Selector("tapLayView"))
        self.layView?.addGestureRecognizer(tap)
        self.view.insertSubview(self.layView!, belowSubview: self.input!)
       
        
        
        
        
        self.tableview?.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "headerRefresh")
        self.tableview?.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: "footerRefresh")
         self.tableview?.mj_header.beginRefreshing()
        
        // Do any additional setup after loading the view.
    }
    
    //手势的点击
    
    func tapLayView(){
        input?.inputTextView?.resignFirstResponder()
    }
    
    
    //InputViewDelegate
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
                self.BookObject?.incrementKey("loveNumber")
                self.BookObject?.saveInBackground()


                
            }
        }

    }
    
    func textViewHeightDidChange(height: CGFloat) {
        self.input?.height = height + 10
        self.input?.bottom = SCREEN_HIGHT - self.keyBoard!
        
    }
    
    func keyboardWillShow(inputView: InputView!, keyboardHeight: CGFloat, animationDuration duration: NSTimeInterval, animationCurve: UIViewAnimationCurve) {
        self.keyBoard = keyboardHeight
        self.layView?.alpha = 0
        self.layView?.hidden = false
        //self.input?.inputTextView?.becomeFirstResponder()
        UIView.animateWithDuration(duration, delay: 0, options: .BeginFromCurrentState, animations: { () -> Void in
            self.layView?.alpha = 0
            self.input?.bottom = SCREEN_HIGHT - keyboardHeight
            }) { (finish) -> Void in
                
        }
    }
    
    func keyboardWillHide(inputView: InputView!, keyboardHeight: CGFloat, animationDuration duration: NSTimeInterval, animationCurve: UIViewAnimationCurve) {
        //self.input?.inputTextView?.resignFirstResponder()
        UIView.animateWithDuration(duration, delay: 0, options: .BeginFromCurrentState, animations: { () -> Void in
            self.layView?.alpha = 0
            self.input?.bottom = SCREEN_HIGHT
            }) { (finish) -> Void in
                self.input?.resetInputView()
                self.input?.bottom = SCREEN_HIGHT
                self.layView?.hidden = true
        }
    }
    
    
    //实现上拉和下拉方法
    
    func headerRefresh(){
        
        let query = AVQuery(className: "discuss")
        query.orderByDescending("createdAt")
        query.limit = 20
        query.skip = 0
        query.whereKey("BookObject", equalTo: BookObject)
        query.whereKey("user", equalTo: AVUser.currentUser())
        query.includeKey("BookObject")
        query.includeKey("user")
        query.findObjectsInBackgroundWithBlock { (results, error) -> Void in
            self.tableview?.mj_header.endRefreshing()
            
            if (results != nil) {
                self.dataArrary.removeAllObjects()
                self.dataArrary.addObjectsFromArray(results)
                self.tableview?.reloadData()
                
                
            }else{
                
                ProgressHUD.showError("刷新失败")
            }
        }
       
    }
    
    func footerRefresh(){
        let query = AVQuery(className: "discuss")
        query.orderByDescending("createdAt")
        query.limit = 20
        query.skip = self.dataArrary.count
        query.whereKey("BookObject", equalTo: BookObject)
        query.whereKey("user", equalTo: AVUser.currentUser())
        query.includeKey("BookObject")
        query.includeKey("user")
        query.findObjectsInBackgroundWithBlock { (results, error) -> Void in
            self.tableview?.mj_footer.endRefreshing()
            
            if (results != nil) {
                
                self.dataArrary.addObjectsFromArray(results)
                
                self.tableview?.reloadData()
                
            }else{
                
                ProgressHUD.showError("刷新失败")
            }
        }

    
    }
    
    //UITableViewDelegate,UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableview?.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as? discussCell
        //解决cell重用显示重叠问题
        if cell != nil{
            for view in (cell?.contentView.subviews)!{
                view.removeFromSuperview()
            }
        }
        
        
        cell?.initFrame()
        
        
        
        let object = self.dataArrary[indexPath.row] as? AVObject
        
        
        let user = object!["user"] as? AVUser
        cell?.nameLabel?.text = user?.username
        
        cell?.avatorImage?.image = UIImage(named: "Avatar")
        
        let date = object!["createdAt"] as? NSDate
        let formate = NSDateFormatter()
        formate.dateFormat = "yyyy-MM-dd hh:mm"
        cell?.dateLabel?.text = formate.stringFromDate(date!)
        
        let text = object!["text"] as? String
        cell?.detailLabel?.text = text
        
        
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let object = self.dataArrary[indexPath.row] as? AVObject
        let text = object!["text"] as? NSString
        let textSize = text?.boundingRectWithSize(CGSize(width: SCREEN_WIDTH - 56 - 8, height: 0), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(15)], context: nil).size
        return ((textSize?.height)! + 30 + 25)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArrary.count
    }
    
    func sure(){
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
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
