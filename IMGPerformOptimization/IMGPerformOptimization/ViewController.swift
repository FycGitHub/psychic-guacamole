//
//  ViewController.swift
//  IMGPerformOptimization
//
//  Created by Frank on 2017/8/3.
//  Copyright © 2017年 Frank. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rect = CGRect(x: 0, y: 0, width: 160, height: 160)
        
        let iv = UIImageView(frame: rect)
        
        iv.center = view.center
        
        view.addSubview(iv)
        
        //设置图像 png图片支持透明
        //jpg 图片不支持透明,使用JPG 用imageName 方法，需要制定扩展名，没有放在Assets中
//        let image = #imageLiteral(resourceName: "default_avatar_user.png")
        
        //小范测试
        let image = #imageLiteral(resourceName: "reader_theme_3_bg.jpg")

        iv.image = avatarImage(image: image, size: rect.size, backColor:view.backgroundColor)
    }

    //  将给定的图像进行拉伸，并且返回新的图像
    //  -return: UIImage
    func avatarImage(image: UIImage, size: CGSize, backColor: UIColor?) -> UIImage? {
        let rect = CGRect(origin: CGPoint(), size: size)
        
        //1. 图像上下文，在内存中开辟一个地址，跟屏幕无关
        /**
           1> size: 绘图的尺寸
           2> 不透明： false/true（不透明）
           3> scale：屏幕分辨率，如果不指定，生成的图像默认使用1.0的分辨率 图片质量不好
              可以指定 0，会根据当前设备的屏幕分辨率
         */
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        
        // 0> 背景填充
        backColor?.setFill()
        UIRectFill(rect)
        
        // 1> 实例化一个圆形的路径
        let path = UIBezierPath(ovalIn: rect)
        // 2> 进行路径裁切， - 后续的绘图，都会出现圆形路径内部，外部的全部干掉
        path.addClip()
        
        // 2. 绘图 drawInRect 就是子啊指定区域拉伸屏幕
        image.draw(in: rect)
        // 3. 绘制内切的圆形
        UIColor.darkGray.setStroke()
        path.lineWidth = 2
        path.stroke()
        
        // 4.取得结果
        let result = UIGraphicsGetImageFromCurrentImageContext()
        
        // 6.关闭上下文
        UIGraphicsEndImageContext()
        
        // 6.返回结果
        return result
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}













