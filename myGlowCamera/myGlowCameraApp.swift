//
//  myGlowCameraApp.swift
//  myGlowCamera
//
//  Created by marquiros on 30/08/26.
//

import SwiftUI
import SwiftData



@main
struct myGlowCameraApp: App {
    @State private var model = CameraModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(model)
                .modelContainer(for: PhotoModel.self)
        }
    }
    
}



