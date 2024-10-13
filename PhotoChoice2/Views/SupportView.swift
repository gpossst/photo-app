//
//  SupportView.swift
//  PhotoChoice2
//
//  Created by Garrett Post on 4/14/24.
//

import SwiftUI

struct SupportView: View {
    @EnvironmentObject var viewModel: SupportViewModel
    
    var body: some View {
        ZStack {
            Color.BG
                .ignoresSafeArea()
            VStack {
                if let product = viewModel.products.first {
                    Text("\(product.displayName):")
                        .font(.custom("Reem Kufi Fun", size: 40))
                        .bold()
                        .foregroundStyle(.appBlue)
                        .padding(.bottom, -5)
                    
                    Text("By buying no ads, you're supporting us! We'll also remove all of the ads in your app.")
                        .padding(40)
                        .font(.custom("Reem Kufi Fun", size: 20))
                        .foregroundStyle(.appBlue)
                    
                    Button(action: {
                        if viewModel.purchasedIds.isEmpty {
                            viewModel.purchase()
                        }
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10000)
                                .foregroundStyle(.appRed)
                                .frame(width: 220, height: 60)
                            HStack {
                                Text(viewModel.purchasedIds.isEmpty ? "Purchase (\(product.displayPrice))" : "Purchased")
                                    .font(.title2)
                                    .bold()
                                    .foregroundStyle(.BG)
                            }
                            .padding()
                        }
                    })
                    .padding()
                }
            }
        }
        .onAppear {
            viewModel.fetchProducts()
        }
    }
}

#Preview {
    SupportView()
}
