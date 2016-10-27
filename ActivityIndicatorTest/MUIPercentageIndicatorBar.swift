//
//  MUIPercentageIndicatorBar.swift
//  ActivityIndicatorTest
//
//  Created by Jackie Meggesto on 6/22/16.
//  Copyright © 2016 Jackie Meggesto. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

public class MUIPercentageIndicator: UIView
{
    
    public var lineWidth: CGFloat = 5.0 {
        didSet {
            
            percentageLayer.lineWidth = lineWidth
            
            renderPercentageLayerPath()
        }
    }
    
    public var strokeColor: UIColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0){
        
        didSet{
            percentageLayer.strokeColor = strokeColor.CGColor
        }
    }
    
    private var _percentage: Float = 0.0
    
    public var percentage: Float {
        get {
            return _percentage
        }
        set(newPercentage) {
            //Avoid calling excessively
            
            _percentage = min(max(0, newPercentage), 1)
            percentageLayer.strokeEnd = CGFloat(_percentage)
        }
        
    }
    
    public var name: String = ""
    
    private let percentageLayer: CAShapeLayer! = CAShapeLayer()
    private let circleLayer: CAShapeLayer! = CAShapeLayer()
    public let imageView: UIImageView! = UIImageView()
    
    
    convenience init(frame: CGRect, imageName: String) {
        
        self.init(frame: frame)
        self.imageView.image = UIImage(named: imageName)
        
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    deinit{
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        let width = CGRectGetWidth(self.bounds)
        let height = CGRectGetHeight(self.bounds)
        let square = min(width, height)
        
        //let bounds = CGRectMake(0, 0, square, square)
        
        percentageLayer.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
        circleLayer.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
        
        renderPercentageLayerPath()
        
        let labelSquare = sqrt(2) / 2.0 * square
        imageView.bounds = CGRectMake(0, 0, labelSquare - 8, labelSquare - 8)
        imageView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))
    }
    
    
    //MARK: - Private
    private func initialize() {
        
        circleLayer.strokeColor = UIColor.lightGrayColor().CGColor
        circleLayer.fillColor = nil
        circleLayer.lineWidth = lineWidth
        self.layer.addSublayer(circleLayer)
        
        imageView.hidden = false
        self.addSubview(imageView)
        
        //percentageLayer
        percentageLayer.strokeColor = strokeColor.CGColor
        percentageLayer.fillColor = nil
        percentageLayer.lineWidth = lineWidth
        
        self.layer.addSublayer(percentageLayer)
        
    }
    
    private func renderPercentageLayerPath() {
        
        let center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))
        let radius = (min(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) - percentageLayer.lineWidth) / 2
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(-M_PI / 2), endAngle: CGFloat(1.5 * M_PI), clockwise: true)
        percentageLayer.path = path.CGPath
        circleLayer.path = path.CGPath
        circleLayer.strokeStart = 0.0
        circleLayer.strokeEnd = 1.0
        //        percentageLayer.strokeStart = 0.0
        //        percentageLayer.strokeEnd = 0.0
    }
    
}

public class MUIPercentageIndicatorCell: UIView {
    
    var percentageIndicator: MUIPercentageIndicator!
    
    var header: UILabel!
    var body: UILabel!
    var percentageLabel: UILabel!
    
    convenience init(frame: CGRect, header: String, body: String, percentage: Double) {
        self.init(frame: frame)
        
        
        self.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.layer.borderWidth = 1.0

        self.header = UILabel(frame: CGRectMake(0.25 * self.frame.width, self.frame.height * 0.06, self.frame.width * 0.5, self.frame.height * 0.10))
        self.header.textAlignment = .Center
        self.header.font = UIFont.systemFontOfSize(24.0, weight: UIFontWeightUltraLight)
        self.header.text = header
        self.addSubview(self.header)
        
        
        self.percentageIndicator = MUIPercentageIndicator(frame: CGRectMake(self.frame.width * 0.2, self.header.frame.origin.y + self.header.frame.height + 10, self.frame.width * 0.6, self.frame.width * 0.6), imageName: "offbeat")
        
        self.addSubview(percentageIndicator)
        self.percentageIndicator.percentage = Float(percentage)
        self.percentageIndicator.strokeColor = UIColor.init(hex: 0xcc33ff)

        self.body = UILabel(frame: CGRectMake(0.25 * self.frame.width, self.percentageIndicator.frame.origin.y + self.percentageIndicator.frame.height + 5, 0.5 * self.frame.width , self.header.frame.height))
        self.body.textAlignment = .Center
        self.body.text = "Offbeat"
        self.body.font = UIFont.systemFontOfSize(10.0, weight: UIFontWeightSemibold)
    
        self.addSubview(self.body)
        
        self.percentageLabel = UILabel(frame: CGRectMake(self.body.frame.origin.x, self.body.frame.origin.y + self.body.frame.height + 3, self.body.frame.width, self.body.frame.height))
        self.percentageLabel.text = "\(percentage * 100)%"
        self.percentageLabel.textAlignment = .Center
        self.percentageLabel.textColor = UIColor.grayColor()
        self.percentageLabel.font = UIFont.systemFontOfSize(12.0, weight: UIFontWeightLight)
        self.addSubview(self.percentageLabel)
        
    }
    
    
    
}

class MUIPercentageIndicatorBar: UIView {
    
    
    var innerPanel: UIView!
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupViews() {
        
        var lastX = self.frame.origin.x
        
        for _ in 0..<4 {
            
            let cell = MUIPercentageIndicatorCell(frame: CGRectMake(lastX, 0, self.frame.width / 4, self.frame.height), header: "Vibe", body: "Offbeat", percentage: 0.68)
            self.addSubview(cell)
            lastX += cell.frame.width
            
            
        }
        
    }
    
}