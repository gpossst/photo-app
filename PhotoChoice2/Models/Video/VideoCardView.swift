//
//  VideoCardView.swift
//  PhotoChoice2
//
//  Created by Garrett Post on 3/31/24.
//

import SwiftUI
import AVKit
import Photos

struct VideoCardView: View {
    let asset: BetterVideo
    var screenSize = UIScreen.main.bounds.size
    
    @EnvironmentObject var viewModel: PhotosModel
    @State private var offset = CGSize.zero
    @State private var player = AVPlayer()
    @State private var text = ""
    @State private var color = Color.clear
    
    
    var body: some View {
        ZStack {
            VideoPlayer(player: player)
                .frame(width: screenSize.width * 0.8, height: screenSize.height * 0.6, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .scaledToFill()
            RoundedRectangle(cornerRadius: 25)
                .frame(width: screenSize.width * 0.8, height: screenSize.height * 0.6)
                .foregroundStyle(color)
                .opacity(0.6)
            GroupBox {
                Text(text)
            }
            .font(.custom("Reem Kufi Fun", size: 40))
            .bold()
            .foregroundStyle(.BG)
            .backgroundStyle(color)
        }
        .padding(.bottom, 40)
        .onAppear {
            let item = asset.video.copy() as! AVPlayerItem
            
            player.pause()
            player = AVPlayer()
            player = AVPlayer(playerItem: item)
            player.play()
        }
        .onDisappear {
            player = AVPlayer()
        }
        .offset(x: offset.width, y: offset.height)
        .rotationEffect(.degrees(Double(offset.width / 40)))
        .gesture(
        DragGesture()
            .onChanged({ gesture in
                offset = gesture.translation
                withAnimation {
                    changeColor(width: offset.width)
                }
            })
            .onEnded({ _ in
                withAnimation(.easeInOut(duration: 0.15)) {
                    swipeCard(width: offset.width)
                    changeColor(width: offset.width)
                    text = ""
                    color = .clear
                } completion: {
                    if offset != .zero {
                        offset = .zero
                        viewModel.next()
                    }
                }
            })
        )
    }
    
    func swipeCard(width: CGFloat) {
        switch width {
        case -10000...(-(screenSize.width / 6)):
//            delete
            offset = CGSize(width: -screenSize.width, height: 0)
            viewModel.appendToPhotosToDelete(asset.asset)
            player = AVPlayer()
            print("User swipe left")
        case (screenSize.width / 6)...(10000):
//            save
            player = AVPlayer()
            offset = CGSize(width: screenSize.width, height: 0)
            print("User swipe right")
        default:
            offset = .zero
        }
    }
    
    func changeColor(width: CGFloat) {
        switch width {
        case -10000...(-(screenSize.width / 6)):
//            delete
            color = .appRed
            text = "Delete"
        case (screenSize.width / 6)...(10000):
//            save
            color = .appGreen
            text = "Save"
        default:
            color = .clear
            text = ""
        }
    }
}

#Preview {
    VideoCardView(asset: BetterVideo(image: AVPlayerItem(url: URL(string: "https://videos.pexels.com/video-files/5824198/5824198-hd_1080_1920_24fps.mp4", encodingInvalidCharacters: true)!), asset: PHAsset()))
}
