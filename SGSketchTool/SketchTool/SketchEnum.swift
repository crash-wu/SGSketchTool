//
//  SketchEnum.swift
//  SGSketchTool
//
//  Created by 吴小星 on 16/8/8.
//  Copyright © 2016年 crash. All rights reserved.
//

import UIKit


/**
 图记类型
 
 - Point:    点
 - FoldLine: 折线
 - Curve:    曲线
 - Surfaces: 曲面
 - Polygon:  多边行

 */
public  enum SketchType :String {
    case Point ,FoldLine ,Curve ,Surfaces ,Polygon
    
   public var describe: String{
        
        switch self {
            case .Point:    return "点"
            case .FoldLine: return "折线"
            case .Curve:    return "曲线"
            case .Surfaces: return "曲面"
            case .Polygon:  return "多边形"
        }
    }
}