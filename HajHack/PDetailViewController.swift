//
//  PDetailViewController.swift
//  HajHack
//
//  Created by Dalal on 8/1/18.
//  Copyright © 2018 Dalal. All rights reserved.
//

import UIKit

class PDetailViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource{

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var periodButton: UIView!
    @IBOutlet weak var addButtonBackg: UIView!
    @IBOutlet weak var newMessage: UITextView!
    @IBOutlet weak var sendTextMessage: UIButton!
    @IBOutlet weak var messsagesTable: UICollectionView!
    var messagesArray  = [MessageUpdate(name:"من : سالم خالد الأحمد ",date:"2018/4/8",image:#imageLiteral(resourceName: "Bitmap"),message:"أرجو توجيهه بالذهاب لمقر الحملة مباشرة، أرجو توجيهه بالذهاب لمقر الحملة مباشرةأرجو توجيهه بالذهاب لمقر الحملة مباشرةأرجو توجيهه بالذهاب لمقر الحملة مباشرة",time:"5:00pm"),MessageUpdate(name:"من : سالم خالد الأحمد ",date:"2018/4/8",image:#imageLiteral(resourceName: "Bitmap"),message:"أرجو توجيهه بالذهاب لمقر الحملة مباشرة، أرجو توجيهه بالذهاب لمقر الحملة مباشرةأرجو توجيهه بالذهاب لمقر الحملة مباشرةأرجو توجيهه بالذهاب لمقر الحملة مباشرة",time:"5:00pm"),MessageUpdate(name:"من : سالم خالد الأحمد ",date:"2018/4/8",image:#imageLiteral(resourceName: "Bitmap"),message:"أرجو توجيهه بالذهاب لمقر الحملة مباشرة، أرجو توجيهه بالذهاب لمقر الحملة مباشرةأرجو توجيهه بالذهاب لمقر الحملة مباشرةأرجو توجيهه بالذهاب لمقر الحملة مباشرة",time:"5:00pm")]
    override func viewDidLoad() {
        super.viewDidLoad()
        messsagesTable.delegate = self
        messsagesTable.dataSource = self
        backgroundView.layer.cornerRadius = backgroundView.bounds.size.height/2;
        backgroundView.layer.borderColor = UIColor.lightGray.cgColor
        backgroundView.layer.borderWidth = 1.0;
        avatar.layer.cornerRadius = avatar.bounds.size.height/2;
        

        
        periodButton.layer.cornerRadius = periodButton.bounds.size.height/7;
        
        addButtonBackg.layer.cornerRadius = periodButton.bounds.size.height/7;
        addButtonBackg.layer.borderColor = UIColor.lightGray.cgColor
        addButtonBackg.layer.borderWidth = 1.0;
        
        newMessage.layer.cornerRadius = periodButton.bounds.size.height/6;
        newMessage.layer.borderColor = UIColor.lightGray.cgColor
        newMessage.layer.borderWidth = 1.0;
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.messagesArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Missing", for: indexPath) as! UpdateCollectionViewCell
        
        
        cell.pligrimName.text = self.messagesArray[indexPath.row].name
        cell.avatar.image = self.messagesArray[indexPath.row].image
        cell.messgaeLabel.text = self.messagesArray[indexPath.row].message
        
        cell.date.text = self.messagesArray[indexPath.row].date
        cell.time.text = self.messagesArray[indexPath.row].time
        
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
