//
//  HomeView.swift
//  Estarta_iOS_Test
//
//  Created by Magdy Khaled on 16/12/2022.
//

import SwiftUI
import Combine

struct HomeView: View {
    
    var viewModel = HomeViewModel()
    @State var cancellable: AnyCancellable?
    @State var error = ""
    @State var showingProgress = false
    @State var navigate = false
    @State var isDisabled = false
    @State var results : [Result]?
    @State var selectedResult: Result?
    var body: some View {
        ZStack {
            AppNavigation( navTitle: "HOME", isBlack: true, isBack: false) {
                ZStack {
                    ScrollView (.vertical, showsIndicators: false) {
//                        VStack {
                            if let resultscount = results?.count ?? 0{
                                ForEach(0..<resultscount, id: \.self) { index in
                                   
                                    HomeListItemView(result: results?[index])
                                        .onTapGesture {
                                            print(index)
                                            selectedResult = results?[index]
                                            navigate = true
                                        }
                                    
                                }
                            }
                            
                            Spacer()
//                        }
                        
                    }.onAppear {
                        if results == nil {
                            getData()
                            
                        }
                    }
                    
                    ProgressView()
                        .frame(width: UIScreen.main.bounds.width / 2,
                               height: UIScreen.main.bounds.height / 2)
                        .foregroundColor(Color.primary)
                        .cornerRadius(20)
                        .opacity(self.showingProgress ? 1 : 0)
                }
                .navigationDestination(isPresented: $navigate) {
                    ItemDetailsView(result: selectedResult)
                }
            }
        }
        
    }
    
    private func getData() {
        showingProgress = true
        cancellable = viewModel.getResults()
            .sink { result in
                print(result)
                showingProgress = false
            } receiveValue: { model in
                print(model)
                self.results = model.results
                showingProgress = false
            }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

public extension Color {

    static func random(randomOpacity: Bool = false) -> Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            opacity: randomOpacity ? .random(in: 0...1) : 1
        )
    }
}
