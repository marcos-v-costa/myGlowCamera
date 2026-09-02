//
//  PhotoWall.swift
//  myGlowCamera
//
//  Created by marquiros on 01/09/26.
//

import SwiftUI
import SwiftData

struct PhotoWall: View {
    @Environment(CameraModel.self) var model: CameraModel
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \PhotoModel.createdDate, order: .reverse)
    var photos: [PhotoModel]
    
    @State private var showingCamera = false
    
    private let columns = [
        GridItem(.flexible(), spacing: 4),
        GridItem(.flexible(), spacing: 4),
        GridItem(.flexible(), spacing: 4)
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("PhotoWallBackground")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea(edges: .all)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(photos) { photo in
                            if let uiImage = UIImage(data: photo.imageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 220)
                                    .contextMenu {
                                        Button(role: .destructive) {
                                            modelContext.delete(photo)
                                        } label: {
                                            Label("Excluir", systemImage: "trash")
                                        }
                                    }
                                
                            }
                        }
                    }
                    .padding()
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        showingCamera = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationDestination(isPresented: $showingCamera) {
                CameraView()
            }
        }
    }
}

#Preview {
    @Previewable @State var model = CameraModel()
    PhotoWall()
        .environment(model)
        .modelContainer(for: PhotoModel.self)
}
