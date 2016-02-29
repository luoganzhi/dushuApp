//
//  Push_TypeController.swift
//  dushuApp
//
//  Created by LGZwr on 16/2/28.
//  Copyright © 2016年 maizi. All rights reserved.
//

import UIKit

class Push_TypeController: UIViewController,IGLDropDownMenuDelegate {
    
    var segmentControll1: AKSegmentedControl?
    var segmentControll2: AKSegmentedControl?
    
    var dropDownMenu1: IGLDropDownMenu?
    var dropDownMenu2: IGLDropDownMenu?
    
    var literatureArray1:Array<NSDictionary> = []
    var literatureArray2:Array<NSDictionary> = []
    
    
    var humanitiesArray1:Array<NSDictionary> = []
    var humanitiesArray2:Array<NSDictionary> = []
    
    
    var livelihoodArray1:Array<NSDictionary> = []
    var livelihoodArray2:Array<NSDictionary> = []
    
    
    var economiesArray1:Array<NSDictionary> = []
    var economiesArray2:Array<NSDictionary> = []
    
    
    var technologyArray1:Array<NSDictionary> = []
    var technologyArray2:Array<NSDictionary> = []
    
    var NetworkArray1:Array<NSDictionary> = []
    var NetworkArray2:Array<NSDictionary> = []

    
    var type = "文学"
    var detailType = "文学"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = RGB(231, g: 231, b: 231)
        
        let segmentLabel = UILabel(frame: CGRect(x: (SCREEN_WIDTH - 300) / 2, y: 20, width: 300, height: 20))
        segmentLabel.text = "请选择分类"
        segmentLabel.font = UIFont(name: MY_FONT, size: 17)//字体也要设置orz
        segmentLabel.textColor = RGB(82, g: 113, b: 131)
        segmentLabel.textAlignment = .Center
        segmentLabel.shadowOffset = CGSize(width: 0, height: 1)
        segmentLabel.shadowColor = UIColor.whiteColor()
        self.view.addSubview(segmentLabel)
        
        
        self.initSegment()
        self.initDropArray()
        
        self.creatDropDownMenu(literatureArray1, array2: literatureArray2)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func sure(){
        
    }
    
    func close(){
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }    
    }
    
    //初始化这12个字典
    func initDropArray(){
        
        literatureArray1 = [
            ["title":"小说"],
            ["title":"漫画"],
            ["title":"青春文学"],
            ["title":"随笔"],
            ["title":"现当代诗"],
            ["title":"戏剧"],
        ];
        literatureArray2 = [
            ["title":"传记"],
            ["title":"古诗词"],
            ["title":"外国诗歌"],
            ["title":"艺术"],
            ["title":"摄影"],
        ];
        humanitiesArray1 = [
            ["title":"历史"],
            ["title":"文化"],
            ["title":"古籍"],
            ["title":"心理学"],
            ["title":"哲学/宗教"],
            ["title":"政治/军事"],
        ];
        humanitiesArray2 = [
            ["title":"社会科学"],
            ["title":"法律"],
        ];
        livelihoodArray1 = [
            ["title":"休闲/爱好"],
            ["title":"孕产/胎教"],
            ["title":"烹饪/美食"],
            ["title":"时尚/美妆"],
            ["title":"旅游/地图"],
            ["title":"家庭/家居"],
        ];
        livelihoodArray2 = [
            ["title":"亲子/家教"],
            ["title":"两性关系"],
            ["title":"育儿/早教"],
            ["title":"保健/养生"],
            ["title":"体育/运动"],
            ["title":"手工/DIY"],
        ];
        economiesArray1  = [
            ["title":"管理"],
            ["title":"投资"],
            ["title":"理财"],
            ["title":"经济"],
        ];
        economiesArray2  = [
            ["title":"没有更多了"],
        ];
        technologyArray1 =  [
            ["title":"科普读物"],
            ["title":"建筑"],
            ["title":"医学"],
            ["title":"计算机/网络"],
        ];
        technologyArray2 = [
            ["title":"农业/林业"],
            ["title":"自然科学"],
            ["title":"工业技术"],
        ];
        NetworkArray1 =    [
            ["title":"玄幻/奇幻"],
            ["title":"武侠/仙侠"],
            ["title":"都市/职业"],
            ["title":"历史/军事"],
        ];
        NetworkArray2 =    [
            ["title":"游戏/竞技"],
            ["title":"科幻/灵异"],
            ["title":"言情"],
        ];
        
        
        
        
        
    }

    
    //初始化segmentcontroller的方法
    func initSegment(){
        
        let buttonArray1 = [
            ["image": "ledger", "title": "文学", "font": MY_FONT],
            ["image": "drama masks", "title": "人文社科", "font": MY_FONT],
            ["image": "aperture", "title": "生活", "font": MY_FONT]
        ]
        
        self.segmentControll1 = AKSegmentedControl(frame: CGRect(x: 10, y: 60, width: SCREEN_WIDTH - 20, height: 37))
        self.segmentControll1?.initButtonWithTitleandImage(buttonArray1)
        self.view.addSubview(segmentControll1!)
        
        let buttonArray2 = [
            ["image": "atom", "title": "文学", "font": MY_FONT],
            ["image": "alien", "title": "科技", "font": MY_FONT],
            ["image": "fire element", "title": "网络流行", "font": MY_FONT]
        ]
        
        self.segmentControll2 = AKSegmentedControl(frame: CGRect(x: 10, y: 110, width: SCREEN_WIDTH - 20, height: 37))
        self.segmentControll2?.initButtonWithTitleandImage(buttonArray2)
        self.view.addSubview(segmentControll2!)

        self.segmentControll1?.addTarget(self, action: Selector("segementControllerAction:"), forControlEvents: .ValueChanged)
        self.segmentControll2?.addTarget(self, action: Selector("segementControllerAction:"), forControlEvents: .ValueChanged)
    }
    
    
    //设置segement的点击动作
    
    func segementControllerAction(segment: AKSegmentedControl){
        var index = segment.selectedIndexes.firstIndex
        self.type = ((segment.buttonsArray[index] as? UIButton)?.currentTitle)!
        
        if segment == segmentControll1{
            segmentControll2?.setSelectedIndex(3)//取消第二个的选中状态
        }else{
            segmentControll1?.setSelectedIndex(3)
            index += 3
        }
        
        if dropDownMenu1 != nil{
            //有值的时候重新设置参数
            dropDownMenu1?.resetParams()
        }
        
        if dropDownMenu2 != nil{
            //有值的时候重新设置参数
            dropDownMenu2?.resetParams()
        }
        
        switch (index) {
            case 0:
               // print("dianle")
                self.creatDropDownMenu(literatureArray1, array2: literatureArray2)
                
                break
            case 1:
                self.creatDropDownMenu(humanitiesArray1, array2: humanitiesArray2)
                break
            case 2:
                self.creatDropDownMenu(livelihoodArray1, array2: livelihoodArray2)
                break
            case 3:
                self.creatDropDownMenu(economiesArray1, array2: economiesArray2)
                break
            case 4:
                self.creatDropDownMenu(technologyArray1, array2: technologyArray2)
                break
            case 5:
                
                self.creatDropDownMenu(NetworkArray1, array2: NetworkArray2)
                break
            default:
                break
        }
        
        
    }
    
    //初始化dropDownMenu
    
    func creatDropDownMenu(array1: Array<NSDictionary>,array2: Array<NSDictionary>){
        print("here")
        let dropDownItem1 = NSMutableArray()
        for var i = 0; i < array1.count; i++ {
            let dict = array1[i]
            let item = IGLDropDownItem()
            item.text = dict["title"] as? String
            dropDownItem1.addObject(item)
        }
        
        
        let dropDownItem2 = NSMutableArray()
        for var i = 0; i < array2.count; i++ {
            let dict = array2[i]
            let item = IGLDropDownItem()
            item.text = dict["title"] as? String
            dropDownItem2.addObject(item)
        }
        
        //因为复用的关系,所以要先删除,然后在初始化
        dropDownMenu1?.removeFromSuperview()
        dropDownMenu1 = IGLDropDownMenu()
        dropDownMenu1?.menuText = "点击展开"
        dropDownMenu1?.menuButton.textLabel.adjustsFontSizeToFitWidth = true
        dropDownMenu1?.menuButton.textLabel.textColor = RGB(38, g: 82, b: 67)
        dropDownMenu1?.paddingLeft = 15 //不知道干嘛...
        dropDownMenu1?.delegate = self
        dropDownMenu1?.type = .Stack //设置样式
        dropDownMenu1?.itemAnimationDelay = 0.1 //每个展开的时间
        dropDownMenu1?.gutterY = 5
        dropDownMenu1?.dropDownItems = dropDownItem1 as [AnyObject]
        dropDownMenu1?.frame = CGRect(x: 20, y: 150, width: SCREEN_WIDTH / 2 - 30, height: (SCREEN_HIGHT - 200) / 7)//必须最后设置大小,不然可能会和上面设置的有冲突
        self.view.addSubview(dropDownMenu1!)
        dropDownMenu1?.reloadView()
        
        
        dropDownMenu2?.removeFromSuperview()
        dropDownMenu2 = IGLDropDownMenu()
        dropDownMenu2?.menuText = "点击展开"
        dropDownMenu2?.menuButton.textLabel.adjustsFontSizeToFitWidth = true
        dropDownMenu2?.menuButton.textLabel.textColor = RGB(38, g: 82, b: 67)
        dropDownMenu2?.paddingLeft = 15 //不知道干嘛...
        dropDownMenu2?.delegate = self
        dropDownMenu2?.type = .Stack //设置样式
        dropDownMenu2?.itemAnimationDelay = 0.1 //每个展开的时间
        dropDownMenu2?.gutterY = 5
        dropDownMenu2?.dropDownItems = dropDownItem2 as [AnyObject]
        dropDownMenu2?.frame = CGRect(x: SCREEN_WIDTH / 2 + 10, y: 150, width: SCREEN_WIDTH / 2 - 30, height: (SCREEN_HIGHT - 200) / 7)//必须最后设置大小,不然可能会和上面设置的有冲突
        self.view.addSubview(dropDownMenu2!)
        dropDownMenu2?.reloadView()

        
        
    
    
    }
    
    
    //实现IGLDropDownMenuDelegate
    
    func dropDownMenu(dropDownMenu: IGLDropDownMenu!, selectedItemAtIndex index: Int) {
        if dropDownMenu == dropDownMenu1{
            let item = self.dropDownMenu1?.dropDownItems[index] as? IGLDropDownItem
            self.detailType = (item?.text)!
            self.dropDownMenu2?.menuButton.text = item?.text
        }else{
            let item = self.dropDownMenu2?.dropDownItems[index] as? IGLDropDownItem
            self.detailType = (item?.text)!
            self.dropDownMenu1?.menuButton.text = self.detailType
        }
    }
    
    
    
    
    
}
