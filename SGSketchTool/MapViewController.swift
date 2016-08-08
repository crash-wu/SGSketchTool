//
//  MapViewController.swift
//  SGSketchTool
//
//  Created by 吴小星 on 16/8/8.
//  Copyright © 2016年 crash. All rights reserved.
//

import UIKit
import ArcGIS

class MapViewController: UIViewController {
    
    var mapView     :AGSMapView!
    var sketchType  :SketchType = .Point
    var drawBtn     :UIButton!//绘制
    
    init(type :SketchType){
        super.init(nibName: nil, bundle: nil)
        self.mapView = AGSMapView(frame: self.view.frame)
        self.view.addSubview(self.mapView)
        self.mapView.translatesAutoresizingMaskIntoConstraints = false
        self.mapView.autoresizingMask = [.FlexibleHeight,.FlexibleWidth]
        self.sketchType = type
        let mapUrl = NSURL(string: "http://services.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer")
        let tiledLyr = AGSTiledMapServiceLayer(URL: mapUrl)
        self.mapView.addMapLayer(tiledLyr, withName:"Tiled Layer")
        
        drawBtn = UIButton(type: .Custom)
        self.view.insertSubview(drawBtn, aboveSubview: self.mapView)
        drawBtn.frame = CGRectMake(0, 0, 100, 50)
        drawBtn.setTitle("绘图", forState: .Normal)
        drawBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        drawBtn.backgroundColor = UIColor.blueColor()
        drawBtn.addTarget(self, action: #selector(MapViewController.drawBtnTouch(_:)), forControlEvents: .TouchUpInside)
        
        self.edgesForExtendedLayout = .None
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        


        //Tiled basemap layer

        

        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        

    }
    
    
    @objc private func drawBtnTouch(button:UIButton){
        
        let sketchLayer = SketchToolLayer(sketchType: self.sketchType)
        
        //        objc_setAssociatedObject(SketchHelpUtils.shareManager, &StampAGSMapUtils.freedomSketchLayer, freedomSketchLayer,.OBJC_ASSOCIATION_RETAIN_NONATOMIC )
        
        self.mapView.addMapLayer(sketchLayer)
        self.mapView.touchDelegate = sketchLayer
    }
    
    
}
