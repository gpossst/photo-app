//
//  GalleryView.swift
//  PhotoChoice2
//
//  Created by Garrett Post on 4/10/24.
//

import SwiftUI
import Photos
import _AVKit_SwiftUI

struct GalleryView: View {
    @EnvironmentObject var photos: PhotosModel
    @StateObject var viewModel = GalleryViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.BG
                .ignoresSafeArea()
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 2),
                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 2),
                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 2)
                ], spacing: 2) {
                    ForEach(viewModel.items, id: \.self) { asset in
                        GalleryItemView(asset: asset)
                            .environmentObject(viewModel)
                    }
                }
                .padding(2)
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        photos.removeFromToDelete(array: viewModel.toRemove)
                        viewModel.items = photos.getPhotosToDeleteAssets()
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10000)
                                .foregroundStyle(.appBlue)
                                .frame(width: 140, height: 60)
                            HStack {
                                Text("Remove")
                                    .font(.title2)
                                    .bold()
                                    .foregroundStyle(.BG)
                            }
                            .padding()
                        }
                    })
                }
                .padding()
            }
            
            VStack {
                Spacer()
                HStack {
                    Button(action: {
                        dismiss()
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10000)
                                .foregroundStyle(.appRed)
                                .frame(width: 140, height: 60)
                            HStack {
                                Text("Close")
                                    .font(.title2)
                                    .bold()
                                    .foregroundStyle(.BG)
                            }
                            .padding()
                        }
                    })
                    Spacer()
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.items = photos.getPhotosToDeleteAssets()
            print(viewModel.items.count)
        }
    }
}

#Preview {
    GalleryView()
        .environmentObject(PhotosModel())
}
