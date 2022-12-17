//
//  SplashView.swift
//  Estarta_iOS_Test
//
//  Created by Magdy Khaled on 16/12/2022.
//

import SwiftUI

struct SplashView: View {
    
    @State private var isActive = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                ZStack(alignment: .center) {
                    Color.white.ignoresSafeArea()
                    Image("splashLogo")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width * 0.9 ,height: 150)
                }
            }.navigationDestination(isPresented: $isActive){
                HomeView()
            }
            .onAppear(perform: {
                self.gotoLoginScreen(time: 1.5)
            })
        }
    }
    
    func gotoLoginScreen(time: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(time)) {
            self.isActive = true
        }
    }
}

