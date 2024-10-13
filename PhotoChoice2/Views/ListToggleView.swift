//
//  ListToggleView.swift
//  PhotoChoice2
//
//  Created by Garrett Post on 4/7/24.
//

import SwiftUI

struct ListToggleView: View {
    @StateObject var model = ListToggleViewModel()
    @EnvironmentObject var envModel: ContentViewModel
    @EnvironmentObject var photosModel: PhotosModel
    
    
    var body: some View {
        ZStack {
            HStack {
                VStack {
                    Spacer()
                    Image(systemName: "arrow.uturn.backward")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color(uiColor: .BG))
                        .padding(20)
                        .background{
                            Circle()
                                .foregroundStyle(.appBlue)
                        }
                        .onTapGesture {
                            withAnimation {
                                photosModel.undoSwipe()
                            }
                        }
                    .padding()
                    .padding(.bottom, -30)
                }
                Spacer()
            }
            
            if model.isToggled {
                Color.BG
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            model.isToggled.toggle()
                        }
                    }
            }
            
            HStack {
                if !model.isToggled {
                    Spacer()
                }
                VStack {
                    Spacer()
                    Image(systemName: model.isToggled ? "xmark" : "line.3.horizontal")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color(uiColor: .BG))
                        .padding(20)
                        .background{
                            Circle()
                                .foregroundStyle(.appBlue)
                        }
                        .rotationEffect(.degrees(model.isToggled ? -180 : 0))
                        .onTapGesture {
                            withAnimation {
                                model.isToggled.toggle()
                            }
                        }
                    .padding()
                    .padding(.bottom, -30)
                }
            }
            
            VStack {
                VStack {
                    if model.isToggled {
                        if envModel.storeVM.purchasedIds.isEmpty {
                            GroupBox {
                                Text("Remove Ads")
                            }
                            .font(.custom("Reem Kufi Fun", size: 40))
                            .bold()
                            .foregroundStyle(.BG)
                            .backgroundStyle(.appRed)
                            .onTapGesture {
                                envModel.supportShowing = !envModel.supportShowing
                                withAnimation {
                                    model.isToggled.toggle();
                                }
                            }
                            .padding(.bottom, 20)
                        }
                        
                        GroupBox {
                            Text("Filter")
                        }
                        .font(.custom("Reem Kufi Fun", size: 40))
                        .bold()
                        .foregroundStyle(.BG)
                        .backgroundStyle(.appBlue)
                        .onTapGesture {
                            envModel.filterShowing = !envModel.filterShowing
                            withAnimation {
                                model.isToggled.toggle();
                            }
                        }
                        
                        GroupBox {
                            Text("Stack")
                        }
                        .font(.custom("Reem Kufi Fun", size: 40))
                        .bold()
                        .foregroundStyle(.BG)
                        .backgroundStyle(.appBlue)
                        .onTapGesture {
                            envModel.stackShowing = !envModel.stackShowing
                            withAnimation {
                                model.isToggled.toggle();
                            }
                        }
                        .padding(.vertical, 20)
                        
                        GroupBox {
                            Text("Clear")
                        }
                        .font(.custom("Reem Kufi Fun", size: 40))
                        .bold()
                        .foregroundStyle(.BG)
                        .backgroundStyle(.appBlue)
                        .onTapGesture {
                            photosModel.deletePhoto()
                            
                            withAnimation {
                                model.isToggled.toggle();
                            }
                        }
                        .padding(.bottom, 20)
                        
                        GroupBox {
                            Text("Info")
                        }
                        .font(.custom("Reem Kufi Fun", size: 40))
                        .bold()
                        .foregroundStyle(.BG)
                        .backgroundStyle(.appBlue)
                        .onTapGesture {
                            envModel.infoShowing = !envModel.infoShowing
                            
                            withAnimation {
                                model.isToggled.toggle();
                            }
                        }
                    }
                }
                .frame(height: model.isToggled ? nil : 0, alignment: .bottom)
                .clipped()
            }
        }
    }
}

#Preview {
    ListToggleView()
        .environmentObject(ContentViewModel())
}
