//
//  ItemDetailsView.swift
//  Estarta_iOS_Test
//
//  Created by Magdy Khaled on 16/12/2022.
//

import SwiftUI

struct ItemDetailsView: View {
    var result :Result?
    var body: some View {
        ZStack{
            AppNavigation( navTitle: result?.name?.capitalized ?? "", isBlack: true, isBack: true) {
            ZStack(alignment:.leading) {
                VStack(alignment: .leading,spacing: 12) {
                    ImageView(withURL: result?.imageUrls?[0] ?? "")
                        .frame(height: UIScreen.main.bounds.height * 0.6)
                        .cornerRadius(15)
                    HStack(alignment: .center, spacing: 6){
                        Text(result?.name ?? "")
                            .font(.system(size: 30, weight: .bold, design: .default))
                        
                        Spacer()
                        Text("Price:")
                            .font(Font.system(size: 20))
                        let price  = result?.price?.split(separator: " ")
                        let priceText = ("\(price?[1] ?? " ") ") + (price?[0] ?? "")
                        Text(priceText)
                            .font(.system(size: 20, weight: .bold, design: .default))
                    }
                    
                    Spacer()
                }.padding(.leading, 8)
                
            }
            
            .cornerRadius(15)
            .padding(.horizontal, 12)
        }
        
    }
        
    }
}

struct ItemDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailsView()
    }
}
