//
//  OnboardView.swift
//  PhotoChoice2
//
//  Created by Garrett Post on 4/2/24.
//

import SwiftUI

struct OnboardView: View {
    @State var showing: Int = 0
    @AppStorage("userOnboarded") var userOnboarded: Bool = false
    @State var loadWidth: CGFloat = 0
    var screenSize = UIScreen.main.bounds.size
    
    func calculateScreenSize() -> CGFloat {
        return screenSize.width * CGFloat(Float(showing)) / 9.7
    }
    
//    Onboarding
    var body: some View {
        ZStack {
            ZStack {
                Color.BG
                    .opacity(10)
                    .ignoresSafeArea()
                VStack {
                    Color.appBlue
                        .frame(width: loadWidth)
                        .foregroundStyle(Color.appBlue)
                        .ignoresSafeArea()
                }
                .onAppear {
                    withAnimation {
                        loadWidth = calculateScreenSize()
                    }
                }
                
                VStack {
                    if showing == 0 {
                        VStack {
                            HStack {
                                Image(uiImage: .onboardIntro)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenSize.width / 1.2)
                                    .clipShape(RoundedRectangle(cornerRadius: 30))
                            }
                            Spacer()
                                .frame(height: 60)
                        }
                    }
                }
                
                VStack {
                    if showing == 1 {
                        VStack {
                            HStack {
                                Image(uiImage: .onboard1)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenSize.width / 1.2)
                                    .clipShape(RoundedRectangle(cornerRadius: 30))
                            }
                            Spacer()
                                .frame(height: 60)
                        }
                    }
                }
                
                VStack {
                    if showing == 2 {
                        VStack {
                            HStack {
                                Image(uiImage: .onboard2)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenSize.width / 1.2)
                                    .clipShape(RoundedRectangle(cornerRadius: 30))
                            }
                            Spacer()
                                .frame(height: 60)
                        }
                    }
                }
                
                VStack {
                    if showing == 3 {
                        VStack {
                            HStack {
                                Image(uiImage: .onboard3)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenSize.width / 1.2)
                                    .clipShape(RoundedRectangle(cornerRadius: 30))
                            }
                            Spacer()
                                .frame(height: 60)
                        }
                    }
                }
                
                VStack {
                    if showing == 4 {
                        VStack {
                            HStack {
                                Image(uiImage: .onboard4)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenSize.width / 1.2)
                                    .clipShape(RoundedRectangle(cornerRadius: 30))
                            }
                            Spacer()
                                .frame(height: 60)
                        }
                    }
                }
                
                VStack {
                    if showing == 5 {
                        VStack {
                            HStack {
                                Image(uiImage: .onboard5)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenSize.width / 1.2)
                                    .clipShape(RoundedRectangle(cornerRadius: 30))
                            }
                            Spacer()
                                .frame(height: 60)
                        }
                    }
                }
                
                VStack {
                    if showing == 6 {
                        VStack {
                            HStack {
                                Image(uiImage: .onboard6)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenSize.width / 1.2)
                                    .clipShape(RoundedRectangle(cornerRadius: 30))
                            }
                            Spacer()
                                .frame(height: 60)
                        }
                    }
                }
                
                VStack {
                    if showing == 7 {
                        VStack {
                            HStack {
                                Image(uiImage: .onboard7)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenSize.width / 1.2)
                                    .clipShape(RoundedRectangle(cornerRadius: 30))
                            }
                            Spacer()
                                .frame(height: 60)
                        }
                    }
                }
                
                VStack {
                    if showing == 8 {
                        VStack {
                            HStack {
                                Image(uiImage: .onboard8)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenSize.width / 1.2)
                                    .clipShape(RoundedRectangle(cornerRadius: 30))
                            }
                            Spacer()
                                .frame(height: 60)
                        }
                    }
                }
                
                VStack {
                    if showing == 9 {
                        VStack {
                            HStack {
                                Image(uiImage: .onboard9)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenSize.width / 1.2)
                                    .clipShape(RoundedRectangle(cornerRadius: 30))
                            }
                            Spacer()
                                .frame(height: 60)
                        }
                    }
                }
                
                
                VStack {
                    if showing == 10 {
                        VStack {
                            HStack {
                                Image(uiImage: .onboardOutro)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenSize.width / 1.2)
                                    .clipShape(RoundedRectangle(cornerRadius: 30))
                            }
                            Spacer()
                                .frame(height: 60)
                        }
                    }
                }
            }
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }
        .onTapGesture {
            if showing < 10 {
                showing += 1
            } else {
                userOnboarded = true
            }
            
            withAnimation {
                loadWidth = calculateScreenSize()
            }
        }
    }
}



#Preview {
    OnboardView()
}
