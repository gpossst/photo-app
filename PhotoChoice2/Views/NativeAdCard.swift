//
//  NativeAdCard.swift
//  PhotoChoice2
//
//  Created by Garrett Post on 4/14/24.
//

import SwiftUI
import AdmobSwiftUI

struct NativeAdCard: View {
//    Release: ca-app-pub-3984797860990299/3040722927
//    Test: ca-app-pub-3940256099942544/3986624511
    @StateObject var nativeVM: NativeAdViewModel = NativeAdViewModel(
                                                        adUnitID: "ca-app-pub-3984797860990299/3040722927",
                                                        requestInterval: 120
                                                    )
    @State private var offset = CGSize.zero
    @EnvironmentObject var photos: PhotosModel
    var screenSize = UIScreen.main.bounds.size
    
    var index: Int
    
//    init() {
//        print("Loaded")
//    }
    
    var body: some View {
        ZStack {
            NativeAdView(nativeViewModel: nativeVM)
                .frame(width: screenSize.width * 0.8, height: screenSize.height * 0.6, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .onAppear {
                    nativeVM.refreshAd()
                }
                .padding()
        }
        .offset(x: offset.width, y: offset.height)
        .rotationEffect(.degrees(Double(offset.width / 40)))
        .padding(.bottom, 40)
        .gesture(
        DragGesture()
            .onChanged({ gesture in
                offset = gesture.translation
            })
            .onEnded({ _ in
                withAnimation(.easeInOut(duration: 0.15)) {
                    swipeCard(width: offset.width)
                } completion: {
                    if offset != .zero {
                        offset = .zero
                    }
                }
            })
        )
        .onAppear {
            print("Rendered")
        }
    }
    
    func swipeCard(width: CGFloat) {
        switch width {
        case -10000...(-(screenSize.width / 6)):
//            delete
            offset = CGSize(width: -screenSize.width, height: 0)
            photos.showAd = false
            print("User swipe left")
        case (screenSize.width / 6)...(10000):
//            save
            offset = CGSize(width: screenSize.width, height: 0)
            photos.showAd = false
            print("User swipe right")
        default:
            offset = .zero
        }
    }
}

#Preview {
    NativeAdCard(index: 1)
}
