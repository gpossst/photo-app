//
//  VideoThumbnailView.swift
//  PhotoChoice2
//
//  Created by Garrett Post on 4/1/24.
//

import SwiftUI
import AVKit
import AVFoundation

struct VideoThumbnailView: View {
    var playerItem: AVPlayerItem
    var screenSize = UIScreen.main.bounds.size
    
    @State private var thumbnailImage: Image?
    
    var body: some View {
        ZStack {
            Group {
                if let thumbnailImage = thumbnailImage {
                    thumbnailImage
                        .frame(width: screenSize.width * 0.8, height: screenSize.height * 0.6, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .scaledToFill()
                } else {
                    Color.clear // Placeholder while loading
                }
            }
            .onAppear {
                generateThumbnail()
            }
        }
        .padding(.bottom, 40)
    }

    
    func generateThumbnail() {
        let asset = playerItem.asset
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        
        let time = CMTime(seconds: 0.0, preferredTimescale: 1)
        
        do {
            let cgImage = try imageGenerator.copyCGImage(at: time, actualTime: nil)
            let uiImage = UIImage(cgImage: cgImage)
            thumbnailImage = Image(uiImage: uiImage)
        } catch {
            print("Error generating thumbnail: \(error.localizedDescription)")
        }
    }
}



#Preview {
    VideoThumbnailView(playerItem: AVPlayerItem(url: URL(string: "https://videos.pexels.com/video-files/5824198/5824198-hd_1080_1920_24fps.mp4", encodingInvalidCharacters: true)!))
}
