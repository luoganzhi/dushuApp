//
//  pushViewController.swift
//  dushuApp
//
//  Created by LGZwr on 16/2/27.
//  Copyright © 2016年 maizi. All rights reserved.
//

import UIKit

class pushViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var dataArrary = NSMutableArray()
    var tableView : UITableView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavgationBar()
        self.view.backgroundColor = UIColor.whiteColor()
        
        tableView = UITableView(frame: self.view.frame)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.registerClass(pushBook_Cell.classForCoder(), forCellReuseIdentifier: "cell")
        //tableView?.tableFooterView = UIView()
        tableView?.separatorStyle = .None//去除Cell的线条
        self.view.addSubview(tableView!)
        
        
        tableView?.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: Selector("headerRefresh"))
        tableView?.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: "footerRefresh")
        tableView?.mj_header.beginRefreshing()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setNavgationBar(){
        let navigationView = UIView(frame: CGRectMake(0,-20,SCREEN_WIDTH,65))
        navigationView.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.addSubview(navigationView)
        
        let addBookBtn = UIButton(frame: CGRectMake(20,20,SCREEN_WIDTH,45))
        addBookBtn.setImage(UIImage(named: "plus circle"), forState: UIControlState.Normal)
        addBookBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        addBookBtn.setTitle("     新建书评", forState: .Normal)
        addBookBtn.titleLabel?.font = UIFont(name: MY_FONT, size: 15)
        addBookBtn.contentHorizontalAlignment = .Left    //调整字体位置
        addBookBtn.addTarget(self, action: Selector("pushNewBook"), forControlEvents: UIControlEvents.TouchUpInside)
        navigationView.addSubview(addBookBtn)
        
        
    }
    
    func pushNewBook(){
    
        let vc = pushNewBookController()
        GeneralFactory.addTitleWithTitle(vc, title1: "关闭", title2: "发布")
        self.presentViewController(vc, animated: true) { () -> Void in
            
        }
    }
    //实现 Delegate 和 Datasource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView?.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as? pushBook_Cell
        
        let dict = self.dataArrary[indexPath.row] as? AVObject
        cell?.BookName?.text = (dict!["BookName"] as? String)! + (dict!["title"] as? String)!
        cell?.Editor?.text = "作者：" + (dict!["BookEditor"] as? String)!
        
        let date = dict!["createdAt"] as? NSDate
        let formate = NSDateFormatter()
        formate.dateFormat = "yyyy-MM-dd hh:mm"
        cell?.More?.text = formate.stringFromDate(date!)
        
        let coverFile = dict!["cover"] as? AVFile
        cell?.BookCover?.sd_setImageWithURL(NSURL(string: (coverFile?.url)!), placeholderImage: UIImage(named: "Cover"))
        
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArrary.count
    }

    //实现刷新的方法
    func headerRefresh(){
        let query = AVQuery(className: "Book")
        query.orderByDescending("createdAt")
        
        query.limit = 20
        query.skip = 0
        query.whereKey("user", equalTo: AVUser.currentUser())
        query.findObjectsInBackgroundWithBlock { (result, error) -> Void in
            self.tableView?.mj_header.endRefreshing() //停止刷新
            self.dataArrary.removeAllObjects()
            self.dataArrary.addObjectsFromArray(result)
            self.tableView?.reloadData()
        }
    
    }
    
    func footerRefresh(){
        let query = AVQuery(className: "Book")
        query.orderByDescending("createdAt")
        query.limit = 20
        query.skip = self.dataArrary.count
        query.whereKey("user", equalTo: AVUser.currentUser())
        query.findObjectsInBackgroundWithBlock { (result, error) -> Void in
            self.tableView?.mj_footer.endRefreshing() //停止刷新
            self.dataArrary.addObjectsFromArray(result)
            self.tableView?.reloadData()
        }

    
    }
}
