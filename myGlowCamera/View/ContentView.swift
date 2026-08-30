//
//  ContentView.swift
//  myGlowCamera
//
//  Created by marquiros on 30/08/26.
//

import SwiftUI

struct ContentView: View {
    @Environment(CameraModel.self) var model: CameraModel

    var body: some View {
        CameraView()
    }
}

#Preview {
    @Previewable @State var model = CameraModel()
    ContentView()
        .environment(model)
}
