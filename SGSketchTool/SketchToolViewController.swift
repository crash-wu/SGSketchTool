//
//  SketchToolViewController.swift
//  SGSketchTool
//
//  Created by 吴小星 on 16/8/8.
//  Copyright © 2016年 crash. All rights reserved.
//

import UIKit

class SketchToolViewController: UIViewController {
    
    var tableView : UITableView!
    
    var dataSoucre = [SketchType]()
    
    init(){
        super.init(nibName: nil, bundle: nil)
        
        tableView = UITableView(frame: self.view.frame, style: .Plain)
        self.view.addSubview(tableView)
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.autoresizingMask = [.FlexibleHeight,.FlexibleWidth]
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.registerClass(UITableViewCell.self , forCellReuseIdentifier: "cellID")
        
        dataSoucre = [.Point,.FoldLine,.Curve,.Surfaces,.Polygon]
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension SketchToolViewController : UITableViewDelegate,UITableViewDataSource
{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataSoucre.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 60
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cellID", forIndexPath: indexPath)
        
        cell.textLabel?.text = self.dataSoucre[indexPath.row].describe
        cell.accessoryType = .DisclosureIndicator
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let sketchVC = MapViewController(type: self.dataSoucre[indexPath.row])
        
        print("sketchType: \(self.dataSoucre[indexPath.row])")
        self.navigationController?.pushViewController(sketchVC, animated: true)
    }
}
