//
//  SaveImageView.swift
//  myGlowCamera
//
//  Created by marquiros on 30/08/26.
//

import SwiftUI

struct SaveImageView: View {
    @Environment(CameraModel.self) var model: CameraModel
    
    @State private var saved = false
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color(.cameraBackground).ignoresSafeArea(edges: .all)
                HStack{
                    PolaroidCard(image: model.photoToken?.image)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    buttonsView()
                }
                .toolbar {
                    ToolbarItem (placement: .navigationBarLeading) {
                        Button {
                            //
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(.white)
                        }
                        .foregroundStyle(.white)
                        .buttonStyle(.glassProminent)
                        .tint(.buttonsCamera)
                    }
                }
            }
        }
    }
    
    private func buttonsView() -> some View {
        VStack {
            Button {
                model.photoToken = nil
            } label: {
                Text("Tirar novamente")
                    .padding(12)
            }
            .padding()
            .buttonStyle(.glass)
            Button {
                guard let photoToken = model.photoToken else { return }
                Task {
                    await model.photoLibraryManager?.savePhoto(imageData: photoToken.imageData)
                    
                    self.saved = true
                    print(saved)
                }
                
            } label: {
                HStack{
                    Text("Salvar foto")
                }
                .padding(12)
                
            }
            .foregroundStyle(.white)
            .buttonStyle(.glassProminent)
            .tint(.buttonsCamera)
        }
        .alert(
            "Fotos salvas!",
            isPresented: $saved
        ) {
            Button("OK", role: .cancel) {
                self.saved = false
                print(saved)
            }
        } message: {
            Text("A foto foi adicionada à sua galeria.")
        }
        .padding()
        .font(.system(size: 24, weight: .bold))
    }
}

#Preview {
    @Previewable @State var model = CameraModel()
    SaveImageView()
        .environment(model)
}
