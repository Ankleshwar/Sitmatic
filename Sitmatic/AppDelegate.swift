//
//  AppDelegate.swift
//  Sitmatic
//
//  Created by Ankleshwar on 05/06/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var viewController: UIViewController?
    var window: UIWindow?
    var navigationController: UINavigationController?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setRootController()
        UIApplication.shared.statusBarStyle = .lightContent
        UINavigationBar.appearance().barStyle = .blackTranslucent
    

        
        return true
    }

    func setRootController(){
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let islogin = UserDefaults.standard.bool(forKey: "isLogin")
        if islogin == true{
            viewController = ModifieModel(nibName: "ModifieModel", bundle: nil)
        }else{
            viewController = SSLoginVC(nibName: "SSLoginVC", bundle: nil)
        }
        
        // viewController = SSLoginVC(nibName: "SSLoginVC", bundle: nil)
        navigationController = UINavigationController(rootViewController: (viewController)!)
        self.window?.rootViewController = self.navigationController
        navigationController?.navigationBar.isHidden = true
        
        window?.makeKeyAndVisible()
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
    }


}

