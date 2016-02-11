//
//  ViewController.swift
//  Clock
//
//  Created by huxianming on 16/2/11.
//  Copyright © 2016年 chuanyue. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var clockView: UIImageView!
    var viewWidth:CGFloat?
    var secondLayer:CALayer!
    var minuteLayer:CALayer!
    var hourLayer:CALayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewWidth = clockView.bounds.size.width * 0.5
        
        //安装时针
        setupHour()
        //安装分针
        setupMinute()
        //安装秒针
        setupSecond()
        timeChange()
        
        //定时器
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timeChange", userInfo: nil, repeats: true)
    }
    
    //MARK:- 搭建界面
    //建立秒针layer
    func setupSecond() {
        
        let layer = CALayer.init()
        
        layer.anchorPoint = CGPointMake(0.5, 1)
        layer.position = CGPointMake(viewWidth!, viewWidth!)
        layer.bounds = CGRectMake(0, 0, 1, viewWidth!-20)
        layer.backgroundColor = UIColor.redColor().CGColor
        
        clockView.layer.addSublayer(layer)
        
        secondLayer = layer
        
    }
    
    //建立分针layer
    func setupMinute() {
        
        let layer = CALayer.init()
        
        layer.anchorPoint = CGPointMake(0.5, 1)
        layer.position = CGPointMake(viewWidth!, viewWidth!)
        layer.bounds = CGRectMake(0, 0, 3, viewWidth!-20)
        layer.backgroundColor = UIColor.blackColor().CGColor
        layer.cornerRadius = 5
        
        clockView.layer.addSublayer(layer)
        
        minuteLayer = layer
        
    }
    
    //建立时针layer
    func setupHour() {
        
        let layer = CALayer.init()
        
        layer.anchorPoint = CGPointMake(0.5, 1)
        layer.position = CGPointMake(viewWidth!, viewWidth!)
        layer.bounds = CGRectMake(0, 0, 5, viewWidth!-50)
        layer.backgroundColor = UIColor.blackColor().CGColor
        layer.cornerRadius = 5
        
        clockView.layer.addSublayer(layer)
        
        hourLayer = layer
        
    }

    //MARK:- 指针旋转动画
    //各指针动态的指向当前时间
    func timeChange(){
        
        let calendar = NSCalendar.currentCalendar()
        
        //获取当前时间的秒分时
        let currentSecond = calendar.component(.Second, fromDate: NSDate.init())
        let currentMinute = calendar.component(.Minute, fromDate: NSDate.init())
        let currentHour = calendar.component(.Hour, fromDate: NSDate.init())
        
        //计算秒针、分针、时针的弧度
        let secondRadian = CGFloat(Double(currentSecond * 6)/180.0 * M_PI)
        let minuteRadian = CGFloat((Double(currentMinute * 6) + Double(currentSecond) * 0.1)/180 * M_PI)
        let hourRadian = CGFloat((Double(currentHour * 30) + Double(currentMinute) * 0.5)/180 * M_PI)
        
        //秒针分针时针随时间改变的旋转动画
        secondLayer.transform = CATransform3DMakeRotation(secondRadian, 0, 0, 1)
        minuteLayer.transform = CATransform3DMakeRotation(minuteRadian, 0, 0, 1)
        hourLayer.transform = CATransform3DMakeRotation(hourRadian, 0, 0, 1)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

