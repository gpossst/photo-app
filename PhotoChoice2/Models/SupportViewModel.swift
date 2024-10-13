//
//  SupportViewModel.swift
//  PhotoChoice2
//
//  Created by Garrett Post on 4/14/24.
//

import Foundation
import StoreKit

class SupportViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var purchasedIds: [String] = []
    
    func fetchProducts() {
        Task {
            do {
                let products = try await Product.products(for: ["SwiftUI.PhotoChoice2.NoAds"])
                DispatchQueue.main.async {
                    self.products = products
                }
                
                if let product = products.first {
                    await isPurchased(product: product)
                }
            } catch {
                print(error)
            }
        }
    }
    
    func isPurchased(product: Product) async {
        guard let state = await product.currentEntitlement else {
            return
        }
        
        switch state {
        case .verified(let transaction):
            DispatchQueue.main.async {
                self.purchasedIds.append(transaction.productID)
            }
        case .unverified(_, _):
            break
        }
    }
    
    func purchase() {
        Task {
            guard let product = self.products.first else { return }
            print(products)
            do {
                let result = try await product.purchase()
                switch result {
                case .success(let verification):
                    switch verification {
                    case .unverified(_, _):
                        break
                    case .verified(let transaction):
                        print(transaction.productID)
                    }
                case .userCancelled:
                    break
                case .pending:
                    break
                @unknown default:
                    break
                }
            } catch {
                print(error)
            }
                
        }
    }
}
