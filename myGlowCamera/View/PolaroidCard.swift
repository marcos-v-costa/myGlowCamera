//
//  PolaroidCard.swift
//  myGlowCamera
//
//  Created by marquiros on 30/08/26.
//

import SwiftUI

struct PolaroidCard: View {
    var image: Image?
    
    var body: some View {
        VStack(spacing: 24) {
            if let image = image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipped()
                    .cornerRadius(4)
            }
            
            
            Image("myGlow")
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 30)
        }
        .padding()
        .padding(.bottom, 16)
        .background(Color.white)
        .cornerRadius(4)
        .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 4)
    }
}

//#Preview {
//    ScrollView (.horizontal) {
//        HStack (spacing: 32) {
//            ForEach(0..<8) { _ in
//                PolaroidCard(polaroidPhoto: "foto-polaroid")
//            }
//        }
//        .padding(.vertical, 32)
//        .padding(.horizontal, 32)
//    }
//}
