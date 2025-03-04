//
//  BeMyEyesApp.swift
//  BeMyEyes
//
//  Created by CAIT on 3/4/25.
//

import SwiftUI
import AVFoundation

@main
struct BeMyEyesApp: App {
    init() {
        // Request camera permission when app launches
        AVCaptureDevice.requestAccess(for: .video) { granted in
            if granted {
                print("Camera permission granted")
            } else {
                print("Camera permission denied")
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
