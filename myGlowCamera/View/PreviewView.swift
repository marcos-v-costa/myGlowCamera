//
//  PreviewView.swift
//  myGlowCamera
//
//  Created by marquiros on 30/08/26.
//

import SwiftUI
import UIKit

struct PreviewView: View {
    @Environment(CameraModel.self) var model: CameraModel
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.cameraBackground).ignoresSafeArea(edges: .all)
                HStack  {
                    Spacer()
                    ImageView(image: model.previewImage)
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                        .frame(maxWidth: 318, maxHeight: .infinity)
                    Spacer()
                    buttonsView()
                    Spacer()
                }
                if let countdown = model.countdown {
                    Text("\(countdown)")
                        .font(.system(size: 100, weight: .bold))
                        .foregroundStyle(.white)
                        .shadow(radius: 10)
                }
            }
            .onAppear {
                OrientationManager.shared.updateOrientation(to: .landscapeRight, forceRotateTo: .landscapeRight)
            }
            .onDisappear{
                OrientationManager.shared.updateOrientation(to: .landscape)
                model.stopCamera()
                
            }
            
            .toolbar {
                ToolbarItem (placement: .title) {
                    Text("GlowShot")
                        .foregroundStyle(Color.black)
                        .bold()
                }
                
                ToolbarItem (placement: .confirmationAction) {
                    Button {
                        model.changeCameraTimer()
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "timer")
                            Text(model.timerLabel)
                        }
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .padding(8)
                        
                    }
                    .foregroundStyle(.white)
                    .buttonStyle(.glassProminent)
                    .tint(.buttonsCamera)
                }
            }
        }
    }
    
    private func buttonsView() -> some View {
        HStack (spacing: 0) {
            //BOTÕES DE ZOOM (0.5, 1 e 2)
            VStack(spacing: 50) {
                Button("0.5x") {
                    model.selectZoom(0.5)
                }
                .foregroundStyle(.buttonsCamera)
                .overlay {
                    if model.selectedZoom == 0.5 {
                        Text("0.5x")
                            .font(.system(size: 18, weight: .black, design: .rounded))
                            .frame(minWidth: 50, minHeight: 50)
                            .background(Color.buttonsCamera)
                            .clipShape(Circle())
                    }
                }
                Button("1x") {
                    model.selectZoom(1)
                }
                .foregroundStyle(.buttonsCamera)
                .toggleStyle(.button)
                .overlay {
                    if model.selectedZoom == 1 {
                        Text("1x")
                            .font(.system(size: 18, weight: .black, design: .rounded))
                            .frame(minWidth: 50, minHeight: 50)
                            .background(Color.buttonsCamera)
                            .clipShape(Circle())
                    }
                }
                
                Button("2x") {
                    model.selectZoom(2)
                }
                .foregroundStyle(.buttonsCamera)
                
                .overlay {
                    if model.selectedZoom == 2 {
                        Text("2x")
                            .font(.system(size: 18, weight: .black, design: .rounded))
                            .frame(minWidth: 50, minHeight: 50)
                            .background(Color.buttonsCamera)
                            .clipShape(Circle())
                    }
                }
            }
            .foregroundStyle(.white)
            .padding(.bottom, 24)
            
            Spacer()
            //BOTÕES DE TIRAR FOTO, FLASH e SWITCH
            VStack {
                Spacer()
                //TIRAR FOTO
                Button {
                    model.startCameraTimer()
                } label: {
                    ZStack {
                        Circle()
                            .fill(LinearGradient(
                                stops: [
                                    Gradient.Stop(color: Color(red: 0.53, green: 0.58, blue: 0.77), location: 0.23),
                                    Gradient.Stop(color: Color(red: 0.33, green: 0.38, blue: 0.52), location: 0.95),
                                ],
                                startPoint: UnitPoint(x: 0.5, y: 0),
                                endPoint: UnitPoint(x: 0.5, y: 1)
                            )
                            )
                            .frame(width: 130, height: 130)
                    }
                }
                Spacer()
                //FLASH e SWITCH
                HStack (spacing: 30) {
                    //FLASH
                    Button {
                        model.toggleFlash()
                    } label: {
                        Image(systemName: model.flashModeIcon)
                            .foregroundStyle(Color.white)
                            .padding(4)
                    }
                    .foregroundStyle(.white)
                    .buttonStyle(.glassProminent)
                    .tint(.buttonsCamera)
                    //SWITCH
                    Button {
                        model.switchCamera()
                    } label: {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .padding(.horizontal, 2)
                            .padding(.vertical, 6)
                    }
                    .foregroundStyle(.white)
                    .buttonStyle(.glassProminent)
                    .tint(.buttonsCamera)
                }
                
            }
            .font(.system(size: 28, weight: .bold))
            .foregroundColor(.white)
        }
        .frame(maxWidth: 300, maxHeight: .infinity)
        
    }
    
}

#Preview {
    @Previewable @State var model = CameraModel()
    PreviewView()
        .environment(model)
}
