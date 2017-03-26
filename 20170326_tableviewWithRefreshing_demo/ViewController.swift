//
//  ViewController.swift
//  20170326_tableviewWithRefreshing_demo
//
//  Created by chen hsin hung on 2017/3/26.
//  Copyright © 2017年 chen hsin hung. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
    var tabledata : [String] = ["TPE" ,"KHH" , "PEK" , "MFM" ,"HKG"]

    var refreshControl : UIRefreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.dataSource = self
        tableview.delegate = self
       
        refreshControl.tintColor  = UIColor.orange
        refreshControl.backgroundColor = UIColor.darkGray
        
//         設定屬性的元件
//        NSAttributedString(string: "取資擷取中", attributes: [NSForegroundColorAttributeName  : UIColor.orange])
        
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching More Data", attributes: [NSForegroundColorAttributeName  : refreshControl.tintColor])
        
        
        
        refreshControl.addTarget(self, action: #selector(ViewController.refreshData), for: .valueChanged )
        //不可以加小括號  #selector(ViewController.refreshData())  <---錯
        
        
        
        // MARK:- 識別OS版本
        
        if #available(iOS 10, *){
            tableview.refreshControl = refreshControl
        }
        else{
            tableview.addSubview(refreshControl)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }

    // MARK:- 捲動時的動作
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
      let offset = scrollView.contentOffset.y
        
        if offset < -150 {
            refreshControl.attributedTitle = NSAttributedString(string: "Fetching Data Complete", attributes: [NSForegroundColorAttributeName  : refreshControl.tintColor])
            
        }else{
            
            refreshControl.attributedTitle = NSAttributedString(string: "Fetching More Data", attributes: [NSForegroundColorAttributeName  : refreshControl.tintColor])
            
        }
        
    
        refreshControl.backgroundColor = UIColor.darkGray
        
    }
    
    
    
    
    
    
// MARK:- 刷新資料，
    func refreshData(){
        
        tabledata.append("AAA")
        tabledata.append("bbb")
        tabledata.append("ccc")

        tableview.reloadData()
        
        
        refreshControl.endRefreshing()
        
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tabledata.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableview.dequeueReusableCell(withIdentifier: "cell")!
//        let cell = tableview.deq
        
        cell.textLabel?.text = tabledata[indexPath.row]
    
        return cell
    
    }

}

