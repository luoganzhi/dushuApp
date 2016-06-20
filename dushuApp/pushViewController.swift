//
//  pushViewController.swift
//  dushuApp
//
//  Created by LGZwr on 16/2/27.
//  Copyright © 2016年 maizi. All rights reserved.
//

import UIKit

class pushViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,SWTableViewCellDelegate {

    var dataArrary = NSMutableArray()
    var tableView : UITableView?
    var navigationView : UIView!
    var swipeIndexPath: NSIndexPath? // 记录cell的编辑状态
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavgationBar()
        self.view.backgroundColor = UIColor.whiteColor()
        
        tableView = UITableView(frame: self.view.frame)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.registerClass(pushBook_Cell.classForCoder(), forCellReuseIdentifier: "cell")
        // tableView?.tableFooterView = UIView()
        tableView?.separatorStyle = .None // 去除Cell的线条
        self.view.addSubview(tableView!)
        
        
        tableView?.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(pushViewController.headerRefresh))
        tableView?.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(pushViewController.footerRefresh))
        tableView?.mj_header.beginRefreshing()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setNavgationBar(){
        navigationView = UIView(frame: CGRectMake(0,-20,SCREEN_WIDTH,65))
        navigationView.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.addSubview(navigationView)
        
        let addBookBtn = UIButton(frame: CGRectMake(20,20,SCREEN_WIDTH,45))
        addBookBtn.setImage(UIImage(named: "plus circle"), forState: UIControlState.Normal)
        addBookBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        addBookBtn.setTitle("     新建书评", forState: .Normal)
        addBookBtn.titleLabel?.font = UIFont(name: MY_FONT, size: 15)
        addBookBtn.contentHorizontalAlignment = .Left    //调整字体位置
        addBookBtn.addTarget(self, action: #selector(pushViewController.pushNewBook), forControlEvents: UIControlEvents.TouchUpInside)
        navigationView.addSubview(addBookBtn)
        
        
    }
    override func viewWillAppear(animated: Bool) {
        navigationView.hidden = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        navigationView.hidden = true
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
        
        cell?.rightUtilityButtons = self.returnRightButton()
        cell?.delegate = self
        
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
    
    func returnRightButton()->[AnyObject]{
        let btn1 = UIButton(frame: CGRect(x: 0, y: 0, width: 88, height: 88))
        btn1.backgroundColor = UIColor.orangeColor()
        btn1.setTitle("编辑", forState: .Normal)
        
        let btn2 = UIButton(frame: CGRect(x: 0, y: 0, width: 88, height: 88))
        btn2.backgroundColor = UIColor.redColor()
        btn2.setTitle("删除", forState: .Normal)
        
        return [btn1,btn2]
    }
    
    //SWTableViewCellDelegate
    
    func swipeableTableViewCell(cell: SWTableViewCell!, scrollingToState state: SWCellState) {
        let indexPath = self.tableView?.indexPathForCell(cell)
        if state == .CellStateRight{
            if swipeIndexPath != nil && swipeIndexPath?.row != indexPath?.row{
                let swipeCell = self.tableView?.cellForRowAtIndexPath(self.swipeIndexPath!) as? pushBook_Cell
                swipeCell?.hideUtilityButtonsAnimated(true)
            }
            self.swipeIndexPath = indexPath
        }else if state == .CellStateCenter{
            self.swipeIndexPath = nil
        }
        
    }
    
    func swipeableTableViewCell(cell: SWTableViewCell!, didTriggerRightUtilityButtonWithIndex index: Int) {
        cell.hideUtilityButtonsAnimated(true)
        let indexPath = self.tableView?.indexPathForCell(cell)
        let object = self.dataArrary[indexPath!.row] as? AVObject
        if index == 0{
            let vc = pushNewBookController()
            GeneralFactory.addTitleWithTitle(vc, title1: "关闭", title2: "修改")
            vc.BookObject = object
            vc.fixType = "fix"
            vc.fixBook()
            self.presentViewController(vc, animated: true, completion: { () -> Void in
                
            })
        }else{
            ProgressHUD.show("")
            
            let discussQuery = AVQuery(className: "discuss")
            discussQuery.whereKey("BookObject", equalTo: object)
            discussQuery.findObjectsInBackgroundWithBlock({ (results, error) -> Void in
                for Book in results{
                    let BookObject = Book as? AVObject
                    BookObject?.deleteInBackground()
                }
            })
            
            let loveQuery = AVQuery(className: "Love")
            loveQuery.whereKey("BookObject", equalTo: object)
            loveQuery.findObjectsInBackgroundWithBlock({ (results, error) -> Void in
                for Book in results{
                    let BookObject = Book as? AVObject
                    BookObject?.deleteInBackground()
                }
            })
            
            object?.deleteInBackgroundWithBlock({ (success, error) -> Void in
                if success {
                    ProgressHUD.showSuccess("删除成功")
                    self.dataArrary.removeObjectAtIndex((indexPath?.row)!)
                    self.tableView?.reloadData()
                }
            })
        }
        
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView?.deselectRowAtIndexPath(indexPath, animated: true)
        let vc = BookDetailViewController()
        vc.BookObject = self.dataArrary[indexPath.row] as? AVObject
        vc.hidesBottomBarWhenPushed = true //push后会隐藏下面的tablebar
        self.navigationController?.pushViewController(vc, animated: true)
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
