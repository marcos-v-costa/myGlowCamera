//
//  CameraView.swift
//  myGlowCamera
//
//  Created by marquiros on 30/08/26.
//

import SwiftUI

struct CameraView: View {
    @Environment(CameraModel.self) var model: CameraModel

    var body: some View {
        ZStack {
            if let _ = model.photoToken {
                SaveImageView()
            } else {
                PreviewView()
                    .onAppear {
                        model.resumePreview()
                    }
                    .onDisappear {
                        model.pausePreview()
                    }
            }
        }
        .task {
            await model.startCamera()
        }
        .environment(model)
    }
}
