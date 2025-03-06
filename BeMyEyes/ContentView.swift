//
//  ContentView.swift
//  BeMyEyes
//
//  Created by CAIT on 3/4/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var frameHandler = FrameHandler()
    @State private var isSpeaking = false
    
    var body: some View {
        FrameView(image: frameHandler.frame)
            .overlay(
                Button(action: {
                    print("Button tapped")
                    isSpeaking.toggle()
                }) {
                    Circle()
                        .fill(Color.black.opacity(0.6))
                        .frame(width: 120, height: 120)
                        .overlay(
                            Group {
                                if isSpeaking {
                                    AnimatedSpeakerView()
                                } else {
                                    Image(systemName: "speaker.slash.fill")
                                        .font(.system(size: 50))
                                        .foregroundColor(.white)
                                }
                            }
                        )
                },
                alignment: .center
            )
            .ignoresSafeArea()
    }
}

struct AnimatedSpeakerView: View {
    // Discrete opacities for each wave
    @State private var waveOpacity1 = 0.0
    @State private var waveOpacity2 = 0.0
    @State private var waveOpacity3 = 0.0
    
    // We'll cycle through steps 0..6:
    //  0 -> all waves off
    //  1 -> wave 1 on
    //  2 -> wave 1 & 2 on
    //  3 -> wave 1, 2 & 3 on
    //  4 -> wave 1 & 2 on
    //  5 -> wave 1 on
    //  6 -> all waves off (then back to 0)
    @State private var step = 0
    
    var body: some View {
        ZStack {
            // Static base speaker icon
            Image(systemName: "speaker.fill")
                .font(.system(size: 50))
                .foregroundColor(.white)
            
            // “Waves” to the right
            HStack(spacing: 4) {
                // Wave 1
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 3, height: 20)
                    .opacity(waveOpacity1)
                
                // Wave 2
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 3, height: 30)
                    .opacity(waveOpacity2)
                
                // Wave 3
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 3, height: 40)
                    .opacity(waveOpacity3)
            }
            .offset(x: 25) // Move waves next to speaker
        }
        .onAppear {
            // Fire the timer every 0.6s (adjust as desired)
            Timer.scheduledTimer(withTimeInterval: 0.6, repeats: true) { _ in
                step = (step + 1) % 7
                
                // Wrap each step’s opacity changes in an animation block
                withAnimation(.easeInOut(duration: 0.5)) {
                    switch step {
                    case 1:
                        waveOpacity1 = 1;   waveOpacity2 = 0;   waveOpacity3 = 0
                    case 2:
                        waveOpacity1 = 1;   waveOpacity2 = 1;   waveOpacity3 = 0
                    case 3:
                        waveOpacity1 = 1;   waveOpacity2 = 1;   waveOpacity3 = 1
                    case 4:
                        waveOpacity1 = 1;   waveOpacity2 = 1;   waveOpacity3 = 0
                    case 5:
                        waveOpacity1 = 1;   waveOpacity2 = 0;   waveOpacity3 = 0
                    default:
                        // steps 0 & 6: all waves off
                        waveOpacity1 = 0;   waveOpacity2 = 0;   waveOpacity3 = 0
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}