//
//  AppDelegate.swift
//  GeodesyCalc
//
//  Created by Илья Добряков on 27.07.2018.
//  Copyright © 2018 Илья Добряков. All rights reserved.
//

import UIKit
import Socket


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var socketUDP = try! Socket.create(family: .inet, type: .datagram, proto: .udp)
    var socketTCP = try! Socket.create(family: .inet, type: .stream, proto: .tcp)
    func StartSerter() {
        do {
            socketUDP = try Socket.create(family: .inet, type: .datagram, proto: .udp)
            
        } catch let error {
            guard let socketError = error as? Socket.Error else {
                print("Unexpected error...")
                return
            }
            print("Error reported: \(socketError.description)")
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //system things
        UserDefaults.standard.register(defaults: ["FirstStart" : true])
        UserDefaults.standard.register(defaults: ["ServerIp" : "192.168.0.1"])
        UserDefaults.standard.register(defaults: ["ServerPort" : "727"])
        UserDefaults.standard.register(defaults: ["NetProtocol" : "0"]) //0 - UDP; 1 - TCP
        UserDefaults.standard.register(defaults: ["Layout" : "defaultKeys"])
        UserDefaults.standard.register(defaults: ["ButtonsCount" : 2])
        
        //some useless things
        UserDefaults.standard.register(defaults: ["Taptic" : false])
        
        //keys
        UserDefaults.standard.register(defaults: ["ButtonKey1" : "Z"])
        UserDefaults.standard.register(defaults: ["ButtonKey2" : "X"])
        UserDefaults.standard.register(defaults: ["ButtonKey3" : "D"])
        UserDefaults.standard.register(defaults: ["ButtonKey4" : "F"])
        UserDefaults.standard.register(defaults: ["ButtonKey5" : "G"])
        UserDefaults.standard.register(defaults: ["ButtonKey6" : "H"])
        UserDefaults.standard.register(defaults: ["ButtonKey7" : "J"])
        UserDefaults.standard.register(defaults: ["ButtonKey8" : "K"])
        UserDefaults.standard.register(defaults: ["ButtonKey9" : "L"])
        
        //statistics
        UserDefaults.standard.register(defaults: ["PressedBigButtons" : 0])
        UserDefaults.standard.register(defaults: ["iOSKb" : 0])
        UserDefaults.standard.register(defaults: ["sentUDP" : 0])
        UserDefaults.standard.register(defaults: ["sentTCP" : 0])
        
        StartSerter()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        socketUDP.close()
        socketTCP.close()
        print("App will become inactive. Connection closed")
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("App did enter background.")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("App will enter foreground.")
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        StartSerter()
        print("App did become active.")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        socketUDP.close()
        socketTCP.close()
        print("rip app")
        
    }
    
    
}

