//
//  NotiApp.swift
//  Noti
//
//  Created by Nathanael Temesgen on 11/12/21.
//
import UIKit
import SwiftUI
import Firebase

@main
struct NotiApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var directory = Directory()
    @StateObject var accObj = CreateAccount()

    var body: some Scene {
        WindowGroup {
//            let accObj = CreateAccount()
            CurrPage()
                .environmentObject(accObj)
                .environmentObject(directory)
//            SchoolEvents()
//                .environmentObject(accObj)
//                .environmentObject(directory)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}
