//
//  SketchToolLayer.swift
//  SGSketchTool
//
//  Created by 吴小星 on 16/8/8.
//  Copyright © 2016年 crash. All rights reserved.
//

import UIKit
import ArcGIS

/**
 *  @author crash         crash_wu@163.com   , 16-07-14 08:07:18
 *
 *  @brief  绘图工具类
 */
public class SketchToolLayer: AGSGraphicsLayer, AGSMapViewTouchDelegate{
    
    private  var sketchType  : SketchType = .Point //曲线类型
    
    //线
    private lazy var polyline : AGSMutablePolyline = {
        let line = AGSMutablePolyline()
        line.addPathToPolyline()
        return line
        
    }()
    
    //多边行面
    private lazy var polygon : AGSMutablePolygon = {
        
        let gon = AGSMutablePolygon()
        gon.addRingToPolygon()
        return gon
        
    }()
    
    //点 
    private lazy var point : AGSMutablePoint = {
        
        let point = AGSMutablePoint()
        
        return point
    }()
    
    
    //线的颜色
    private lazy var lineSymbol : AGSSimpleLineSymbol = {
        
        let symbol = AGSSimpleLineSymbol()
        symbol.color = UIColor.redColor()
        symbol.width = 5
        
        return symbol
    }()
    
    
    private lazy var fillSymbol : AGSSimpleFillSymbol = {
        
        //面的内部填充颜色
        let innerSymbol = AGSSimpleFillSymbol()
        innerSymbol.color = UIColor.redColor().colorWithAlphaComponent(0.40)
        innerSymbol.outline = nil
        
        return innerSymbol
        
    }()
    
    private lazy var markSymbol : AGSSimpleMarkerSymbol = {
        
        let symbol = AGSSimpleMarkerSymbol(color: UIColor.redColor())
        symbol.style = .Circle
        return symbol
        
    }()
    
    
    private lazy var graphic : AGSGraphic = {
        
        let grap = AGSGraphic()
        grap.symbol = self.compositeSymbol
        self.addGraphic(grap)
        return grap
    }()
    
    
    private lazy var  compositeSymbol : AGSCompositeSymbol = {
        let symbol = AGSCompositeSymbol()
        
        symbol.addSymbol(self.lineSymbol)
        symbol.addSymbol(self.fillSymbol)
        

        return symbol
    }()
    
    
    
    //渲染器
    private lazy var simpleRenderer : AGSSimpleRenderer = {
        
        let renderer = AGSSimpleRenderer(symbol: self.compositeSymbol)
        self.renderer = renderer
        return renderer
    }()
    

    /**
     初始化函数
     
     :param: sketchType 绘图类型
     
     :returns: 绘图工具类对象
     */
   public init(sketchType: SketchType){
        super.init()
        self.sketchType = sketchType
        
    }
    
    public func mapView(mapView: AGSMapView!, didClickAtPoint screen: CGPoint, mapPoint mappoint: AGSPoint!, features: [NSObject : AnyObject]!) {
        
        switch sketchType {
        case .FoldLine:
            //折线
            polyline.spatialReference = mapView.spatialReference
            
            polyline.addPointToPath(mappoint)
            
            graphic.geometry = polyline
            
            break
        case .Polygon:
            //多边形
            polygon.spatialReference = mapView.spatialReference
            polygon.addPointToRing(mappoint)
            graphic.geometry = polygon
            
            
            break
        case .Point:
            //点
            point.spatialReference = mapView.spatialReference
            point.updateWithX(mappoint.x, y: mappoint.y)
            graphic.geometry = point
           compositeSymbol.addSymbol(self.markSymbol)
            
            break
            
        default :
            
            break
        }
        
        self.refresh()
        
    }
    
    public func mapView(mapView: AGSMapView!, didMoveTapAndHoldAtPoint screen: CGPoint, mapPoint mappoint: AGSPoint!, features: [NSObject : AnyObject]!) {
        
        switch sketchType {
        case .Curve:
            //自由线
            polyline.spatialReference = mapView.spatialReference
            
            polyline.addPointToPath(mappoint)
            
            graphic.geometry = polyline
            
            break
        case .Surfaces:
            //自由面
            polygon.spatialReference = mapView.spatialReference
            polygon.addPointToRing(mappoint)
            graphic.geometry = polygon
            
            
            break
            
        default :
            
            break
        }
        
        self.refresh()
        
    }
    
    /**
     清除图层
     */
   public  func clear(){
        self.graphic.geometry = nil
        self.refresh()
        
        switch sketchType {
        case .Curve:
            let paths = polyline.numPaths
            (0..<paths).forEach {polyline.removePathAtIndex($0)}
            break
            
        case .Surfaces:
            let ringCount = polygon.numRings
            (0..<ringCount).forEach{polygon.removeRingAtIndex($0)}
            break
        default :
            
            break
        }
    }
    
    
    /**
     获取标绘图形
     
     :returns:获取标绘图形
     */
   public func geometry()->AGSGeometry?{
        
        return self.graphic.geometry
    }
    
    
}
