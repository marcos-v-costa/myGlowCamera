//
//  ContentView.swift
//  myGlowCamera
//
//  Created by marquiros on 30/08/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(CameraModel.self) var model: CameraModel

    var body: some View {
        PhotoWall()
    }
}

#Preview {
    @Previewable @State var model = CameraModel()
    ContentView()
        .environment(model)
        .modelContainer(for: PhotoModel.self)
}
