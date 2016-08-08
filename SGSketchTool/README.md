# SGSketchToolLayer

#Describe

    A layer that allows the user to interactively sketch geometries on the map .You can sketch point(点) ,FoldLine(折线),Curve(曲线),Surfaces(曲面),Polygon(多边形) geometries from scratch.

#Usage

    /**
    初始化函数

    :param: sketchType 绘图类型

    :returns: 绘图工具类对象
    */
    init(sketchType: SketchType)


    /**
    清除图层
    */
    func clear()

    /**
    获取标绘图形

    :returns:获取标绘图形
    */
    func geometry()->AGSGeometry?



