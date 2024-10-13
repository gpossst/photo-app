//
//  BetterUIImage.swift
//  PhotoChoice2
//
//  Created by Garrett Post on 3/5/24.
//

import Foundation
import Photos
import UIKit

struct BetterUIImage: Hashable, BetterAsset {
    let image: UIImage
    let asset: PHAsset
    
    init(image: UIImage, asset: PHAsset) {
        self.image = image
        self.asset = asset
    }
}
