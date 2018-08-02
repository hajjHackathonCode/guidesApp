//
//  AppDelegate.swift
//  HajHack
//
//  Created by Dalal on 8/1/18.
//  Copyright © 2018 Dalal. All rights reserved.
//

import UIKit
import CoreData
import  UserNotifications
import Alamofire

struct Beacon{
    var iceUUID:String
    var name:String
    var major:NSNumber
    var minor:NSNumber
    
    
}
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , ESTBeaconManagerDelegate{

    var window: UIWindow?
    
    let beaconManager = ESTBeaconManager()
    
    let becacons = [Beacon(iceUUID:"B9407F30-F5F8-466E-AFF9-25556B57FE33",
    name:"عبدالله",
    major:6803,
    minor:61382),Beacon(iceUUID:"B9407F30-F5F8-466E-AFF9-25556B57FE11",
                        name:"محمد",
                        major:20842,
                        minor:52629),Beacon(iceUUID:"B9407F30-F5F8-466E-AFF9-25556B57FE22",
                                            name:"وليد",
                                            major:60830,
                                            minor:50967)
       ]
    
    let iceUUID = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.beaconManager.delegate = self
        self.beaconManager.requestAlwaysAuthorization()
        
        for b in becacons{
            self.beaconManager.startMonitoring(for: CLBeaconRegion(
                proximityUUID: UUID(uuidString: b.iceUUID)!,
                major: CLBeaconMajorValue(b.major), minor: CLBeaconMinorValue(b.minor), identifier: b.name))
        }
        
        
      
        let center = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        center.requestAuthorization(options: options) { (granted, error) in
            if granted {
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            }
        }
        
        return true
    }
    func beaconManager(_ manager: Any, didEnter region: CLBeaconRegion) {
        print("We entered the region!")
        
    
        showNotification(with: " دخول حاج", body: "\(region.identifier) تم تسجيل دخولة داخل نطاق المخيم")
      
            
        var url = "http://192.168.8.101:8080/users/updateLocations"
        
        let parameters: Parameters = [
            "lat": 21.61749207451767,
            "lon": 39.15538886498189,
            "beaconsIds" : [
                "e35eefc61a93",
                "d640cd95516a",
                "dcabc717ed9e"
            ]
        ]
            
            
        Alamofire.request(url, method: .post,parameters: parameters,  encoding: JSONEncoding.default,headers:["Content-Type": "application/json",
            "Cache-Control": "no-cache",
            "Postman-Token": "2bb6d09f-4595-450e-b3bf-0998012c393b"])
                .responseJSON {[unowned self] response in
                    print("Success0")
                    switch response.result {
                    case .success(let json):
                        print("Success1")
                        if let data = json as? [String: Any] {
                            print("Success2")
                            if let success =  data["success"] as? Int{
                                
                                if success == 1 {
                                    print("Success3")
                                 
                                    
                                }else{
                                   print("Errror0")
                                    //completionHandler(Constants.RESPONSE_FAIL_STATUS_CODE,nil,data["message"] as! String )
                                }
                                
                                
                            }else {
                                print("Errror1")
//                                completionHandler(Constants.RESPONSE_FAIL_STATUS_CODE,nil,data["message"] as! String)
                                
                            }
                            
                            
                        }
                        
                        
                    case .failure(let err):
                        
                        print(err)
                    }
                    
            }
    }
        
    
    
    func beaconManager(_ manager: Any, didExitRegion region: CLBeaconRegion) {
        print("Did exit region \(region)")
        showNotification(with: "فقد حاج", body: "\(region.identifier) ابتعد عن المخيم")
    }
    
    func showNotification(with title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.badge = 1
        content.sound = UNNotificationSound.default()
        let timeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let request = UNNotificationRequest(identifier: "LocalNotification", content: content, trigger: timeTrigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("We have an error \(error)")
            }
        }
    }


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "HajHack")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

