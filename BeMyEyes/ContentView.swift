//
//  ContentView.swift
//  BeMyEyes
//
//  Created by CAIT on 3/4/25.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    var body: some View {
        CameraView()
            .ignoresSafeArea() // This makes the camera view fill the entire screen
    }
}

struct CameraView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        
        // Setup camera session in background
        DispatchQueue.global(qos: .userInitiated).async {
            let captureSession = AVCaptureSession()
            
            guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
                  let input = try? AVCaptureDeviceInput(device: device) else {
                return
            }
            
            captureSession.addInput(input)
            
            DispatchQueue.main.async {
                let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                previewLayer.frame = view.frame
                previewLayer.videoGravity = .resizeAspectFill
                view.layer.addSublayer(previewLayer)
                
                // Start running session in background
                DispatchQueue.global(qos: .userInitiated).async {
                    captureSession.startRunning()
                }
            }
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

#Preview {
    ContentView()
}
