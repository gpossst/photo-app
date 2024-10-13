//
//  GalleryViewModel.swift
//  PhotoChoice2
//
//  Created by Garrett Post on 4/10/24.
//

import Foundation

class GalleryViewModel: ObservableObject {
    @Published var items: [BetterUIImage] = []
    @Published var toRemove: [BetterUIImage] = []
}
