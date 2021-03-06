//
//  pushNewBookController.swift
//  dushuApp
//
//  Created by LGZwr on 16/2/27.
//  Copyright © 2016年 maizi. All rights reserved.
//

import UIKit

class pushNewBookController: UIViewController,BookTitleDelegate ,PhotoPickerDelegate,VPImageCropperDelegate,UITableViewDelegate,UITableViewDataSource{
    
    var BookTitle : BookTitleView?
    var tableView : UITableView?
    var titleArray : Array<String> = []
    var Book_Title = ""
    var score : LDXScore?
    //是否显示星星
    var showScore = false
    
    //定义用与接收type的变量
    var type = "文学"
    var detailType = "文学"
    
    //定义一个接收description的变量
    var Book_Description = ""
    
    //点击编辑按钮
    var fixType: String?
    var BookObject: AVObject?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        
        self.BookTitle = BookTitleView(frame: CGRectMake(0,40,SCREEN_WIDTH,160))
        self.BookTitle?.delegate = self
        self.view.addSubview(self.BookTitle!)
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 40 + 160 , width: SCREEN_WIDTH, height: SCREEN_HIGHT - 200), style: .Grouped)
        //使没有内容的cell不产生线
        self.tableView?.separatorStyle = .None
        //self.tableView?.tableFooterView = UIView()
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        //self.tableView?.backgroundColor = UIColor.redColor()
        self.tableView?.backgroundColor = UIColor(colorLiteralRed: 250 / 255, green: 250 / 255, blue: 250 / 255, alpha: 1)
        self.view.addSubview(tableView!)
        
        self.titleArray = ["标题","评分","分类","书评"]
        
        
        //对评分初始化
        self.score = LDXScore(frame: CGRect(x: 100, y: 10, width: 100, height: 22))
        self.score?.isSelect = true
        self.score?.normalImg = UIImage(named: "btn_star_evaluation_normal")
        self.score?.highlightImg = UIImage(named: "btn_star_evaluation_press")
        self.score?.max_star = 5
        self.score?.show_score = 5
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(pushNewBookController.pushBookNotification(_:)), name: "pushBookNotification", object: nil)
        
    }
    
    //编辑
    func fixBook(){
        if fixType == "fix"{
            self.BookTitle?.BookName?.text = self.BookObject!["BookName"] as? String
            self.BookTitle?.BookEditor?.text = self.BookObject!["BookEditor"] as? String
            let coverFile = self.BookObject!["cover"] as? AVFile
            coverFile?.getDataInBackgroundWithBlock({ (data, error) -> Void in
                if data != nil{
                self.BookTitle?.BookOver?.setImage(UIImage(data: data), forState: .Normal)
                }
            })
            
            self.Book_Title = (self.BookObject!["title"] as? String)!
            self.type = (self.BookObject!["type"] as? String)!
            self.detailType = (self.BookObject!["detailType"] as? String)!
            self.score?.show_star = Int(self.BookObject!["score"] as! String)!
            if self.Book_Description != ""{
                self.titleArray.append("")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit
    {
        print("没有发生内存泄露")//反初始化,清除所有通知
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
    }
    
    
    
    //pushBookNotification方法的实现
    
    func pushBookNotification(notification: NSNotification){
        let dict = notification.userInfo
        if String((dict!["success"])!) == "true"{
            if self.fixType == "fix"{
                ProgressHUD.showSuccess("修改成功")
                
            }else{
                ProgressHUD.showSuccess("上传成功")

            }
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                
            })
        }else{
            ProgressHUD.showError("上传失败")
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                
            })
        }
        
    }
    
    //检查是否内存泄露
    /*deinit
    {
        print("没有发生内存泄露")
        
    }*/
    
    
    /**BookTitleDelegate*/
    //代理
    func chioceCover() {
        let vc = PhotoPickerViewController()
        vc.delegate = self
        self.presentViewController(vc, animated: true) { () -> Void in
            
        }
    }
    
    //photoPickerDelegate
    
    func getImageFromPicker(image: UIImage) {
        //self.BookTitle?.BookOver?.setImage(image, forState: .Normal)
        //将获得的图片剪裁
        let CoreVC = VPImageCropperViewController(image: image, cropFrame: CGRect(x: 0,y: 100,width: SCREEN_WIDTH,height: SCREEN_WIDTH * 1.273), limitScaleRatio: 3)
        CoreVC.delegate = self
        self.presentViewController(CoreVC, animated: true) { () -> Void in
            
        }
    }
    
    
    //设置GeneralFactory的两个按钮点击实现的方法
    func close(){
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    func sure(){
        
        ProgressHUD.show("")//优化上传显示
        let dict = [
            "BookName": (self.BookTitle?.BookName?.text)!,
            "BookEditor": (self.BookTitle?.BookEditor?.text)!,
            "BookCover": (self.BookTitle?.BookOver?.currentImage)!,
            "title": self.Book_Title,
            "score": String((self.score?.show_star)!),
            "type": self.type,
            "detailType": self.detailType,
            "description": self.Book_Description
            ]
        if fixType == "fix"{
            pushBook.pushBookInBackground(dict, obj: self.BookObject!)
            
            
        }else{
            let obj = AVObject(className: "Book")
            pushBook.pushBookInBackground(dict, obj: obj)
        }
    }
    
    //实现VPImageCropperDelegate代理
    func imageCropperDidCancel(cropperViewController: VPImageCropperViewController!) {
        cropperViewController.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }

    func imageCropper(cropperViewController: VPImageCropperViewController!, didFinished editedImage: UIImage!) {
        self.BookTitle?.BookOver?.setImage(editedImage, forState: .Normal)
        cropperViewController.dismissViewControllerAnimated(true){() -> Void in
            
        }
    }
    
    //实现tableviewdelegate && tableviewdatasource 必须要实现的
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "cell")
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        
        //第二行没有箭头标志
        if indexPath.row != 1{
            cell.accessoryType = .DisclosureIndicator
        }
        
        cell.textLabel?.text = self.titleArray[indexPath.row]
        cell.textLabel?.font = UIFont(name: MY_FONT, size: 14)
        
        var row = indexPath.row
        
        if self.showScore && row > 1{
            row -= 1
        }
        
        switch row{
        case 0:
            cell.detailTextLabel?.text = Book_Title
            break
        case 2:
            cell.detailTextLabel?.text = self.type + "->" + self.detailType
        case 4:
            cell.accessoryType = .None
            let commntView = UITextView(frame: CGRect(x: 4, y: 4, width: SCREEN_WIDTH - 8,height: 80))
            commntView.text = self.Book_Description
            commntView.font = UIFont(name: MY_FONT, size: 14)
            commntView.editable = false //不允许用户编辑该tableView
            cell.contentView.addSubview(commntView)
        default:
            break
        }
        
        
        
        //判断是否添加小星星
        if showScore && indexPath.row == 2{
            cell.contentView.addSubview(score!)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if showScore && indexPath.row >= 5 {
            return 88
        }else if !showScore && indexPath.row >= 4 {
            return 88
        }else{
            return 44
        }
    }
    
    //设置点击事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        //点击评分跳出原来分类的界面bug修改
        var row = indexPath.row
        if row > 1 && showScore{
            row -= 1
        }
        
        //为了优化二级目录返回为非选中状态,添加这条语句
        self.tableView?.deselectRowAtIndexPath(indexPath, animated: true)
        
        
        switch row{
        case 0:
            tableViewSelectTitle()
//            print("1")
            break
        case 1:
            tableViewSelectScore()
            break
        case 2:
            tableViewSelectType()
            break
        case 3:
            tableViewSelectDescription()
            break
        default:
            break
        }
        
    }
    
    //点击标题
    func tableViewSelectTitle(){
        let vc = Push_TitleController()
        GeneralFactory.addTitleWithTitle(vc)
//        print("here")
        vc.callBack = ({(Title:String) -> Void in
            self.Book_Title = Title
            self.tableView?.reloadData()
        
        })
        self.presentViewController(vc, animated: true) { () -> Void in
            
        }
        
    }
    
    //点击评分
    func tableViewSelectScore(){
        self.tableView?.beginUpdates()
        
        
        let tempIndexPath = [NSIndexPath(forRow: 2, inSection: 0)]
        
        if self.showScore == true{
            self.titleArray.removeAtIndex(2)
            self.tableView?.deleteRowsAtIndexPaths(tempIndexPath, withRowAnimation: .Right)
            self.showScore = false
        
        }else{
            self.tableView?.insertRowsAtIndexPaths(tempIndexPath, withRowAnimation: .Left)
            self.showScore = true
        
            self.titleArray.insert("", atIndex: 2)
        }
        self.tableView?.endUpdates()
        
    }
    //点击分类
    func tableViewSelectType(){
        let vc = Push_TypeController()
        GeneralFactory.addTitleWithTitle(vc)
        let but1 = vc.view.viewWithTag(1234) as? UIButton
        let but2 = vc.view.viewWithTag(1235) as? UIButton
        but1?.setTitleColor(RGB1(38, g: 82, b: 67), forState: .Normal)
        but2?.setTitleColor(RGB(38, g: 82, b: 67), forState: .Normal)
        
        //vc.type = self.type
        //vc.detailType = self.detailType
        
        vc.callBack = ({(type: String,detailType: String ) -> Void in
            
            
            self.type = type
            self.detailType = detailType
            self.tableView?.reloadData()
        })
        
        self.presentViewController(vc, animated: true) { () -> Void in
            
        }
        
    }
    //点击书评
    func tableViewSelectDescription(){
        let vc = Push_DescriptionController()
        GeneralFactory.addTitleWithTitle(vc)
        vc.textView?.text = self.Book_Description
        
        vc.callBakc = ({(description) -> Void in
            self.Book_Description = description
            if self.titleArray.last == ""{
                self.titleArray.removeLast()
            }
            
            if description != ""{
                self.titleArray.append("")
            }
            
            self.tableView?.reloadData()
        })
        
        self.presentViewController(vc, animated: true) { () -> Void in
            
        }
        
    }

    
    
}
