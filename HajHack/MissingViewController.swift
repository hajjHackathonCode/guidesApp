//
//  MissingViewController.swift
//  HajHack
//
//  Created by Dalal on 8/1/18.
//  Copyright © 2018 Dalal. All rights reserved.
//

import UIKit

class MissingViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource{

    @IBOutlet weak var noMissingLabel: UILabel!
    
    @IBOutlet weak var MissingTable: UICollectionView!
    var missingP : [MissingPilgrimage] = [MissingPilgrimage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MissingTable.delegate = self
        MissingTable.dataSource = self
        ServerManger.sharedInstance.getalllosts(completionHandler: listLostsHandler)
        
        
    }

    func listLostsHandler(missingP:[MissingPilgrimage]?){
        if missingP?.count == 0 {
            self.noMissingLabel.text = "لا يوجد مفقوديين"
        }else{
            self.missingP = missingP!
            self.MissingTable.reloadData()
            
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detail", sender: self.missingP[indexPath.row])
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? PDetailViewController{
            viewController.missingP = sender as! MissingPilgrimage
        }
    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.missingP.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Missing", for: indexPath) as! MissingCollectionViewCell
        
        cell.cellBackgroundView.layer.cornerRadius = cell.cellBackgroundView.bounds.size.height/8;
        cell.name.text = self.missingP[indexPath.row].name
        cell.avatar.image = self.missingP[indexPath.row].image
        cell.period.text = self.missingP[indexPath.row].period
        
        
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
        
        return missingP.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    

}
