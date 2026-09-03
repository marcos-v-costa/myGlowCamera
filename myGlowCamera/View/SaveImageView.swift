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
            Image("SaveImageViewBackground")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(edges: .all)
            
            HStack  {
                polaroid
                    .rotationEffect(.degrees(-4.08))
                    .border(Color.red, width: 1)
                buttonsView()
                    .border(Color.red, width: 1)

            }
        }
        .toolbar {
            ToolbarItem (placement: .navigationBarLeading) {
                Button {
                    savePhotoAndDismiss()
                } label: {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
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
        HStack {
            Button {
                model.clearPhoto()
            } label: {
                HStack {
                    Image(systemName: "arrow.trianglehead.counterclockwise")
                    Text("Refazer")
                }
                .font(.system(size: 17, weight: .semibold, design: .rounded))
                .padding(12)
            }
            .padding()
            .buttonStyle(.glass)
            ShareLink(item: renderedPolaroidPng, preview: SharePreview(Text("Polaroid"), image: renderedPolaroidPng)) {
                HStack {
                    Image(systemName: "square.and.arrow.up")
                    Text("Exportar")
                }
                .font(.system(size: 17, weight: .semibold, design: .rounded))
                .padding()
            }
            .foregroundStyle(Color.white)
            .buttonStyle(.glass)
        }
        .alert(
            "Fotos salvas!",
            isPresented: $saved
        ) {
            Button("OK", role: .cancel) {
                model.clearPhoto()
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
    }
    
    var renderedPolaroidData: Data? {
        let renderer = ImageRenderer(content: polaroid)
        renderer.scale = displayScale
        return renderer.uiImage?.pngData()
    }
    
    var renderedPolaroidPng: Image {
        let renderer = ImageRenderer(content: polaroid)
        renderer.scale = displayScale
        
        if let uiImage = renderer.uiImage {
            return Image(uiImage: uiImage)
                .resizable()
        }
        return Image("Doll1")
    }
    
    private func savePhotoAndDismiss() {
        guard let photo = renderedPolaroidData else { return }
        
        let polaroid = PhotoModel(imageData: photo)
        modelContext.insert(polaroid)
        
        model.clearPhoto()
        dismiss()
    }
}

#Preview {
    @Previewable @State var model = CameraModel()
    SaveImageView()
        .environment(model)
}
