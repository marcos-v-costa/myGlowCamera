//
//  SaveImageView.swift
//  myGlowCamera
//
//  Created by marquiros on 30/08/26.
//

import SwiftUI
import SwiftData

struct SaveImageView: View {
    @Environment(CameraModel.self) var model: CameraModel
    @Environment(\.displayScale) var displayScale
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var saved = false
    
    var body: some View {
        ZStack {
            Color(.cameraBackground).ignoresSafeArea(edges: .all)
            HStack {
                polaroid
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                buttonsView()
            }
        }
        .toolbar {
            ToolbarItem (placement: .navigationBarLeading) {
                Button {
                    dismiss()
                    model.photoToken = nil
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.white)
                }
                .foregroundStyle(.white)
                .buttonStyle(.glassProminent)
                .tint(.buttonsCamera)
            }
        }
        .navigationBarBackButtonHidden(true)
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
                Task {
                    guard let photo = renderedPolaroid else { return }
                    await model.photoLibraryManager?.savePhoto(imageData: photo)
                    
                    let polaroid = PhotoModel(imageData: photo)
                    modelContext.insert(polaroid)
                    
                    self.saved = true
                }
            } label: {
                HStack {
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
                model.photoToken = nil
                dismiss()
            }
        } message: {
            Text("A foto foi adicionada à sua galeria.")
        }
        .padding()
        .font(.system(size: 24, weight: .bold))
    }
    
    var polaroid: some View {
        PolaroidCard(image: model.photoToken?.image)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    var renderedPolaroid: Data? {
        let renderer = ImageRenderer(content: polaroid)
        renderer.scale = displayScale
        return renderer.uiImage?.pngData()
    }
}

#Preview {
    @Previewable @State var model = CameraModel()
    SaveImageView()
        .environment(model)
}
