//
//  PreviewView.swift
//  myGlowCamera
//
//  Created by marquiros on 30/08/26.
//

import SwiftUI

struct PreviewView: View {
    @Environment(CameraModel.self) var model: CameraModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.cameraBackground).ignoresSafeArea(edges: .all)
                HStack {
                    ImageView(image: model.previewImage)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    buttonsView()
                }
                if let countdown = model.countdown {
                    Text("\(countdown)")
                        .font(.system(size: 100, weight: .bold))
                        .foregroundStyle(.white)
                        .shadow(radius: 10)
                }
            }
            
            .toolbar {
                ToolbarItem (placement: .navigationBarLeading) {
                    Button {
                        //
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    .foregroundStyle(.white)
                    .buttonStyle(.glassProminent)
                    .tint(.buttonsCamera)
                }
                
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
            VStack(spacing: 30) {
                    Button("0.5x") {
                        model.selectZoom(0.5)
                    }
                    .foregroundStyle(.buttonsCamera)
                    .overlay {
                        if model.selectedZoom == 0.5 {
                            Text("0.5x")
                                .bold()
                                .frame(minWidth: 40, minHeight: 40)
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
                                .bold()
                                .frame(minWidth: 40, minHeight: 40)
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
                                .bold()
                                .frame(minWidth: 40, minHeight: 40)
                                .background(Color.buttonsCamera)
                                .clipShape(Circle())
                        }
                    }
            }
            .foregroundStyle(.white)

            Spacer()
            //TODO: mudar pra vstack
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
                                    Gradient.Stop(color: Color(red: 0.71, green: 0.73, blue: 0.97), location: 0.00),
                                    Gradient.Stop(color: Color(red: 0.52, green: 0.54, blue: 0.87), location: 0.95),
                                ],
                                startPoint: UnitPoint(x: 0.5, y: 0),
                                endPoint: UnitPoint(x: 0.5, y: 1)
                            )
                            )
                            .stroke(Color(red: 0.71, green: 0.73, blue: 0.97), lineWidth: 4.52381)
                            .frame(width: 85, height: 85)
                    }
                }
                Spacer()
                //FLASH e SWITCH
                HStack (spacing: 30) {
                    //FLASH
                    Button {
                        model.camera.toggleFlash()
                    } label: {
                        Image(systemName: model.camera.flashModeIcon)
                            .foregroundStyle(Color.white)
                            .padding(8)
                    }
                    .foregroundStyle(.white)
                    .buttonStyle(.glassProminent)
                    .tint(.buttonsCamera)
                    //SWITCH
                    Button {
                        model.camera.switchCaptureDevice()
                    } label: {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .padding(.horizontal, 6)
                            .padding(.vertical, 10)
                    }
                    .foregroundStyle(.white)
                    .buttonStyle(.glassProminent)
                    .tint(.buttonsCamera)
                }
                
            }
            .font(.system(size: 28, weight: .bold))
            .foregroundColor(.white)
        }
        .frame(maxWidth: 240, maxHeight: .infinity)
        .padding(.vertical, 24)
        .padding(.horizontal, 24)

    }
    
}
