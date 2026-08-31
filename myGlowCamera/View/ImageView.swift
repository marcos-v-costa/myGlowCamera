//
//  ImageView.swift
//  myGlowCamera
//
//  Created by marquiros on 30/08/26.
//

import SwiftUI

struct ImageView: View {
    var image: Image?
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            if let image = image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: height)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 24))
            }
        }
    }
}
