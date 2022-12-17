//
//  AppNavigation.swift
//  Estarta_iOS_Test
//
//  Created by Magdy Khaled on 17/12/2022.
//

import SwiftUI

struct AppNavigation<Content>: View where Content: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var navTitle: String
    var isBlack: Bool = true
    var isBack: Bool = true
    var content: (() -> Content)? = nil

    var body: some View {
        NavigationView {
            content?()
        }
        .background(NavigationConfiguration())
        .navigationTitle(Text(navTitle))
        .foregroundColor(.black)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    if isBack {
                        Image("black_back_icon", bundle: .main)
                            .foregroundColor(isBlack ? Color.black : Color.white)
                    }
                }
            }
        }
    }
}


struct NavigationConfiguration: UIViewControllerRepresentable {
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.shadowColor = .clear
        navBarAppearance.backgroundColor = .clear
        UINavigationBar.appearance().standardAppearance = navBarAppearance
    }
    
    func makeUIViewController(
        context: UIViewControllerRepresentableContext<NavigationConfiguration>
    ) -> UIViewController {
        UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController,
                                context: UIViewControllerRepresentableContext<NavigationConfiguration>) {}
    
}
class Model: ObservableObject {
    @Published var pushed = false
}
