//
//  config.swift
//  dushuApp
//
//  Created by LGZwr on 16/2/27.
//  Copyright © 2016年 maizi. All rights reserved.
//

import Foundation

//定义宏变量


let LOGIN_KEY = true //设置是否打开注册界面的设置

let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
let SCREEN_HIGHT = UIScreen.mainScreen().bounds.size.height

let MAIN_RED = UIColor(colorLiteralRed: 235/255, green: 114/255, blue: 118/255, alpha: 1)

let MY_FONT = "Bauhaus ITC"

func RGB(r:Float, g:Float, b:Float) -> UIColor{
    return UIColor(colorLiteralRed: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
}


func RGB1(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor{
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
}
