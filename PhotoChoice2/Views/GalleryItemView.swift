//
//  GalleryItemView.swift
//  PhotoChoice2
//
//  Created by Garrett Post on 4/10/24.
//

import SwiftUI
import Photos

struct GalleryItemView: View {
    var asset: BetterUIImage
    @State var padded = false
    @EnvironmentObject var viewModel: GalleryViewModel
    
    var body: some View {
        ZStack {
            Image(uiImage: asset.image)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .padding(padded ? 10 : 0)
            if padded {
                Color.gray.opacity(0.25)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Image(systemName: "checkmark")
                            .resizable()
                            .frame(width: 10, height: 10)
                            .padding(3)
                            .foregroundStyle(.appBlue)
                    }
                }
                
            }
        }
        .onTapGesture {
            if !viewModel.toRemove.contains(asset) {
                viewModel.toRemove.append(asset)
            } else {
                if let index = viewModel.toRemove.firstIndex(of: asset) {
                    viewModel.toRemove.remove(at: index)
                }
            }
            
            withAnimation {
                padded.toggle()
            }
        }
    }
}

#Preview {
    GalleryItemView(asset: BetterUIImage(image: UIImage(), asset: PHAsset()))
}
