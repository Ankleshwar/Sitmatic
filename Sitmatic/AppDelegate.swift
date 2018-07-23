//
//  AppDelegate.swift
//  Sitmatic
//
//  Created by Ankleshwar on 05/06/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
// Aurthophoto photogenphic
// 9811848833 Sachin.
//subros sector 8 gurgao
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
         print(UIApplication.shared.applicationState)
        print("~~~~~~~~~~~~~~~~~~didFinishLaunchingWithOptions~~~~~~~~~~~~~~~~~~~")

        
        return true
    }

    
    //163fe1bb71e8983f744fddae8e3d57d05c3a0e0c
    
    func setRootController(){
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let islogin = UserDefaults.standard.bool(forKey: "isLogin")
        if islogin == true{
            viewController = SHomeVC(nibName: "SHomeVC", bundle: nil)
        }else{
            viewController = SSLoginVC(nibName: "SSLoginVC", bundle: nil)
        }
        
         //viewController = SSLoginVC(nibName: "SSLoginVC", bundle: nil)
        navigationController = UINavigationController(rootViewController: (viewController)!)
        self.window?.rootViewController = self.navigationController
        navigationController?.navigationBar.isHidden = true
        
        window?.makeKeyAndVisible()
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
         print(UIApplication.shared.applicationState)
        if UIApplication.shared.applicationState == .inactive {
              print("inactive")
        }else{
            print("back")
        }
        print("~~~~~~~~~~~~~~~~~~applicationWillResignActive~~~~~~~~~~~~~~~~~~~")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
         print(UIApplication.shared.applicationState)
        if UIApplication.shared.applicationState == .inactive {
            print("inactive")
        }else{
            print("back")
        }
        print("~~~~~~~~~~~~~~~~~~applicationDidEnterBackground~~~~~~~~~~~~~~~~~~~")
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print(UIApplication.shared.applicationState)
        if UIApplication.shared.applicationState == .inactive {
            print("inactive in applicationWillEnterForeground")
        }
         print("~~~~~~~~~~~~~~~~~~applicationWillEnterForeground~~~~~~~~~~~~~~~~~~~")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
         print(UIApplication.shared.applicationState)
        print("~~~~~~~~~~~~~~~~~~applicationDidBecomeActive~~~~~~~~~~~~~~~~~~~")
    }

    func applicationWillTerminate(_ application: UIApplication) {
         print(UIApplication.shared.applicationState)
        if UIApplication.shared.applicationState == .inactive {
            
        }
        
       print("~~~~~~~~~~~~~~~~~~applicationWillTerminate~~~~~~~~~~~~~~~~~~~")
    }


}

