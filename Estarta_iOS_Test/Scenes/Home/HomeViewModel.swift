//
//  HomeViewModel.swift
//  DowidarApp
//
//  Created by Magdy Khaled on 20/08/2022.
//

import Foundation
import SwiftUI
import Combine
class HomeViewModel {
    var stringURL = "https://ey3f2y0nre.execute-api.us-east-1.amazonaws.com/default/dynamodb-writer"
    func getResults() -> AnyPublisher<ResultsModel, Error> {
        let url = URL(string: stringURL)
        let request = APIRequest(url: url!, method: .get)
        return NetworkService.shared.execute(request, decodingType: ResultsModel.self, retries: 1)
    }
}
