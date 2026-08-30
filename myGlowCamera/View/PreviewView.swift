//
//  PreviewView.swift
//  myGlowCamera
//
//  Created by marquiros on 30/08/26.
//

import SwiftUI

struct PreviewView: View {
    @Environment(CameraModel.self) var model: CameraModel
    @State private var isRecording: Bool = false
    @State private var selectedZoom: CGFloat = 1
    @State private var cameraTimer  = 0
    @State private var countdown: Int?
    
    private let footerHeight: CGFloat = 110.0
    
    var body: some View {
        ZStack {
            ImageView(image: model.previewImage)
                .padding(.bottom, footerHeight + 50)
                .padding(.top, footerHeight + 50)
                .overlay(alignment: .bottom) {
                    buttonsView()
                        .frame(width: .infinity, height: footerHeight)
                }
                .background(Color.black)
            if let countdown = countdown {
                Text("\(countdown)")
                    .font(.system(size: 100, weight: .bold))
                    .foregroundStyle(.white)
                    .shadow(radius: 10)
            }
        }
    }
    
    private func buttonsView() -> some View {
        GeometryReader { geometry in
            let frameHeight = geometry.size.height
            VStack (spacing: 50) {
                HStack(alignment: .center, spacing: 30){
                    Button {
                        changeCameraTimer()
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "timer")
                            Text(timerLabel)
                        }
                        .padding(8)

                    }
                    .foregroundStyle(
                        cameraTimer == 0
                        ? .white
                        : .red
                    )
                    .buttonStyle(.glass)
                    HStack(spacing: 30) {
                        if model.camera.isUsingBackCaptureDevice {
                            Button("0.5x") {
                                selectedZoom = 0.5
                                model.camera.selectBackCamera(lens: .ultraWide)
                            }
                            .overlay {
                                if selectedZoom == 0.5 {
                                    Text("0.5x")
                                        .frame(minWidth: 40, minHeight: 40)
                                        .background(Color.red)
                                        .clipShape(Circle())
                                }
                            }
                            Button("1x") {
                                selectedZoom = 1
                                model.camera.selectBackCamera(lens: .wide)
                                model.camera.setZoom(factor: 1)
                            }
                            
                            .toggleStyle(.button)
                            .overlay {
                                if selectedZoom == 1 {
                                    Text("1x")
                                        .frame(minWidth: 40, minHeight: 40)
                                        .background(Color.red)
                                        .clipShape(Circle())
                                }
                            }
                            
                            Button("2x") {
                                selectedZoom = 2
                                model.camera.setZoom(factor: 2)
                            }
                            .overlay {
                                if selectedZoom == 2 {
                                    Text("2x")
                                        .frame(minWidth: 40, minHeight: 40)
                                        .background(Color.red)
                                        .clipShape(Circle())
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundStyle(.white)
                    .font(.headline)
                    .padding(.bottom, 30)
                }
                .frame(maxWidth: .infinity)
                HStack {
                    Button {
                        model.camera.toggleFlash()
                    } label: {
                        Image(systemName: model.camera.flashModeIcon)
                            .foregroundStyle(Color.white)
                            .padding(8)

                    }
                    .buttonStyle(.glass)

                    Spacer()
                    Button {
                        startCameraTimer()
                    } label: {
                        ZStack {
                            Circle()
                                .fill(.white)
                                .frame(width:  frameHeight + 20, height: frameHeight + 20)
                        }
                        .padding(4)

                    }
                    .buttonStyle(.glass)

                    Spacer()
                    
                    Button {
                        model.camera.switchCaptureDevice()
                    } label: {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .padding(.horizontal, 6)
                            .padding(.vertical, 10)

                    }
                    .buttonStyle(.glass)

                    
                }
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
                Spacer()

            }
            .frame(maxWidth: .infinity, maxHeight: frameHeight)
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 32)
    }
    
    var timerLabel: String {
        switch cameraTimer {
        case 0:
            return "Off"
            
        default:
            return "\(cameraTimer)s"
        }
    }
    
    func changeCameraTimer() {
        switch cameraTimer {
        case 0:
            cameraTimer = 3
            
        case 3:
            cameraTimer = 5
            
        case 5:
            cameraTimer = 10
            
        default:
            cameraTimer = 0
        }
    }
    
    
    func startCameraTimer() {
        guard cameraTimer > 0 else {
            model.camera.takePhoto()
            return
        }
        
        countdown = cameraTimer
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            guard let current = countdown else {
                timer.invalidate()
                return
            }
            
            if current <= 1 {
                timer.invalidate()
                countdown = nil
                model.camera.takePhoto()
            } else {
                countdown = current - 1
            }
            
        }
    }
}
