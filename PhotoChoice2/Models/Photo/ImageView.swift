//
//  ImageView.swift
//  PhotoChoice2
//
//  Created by Garrett Post on 3/6/24.
//

import SwiftUI
import Photos

struct ImageView: View {
    var asset: BetterUIImage
    
    @EnvironmentObject var viewModel: PhotosModel
    @State private var offset = CGSize.zero
    @State private var color = Color.clear
    @State private var text = ""
    
    var screenSize = UIScreen.main.bounds.size
    
    var body: some View {
        ZStack {
            Image(uiImage: asset.image)
                .resizable()
                .scaledToFill()
                .frame(width: screenSize.width * 0.8, height: screenSize.height * 0.6, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 25))
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
        .offset(x: offset.width, y: offset.height)
        .rotationEffect(.degrees(Double(offset.width / 40)))
        .padding(.bottom, 40)
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
            print("User swipe left")
        case (screenSize.width / 6)...(10000):
//            save
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
    ImageView(asset: BetterUIImage(image:  UIImage(systemName: "trash")!, asset: PHAsset()))
        .environmentObject(PhotosModel())
}
