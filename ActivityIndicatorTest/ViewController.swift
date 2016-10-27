//
//  ViewController.swift
//  ActivityIndicatorTest
//
//  Created by Jackie Meggesto on 6/21/16.
//  Copyright © 2016 Jackie Meggesto. All rights reserved.
//

import UIKit

public extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    convenience init(hex:Int) {
        self.init(red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff)
    }
    
}

class ViewController: UIViewController {

    var test1: MUIPercentageIndicatorBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let button: UIButton = UIButton(frame: CGRectMake(200, 20, 50, 50))
//        button.titleLabel!.text = "test"
//        button.backgroundColor = UIColor.grayColor()
//        self.view.addSubview(button)
//        button.addTarget(self, action: #selector(ViewController.buttonTapped), forControlEvents: .TouchUpInside)
    
        
        test1 = MUIPercentageIndicatorBar(frame: CGRectMake(0, 100, self.view.frame.width, (self.view.frame.width / 4) * (5/3)))
        self.view.addSubview(test1)
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        for(_, view) in self.view.subviews.enumerate() {
//            
//            if let cell = view as? MUIPercentageIndicatorCell {
//                
//                var percentage = 10.0 / Float(arc4random_uniform(100))
//                if percentage >= 100.0 {
//                    
//                    while percentage >= 100 {
//                        percentage = percentage - (0.10 * percentage)
//                    }
//                    
//                }
//                
//                cell.percentageIndicator.percentage = percentage
//                cell.percentageLabel.text = "\(ceil(percentage * 100))%"
//                
//            }
//            
//            
//        }
        
    }
    
    func buttonTapped() {
        
//        if test1.percentageIndicator.percentage == 0 {
//            
//            test1.percentageIndicator.percentage += 0.68
//            
//            
//        } else {
//            
//            test1.percentageIndicator.percentage = 0.0 
//            
//        }
        

        
    }


}

