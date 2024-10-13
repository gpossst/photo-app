//
//  ButtonsView.swift
//  PhotoChoice2
//
//  Created by Garrett Post on 3/4/24.
//

import SwiftUI
import Photos

struct ButtonsView: View {
    @EnvironmentObject var viewModel: PhotosModel
    var asset: BetterAsset
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Button(action: {
                    // delete action passed in
                    viewModel.next()
                    viewModel.appendToPhotosToDelete(asset.asset)
                }, label: {
                    Image(systemName: "plus")
                      .resizable()
                      .rotationEffect(Angle(degrees: 45))
                      .frame(width: 50, height: 50)
                      .foregroundColor(Color(uiColor: .BG))
                      .padding(20)
                      .background{
                          Circle()
                              .foregroundStyle(.appRed)
                      }
                })
                Spacer()
                    .frame(width: 50)
                Button(action: {
                    // save
                    viewModel.next()
                }, label: {
                    Image(systemName: "checkmark")
                      .resizable()
                      .frame(width: 50, height: 50)
                      .foregroundColor(Color(uiColor: .BG))
                      .padding(20)
                      .background{
                          Circle()
                              .foregroundStyle(.appGreen)
                      }
                })
            }
            Spacer()
                .frame(height: 25)
        }
        .padding(.bottom, 30)
    }
}

#Preview {
    ButtonsView(asset: BetterUIImage(image: UIImage(), asset: PHAsset()))
}
