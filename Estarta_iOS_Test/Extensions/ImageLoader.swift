//
//  SwiftUIView.swift
//  Estarta_iOS_Test
//
//  Created by Magdy Khaled on 16/12/2022.
//

import SwiftUI

class ImageLoader: ObservableObject {
    
    @Published var image: UIImage?
    @Published var showingProgress: Bool?
    
    var urlString: String?

    init(urlString: String?) {
        self.urlString = urlString
        loadImage()
    }
    
    func loadImage() {
        loadImageFromUrl()
    }

    func loadImageFromUrl() {
        
        guard let urlString = urlString else {
            return
        }

        if let url = URL(string: urlString) {
            showingProgress = true
            let task = URLSession.shared.dataTask(with: url, completionHandler: getImageFromResponse(data:response:error:))
            task.resume()
        }
    }

    func getImageFromResponse(data: Data?, response: URLResponse?, error: Error?) {
        guard error == nil else {
            return
        }
        
        guard let data = data else {
            return
        }
        
        DispatchQueue.main.async {
            guard let loadedImage = UIImage(data: data) else {
                return
            }
            
            self.image = loadedImage
            self.showingProgress = false
        }
        
    }
    
}



struct ImageView: View {
    @ObservedObject var imageLoader: ImageLoader
     
    init(withURL url: String) {
        imageLoader = ImageLoader(urlString:url)
    }
    
    var body: some View {
        ZStack {
            Image(uiImage: ((imageLoader.image ?? UIImage(named: "icons8-image-file")) ?? UIImage()))
                .resizable()
                .aspectRatio(contentMode: .fit)
            ProgressView()
                .frame(width: UIScreen.main.bounds.width / 2,
                       height: UIScreen.main.bounds.height / 2)
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(imageLoader.showingProgress ?? false ? 1 : 0)
        }
    }
    
}

