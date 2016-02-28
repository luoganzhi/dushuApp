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
   
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        
        self.BookTitle = BookTitleView(frame: CGRectMake(0,40,SCREEN_WIDTH,160))
        self.BookTitle?.delegate = self
        self.view.addSubview(self.BookTitle!)
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 40 + 160 , width: SCREEN_WIDTH, height: SCREEN_HIGHT - 200), style: .Grouped)
        //使没有内容的cell不产生线
        self.tableView?.tableFooterView = UIView()
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        //self.tableView?.backgroundColor = UIColor.redColor()
        self.tableView?.backgroundColor = UIColor(colorLiteralRed: 250 / 255, green: 250 / 255, blue: 250 / 255, alpha: 1)
        self.view.addSubview(tableView!)
        
        self.titleArray = ["标题","评分","分类","书评"]
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
        
    }
    
    //实现VPImageCropperDelegate代理
    func imageCropperDidCancel(cropperViewController: VPImageCropperViewController!) {
        cropperViewController.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }

    func imageCropper(cropperViewController: VPImageCropperViewController!, didFinished editedImage: UIImage!) {
        self.BookTitle?.BookOver?.setImage(editedImage, forState: .Normal)
        cropperViewController.dismissViewControllerAnimated(true) { () -> Void in
            
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
        
        cell.textLabel?.text = titleArray[indexPath.row]
        cell.textLabel?.font = UIFont(name: MY_FONT, size: 14)
        
        
//        switch indexPath.row{
//        case 0:
//            cell.detailTextLabel?.text = Book_Title
//            break
//        case 1:
//            break
//        case 2:
//            break
//        case 3:
//            break
//        default:
//            break
//        }
        
        //设置点击事件
        func tableView(tableView: UITableView, didSelectRowAtIndexPath: NSIndexPath){
            self.tableView?.deselectRowAtIndexPath(indexPath, animated: true)
            switch indexPath.row{
                        case 0:
                            tableViewSelectTitle()
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
            self.presentViewController(vc, animated: true) { () -> Void in
                
            }
        
        }
        
        //点击评分
        func tableViewSelectScore(){
        
        }
        //点击分类
        func tableViewSelectType(){
            let vc = Push_TypeController()
            GeneralFactory.addTitleWithTitle(vc)
            self.presentViewController(vc, animated: true) { () -> Void in
                
            }
        
        }
        //点击书评
        func tableViewSelectDescription(){
            let vc = Push_DescriptionController()
            GeneralFactory.addTitleWithTitle(vc)
            self.presentViewController(vc, animated: true) { () -> Void in
                
            }
        
        }
        
        
        return cell
    }
    
    
    
}
