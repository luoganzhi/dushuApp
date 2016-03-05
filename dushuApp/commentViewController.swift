//
//  commentViewController.swift
//  dushuApp
//
//  Created by LGZwr on 16/3/5.
//  Copyright © 2016年 maizi. All rights reserved.
//

import UIKit

class commentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableview: UITableView?
    var dataArrary = NSMutableArray()
    var BookObject: AVObject?
    
    
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
       
        
        
        
        
        self.tableview?.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "headerRefresh")
        self.tableview?.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: "footerRefresh")
         self.tableview?.mj_header.beginRefreshing()
        
        // Do any additional setup after loading the view.
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
