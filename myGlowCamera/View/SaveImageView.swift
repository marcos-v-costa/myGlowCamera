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
    
    private let headerHeight: CGFloat = 90.0
    private let footerHeight: CGFloat = 110.0
    
    var body: some View {
        ImageView(image: model.photoToken?.image)
            .padding(.bottom, footerHeight + 50)
            .padding(.top, footerHeight + 50)
            .overlay(alignment: .top) {
                buttonsView()
                    .frame(height: headerHeight)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(.bottom, 16)
            .background(Color.black)
    }
    
    private func buttonsView() -> some View {
        HStack {
            Button {
                model.photoToken = nil
            } label: {
                Image(systemName: "xmark")
            }
            .buttonStyle(.glass)
            
            Spacer()
            
            Button {
                guard let photoToken = model.photoToken else { return }
                Task {
                    await model.photoLibraryManager?.savePhoto(imageData: photoToken.imageData)
                    
                    withAnimation {
                        self.saved = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                            self.saved = false
                        })
                    }
                }
                
            } label: {
                Image(systemName: saved ? "checkmark" : "square.and.arrow.down")
            }
            .buttonStyle(.glass)

            
        }
        .font(.system(size: 24, weight: .bold))
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.horizontal, 32)
        .padding(.top, 32)
    }
}
