//
//  PhotoPickerViewController.swift
//  dushuApp
//
//  Created by LGZwr on 16/2/28.
//  Copyright © 2016年 maizi. All rights reserved.
//

import UIKit


//将相册选取的界面回传 通过delegate

protocol PhotoPickerDelegate{
    func getImageFromPicker(image:UIImage)
}

class PhotoPickerViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var alert : UIAlertController?
    var pikcer : UIImagePickerController!
    var delegate : PhotoPickerDelegate!
    
    init(){
    
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        
        //modal出来PhotoPickerViewController 背景为透明  可以看到下一层viewController
        self.view.backgroundColor = UIColor.clearColor()
        self.pikcer = UIImagePickerController()
        self.pikcer.allowsEditing = false//不允许截图,因为为正方形,不是我们指定的大小
        self.pikcer.delegate = self
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewDidAppear(animated: Bool) {
        if (self.alert == nil){
            self.alert = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
            //设置alert显示的内容
            self.alert?.addAction(UIAlertAction(title: "相册选取", style: .Default, handler: { (action) -> Void in
                self.localPhoto()
            }))
            self.alert?.addAction(UIAlertAction(title: "打开相机", style: .Default, handler: { (action) -> Void in
                self.takePhoto()
            }))
            self.alert?.addAction(UIAlertAction(title: "取消", style: .Cancel, handler: { (action) -> Void in
                
            }))
            self.presentViewController(self.alert!, animated: true, completion: { () -> Void in
                
            })
        }
    }
    
    //打开相机
    
    func takePhoto(){
        if UIImagePickerController.isSourceTypeAvailable(.Camera){
            
            self.pikcer.sourceType = .Camera
            self.presentViewController(self.pikcer, animated: true, completion: { () -> Void in
                
            })
        
        }else{
            let alert = UIAlertController(title: "抱歉", message: "没有照相机", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "关闭", style: .Cancel, handler: { (action) -> Void in
                self.dismissViewControllerAnimated(true, completion: { () -> Void in
                    
                })
            }))
            self.presentViewController(alert, animated: true, completion: { () -> Void in
               
            })
        }
    }
    

    //打开相册
    
    func localPhoto(){
        self.pikcer.sourceType = .PhotoLibrary
        self.presentViewController(self.pikcer, animated: true) { () -> Void in
            
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.pikcer.dismissViewControllerAnimated(true) { () -> Void in
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                
            })
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.pikcer.dismissViewControllerAnimated(true) { () -> Void in
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                self.delegate.getImageFromPicker(image)
            })
        }
    }
    
}
