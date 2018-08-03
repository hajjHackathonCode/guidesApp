//
//  NotificationsViewController.swift
//  HajHack
//
//  Created by Dalal on 8/1/18.
//  Copyright © 2018 Dalal. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var messsagesTable: UICollectionView!
    @IBOutlet weak var noNotifications: UILabel!
    
    var messagesArray  = [MessageUpdate]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        messsagesTable.delegate = self
        messsagesTable.dataSource = self
        ServerManger.sharedInstance.getalllosts(completionHandler: listLostsHandler)


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func listLostsHandler(missingP:[MissingPilgrimage]?){
        if missingP?.count == 0 {
            self.noNotifications.text = "لا يوجد تنبيهات حاليا "
            
            
        }else{
            self.messagesArray = missingP![0].informationHistory!
            self.messsagesTable.reloadData()
            
        }
        
        
    }

    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.messagesArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Message", for: indexPath) as! MessageCollectionViewCell
    
        cell.cellBackgroundView.layer.cornerRadius = cell.cellBackgroundView.bounds.size.height/8;
        cell.pligrimName.text = self.messagesArray[indexPath.row].name
        cell.avatar.image = self.messagesArray[indexPath.row].image
        cell.messgaeLabel.text = self.messagesArray[indexPath.row].message
    
        
        return cell
    }

    
    
    
//    func listChildHandler(children:[MissingChild]?){
//        if children?.count == 0 {
//
//        }else{
//            self.children = children
//            self.ListTableView.reloadData()
//
//        }
//
//
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messagesArray.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
}
