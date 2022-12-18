//
//  HomeListItemView.swift
//  Estarta_iOS_Test
//
//  Created by Magdy Khaled on 16/12/2022.
//

import SwiftUI
import Combine
struct HomeListItemView: View {
  
    var result :Result?
    var body: some View {
        ZStack(alignment:.leading) {
            Color(hex: Color.extraLightGray)
            HStack(alignment: .center,spacing: 12) {
                ImageView(withURL: result?.imageUrls?[0] ?? "")
                    .scaledToFit()
                    
                    .cornerRadius(12)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .padding()
                    
                    
                VStack(alignment: .leading) {
                    Text(result?.name ?? "")
                        .font(.system(size: 20, weight: .bold, design: .default))
                    
                    HStack(alignment: .center, spacing: 6){
                        Text("price:")
                            .font(Font.system(size: 15))
                        let price  = result?.price?.split(separator: " ")
                        let priceText = ("\(price?[1] ?? " ") ") + (price?[0] ?? "")
                        Text(priceText)
                            .font(.system(size: 15, weight: .bold, design: .default))
                    }
                    
                }
            }.padding(.leading, 8)
                
           
        }.frame(height: 180)
            .cornerRadius(15)
            .padding(.horizontal, 12)
        
    }
    
    
    
}

struct HomeListItemView_Previews: PreviewProvider {
    static var previews: some View {
        HomeListItemView()
    }
}
