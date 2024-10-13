//
//  ContentView.swift
//  PhotoChoice2
//
//  Created by Garrett Post on 3/4/24.
//

import SwiftUI
import Photos

struct ContentView: View {
    @AppStorage("userOnboarded") var userOnboarded: Bool = false
    @StateObject var photos = PhotosModel()
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        ZStack {
            Color.BG
                .ignoresSafeArea()
            VStack {
                if photos.errorString == "" {
                    ZStack {
                        if photos.photoArray.count > 0 {
                            Text("You have no more photos!")
                            
                            if photos.photoArray.count > 1 {
                                if photos.photoArray[1].asset.mediaType == .video {
                                    VideoThumbnailView(playerItem: (photos.photoArray[1] as! BetterVideo).video)
                                        .environmentObject(photos)
                                } else {
                                    ImageView(asset: photos.photoArray[1] as! BetterUIImage)
                                        .environmentObject(photos)
                                }
                            }
                            
                            if photos.photoArray[0].asset.mediaType == .video {
                                VideoCardView(asset: photos.photoArray[0] as! BetterVideo)
                                    .environmentObject(photos)
                            } else {
                                ImageView(asset: photos.photoArray[0] as! BetterUIImage)
                                    .environmentObject(photos)
                            }
                            
                            if photos.showAd && viewModel.storeVM.purchasedIds.isEmpty {
                                NativeAdCard(index: photos.getCurrentIndex())
                                    .environmentObject(photos)
                            }
                            
                            if !photos.showAd || !viewModel.storeVM.purchasedIds.isEmpty {
                                ButtonsView(asset: photos.photoArray[0])
                                    .environmentObject(photos)
                            }
                            
                            VStack {
                                HStack {
                                    ListToggleView()
                                        .environmentObject(viewModel)
                                        .environmentObject(photos)
                                }
                                Spacer()
                            }
                        } else {
                            Text("You have no photos!")
                        }
                        
                        if viewModel.storeVM.purchasedIds.isEmpty {
                            VStack {
                                
                                //                            Test: "ca-app-pub-3940256099942544/2435281174"
                                //                            Release: "ca-app-pub-3984797860990299/4078386706"
                                BannerAd(unitID: "ca-app-pub-3984797860990299/4078386706")
                                    .frame(height: 50)
                                Spacer()
                            }
                        }
                        
                        if !userOnboarded {
                            OnboardView()
                                .onTapGesture {
                                    //                                userOnboarded = true
                                }
                        }
                    }
                    .sheet(isPresented: $viewModel.filterShowing, onDismiss: {photos.changeDates()}) {
                        DatePickerView()
                            .environmentObject(photos)
                    }
                    .sheet(isPresented: $viewModel.infoShowing, content: {
                        InfoView()
                    })
                    .sheet(isPresented: $viewModel.stackShowing) {
                        GalleryView()
                            .environmentObject(photos)
                    }
                    .sheet(isPresented: $viewModel.supportShowing) {
                        SupportView()
                            .environmentObject(viewModel.storeVM)
                    }
                }
                else
                {
                    Text("You've given us no access to your photos! Please go to your device's settings -> PhotoSwipe -> Photos. Then give us Full or Limited Access. We remind you that all operations on your photos are completely local and nobody but you can access them.")
                        .padding(50)
                        .multilineTextAlignment(.center)
                }
            }
        }
        .onAppear {
            viewModel.storeVM.fetchProducts()
        }
    }
}

#Preview {
    ContentView()
}
