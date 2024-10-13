//
//  ContentViewModel.swift
//  PhotoChoice2
//
//  Created by Garrett Post on 4/9/24.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var filterShowing = false
    @Published var infoShowing = false
    @Published var stackShowing = false
    @Published var supportShowing = false
    @Published var storeVM = SupportViewModel()
}
