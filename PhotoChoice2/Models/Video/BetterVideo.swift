//
//  BetterVideo.swift
//  PhotoChoice2
//
//  Created by Garrett Post on 3/31/24.
//

import Foundation
import Photos
import UIKit

struct BetterVideo: Hashable, BetterAsset {
    let video: AVPlayerItem
    let asset: PHAsset
    
    init(image: AVPlayerItem, asset: PHAsset) {
        self.video = image
        self.asset = asset
    }
}
