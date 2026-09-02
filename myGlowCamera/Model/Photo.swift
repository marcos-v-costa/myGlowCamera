//
//  Photo.swift
//  myGlowCamera
//
//  Created by marquiros on 01/09/26.
//

import SwiftData
import Foundation

@Model
class PhotoModel{
    var id = UUID()
    var imageData: Data
    var createdDate: Date = Date()
    
    init(imageData: Data, createdDate: Date = .now) {
        self.imageData = imageData
        self.createdDate = createdDate
    }
}
