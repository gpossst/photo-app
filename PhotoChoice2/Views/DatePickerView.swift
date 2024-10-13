//
//  DatePickerView.swift
//  PhotoChoice2
//
//  Created by Garrett Post on 4/3/24.
//

import SwiftUI

struct DatePickerView: View {
    @EnvironmentObject var model: PhotosModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.BG
                .ignoresSafeArea()
            
            VStack {
                DatePicker("Date Filter:", selection: $model.toDate, in: ...Date(timeIntervalSince1970: Date().timeIntervalSince1970 + (60*60*24)), displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .onChange(of: model.toDate) {
                        model.changeDates()
                    }
                    .padding()
                    .tint(.appRed)
                    .foregroundStyle(.appGreen)
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
    }
}

#Preview {
    DatePickerView()
        .environmentObject(PhotosModel())
}

