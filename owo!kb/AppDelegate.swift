//
//  AppDelegate.swift
//  GeodesyCalc
//
//  Created by Илья Добряков on 27.07.2018.
//  Copyright © 2018 Илья Добряков. All rights reserved.
//

import UIKit
import SwiftSocket

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var client: UDPClient = UDPClient(address: UserDefaults.standard.string(forKey: "ServerIp") ?? "192.168.0.1", port: Int32(UserDefaults.standard.integer(forKey: "ServerPort")))
//    var server = TCPServer(address: UIDevice.current.ipAddress()!, port: 8080)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let defaults = UserDefaults.standard
        
        let FirstStart = ["FirstStart" : true]
        defaults.register(defaults: FirstStart)
        
        let ServerIp = ["ServerIp" : "192.168.0.1"]
        defaults.register(defaults: ServerIp)
        
        let ServerPort = ["ServerPort" : "727"]
        defaults.register(defaults: ServerPort)
        
        let ConnectionType = ["ConnectionType" : "0"] //0 - UDP; 1 - TCP
        defaults.register(defaults: ConnectionType)
        
        let FourKeySwitch = ["FourKeySwitch" : false]
        defaults.register(defaults: FourKeySwitch)
        
        let UnitedKeySwitch = ["UnitedKeySwitch" : false]
        defaults.register(defaults: UnitedKeySwitch)
        
        let UIView2K_1K = ["UIView2K_1K" : "Z"]
        defaults.register(defaults: UIView2K_1K)
        
        let UIView2K_2K = ["UIView2K_2K" : "X"]
        defaults.register(defaults: UIView2K_2K)
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        client.close()
//        server.close()
        print("App will become inactive. Connection closed")
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("App did enter background.")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("App will enter foreground.")
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        client = UDPClient(address: UserDefaults.standard.string(forKey: "ServerIp")!, port: Int32(UserDefaults.standard.integer(forKey: "ServerPort")))
//        server = TCPServer(address: UIDevice.current.ipAddress()!, port: 8080)
        print("App did become active. New connection is ", UserDefaults.standard.string(forKey: "ServerIp")!, ":", UserDefaults.standard.integer(forKey: "ServerPort"))
//        print("New server address is ", UIDevice.current.ipAddress()!, ":8080")
        
//        switch server.listen() {
//        case .success:
//            while true {
//                if let Package = server.accept() {
//                    print("Newclient from:\(Package.address)[\(Package.port)]")
//                    print("Catch:", String(decoding: Package.read(1024*10)!, as: UTF8.self))
//                } else {
//                    print("accept error")
//                }
//            }
//        case .failure:
//            print("error")
//        }
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        client.close()
//        server.close()
        print("rip app")
        
    }
    
    
}

