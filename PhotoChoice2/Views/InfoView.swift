//
//  InfoView.swift
//  PhotoChoice2
//
//  Created by Garrett Post on 4/4/24.
//

import SwiftUI
import StoreKit

struct InfoView: View {
    @Environment(\.requestReview) var requestReview
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.BG
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                HStack {
                    ShareLink(item: "https://apps.apple.com/us/app/photoswipe-library-cleaner/id6479256585") {
                        Text("Share")
                            .foregroundStyle(.white)
                            .background(content: {
                                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                    .frame(width: 90, height: 40)
                                    .tint(Color.appBlue)
                            })
                    }
                    Spacer()
                        .frame(width: 80)
                    Button(action: {
                        requestReview()
                    }) {
                        Text("Review")
                            .foregroundStyle(.white)
                            .background(content: {
                                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                    .frame(width: 90, height: 40)
                                    .tint(Color.appBlue)
                            })
                    }
                }
                Spacer()
                    .frame(height: 100)
            }
            
            Image(uiImage: .info)
                .resizable()
                .scaledToFit()
                .frame(width: 350)
            
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
    }
}

#Preview {
    InfoView()
}
