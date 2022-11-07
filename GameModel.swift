//
//  GameModel.swift
//  Weather
//
//  Created by Ludvig Krantzén on 2022-11-07.
//

import Foundation
import Combine

class GameModel: ObservableObject{
    private let urlString = "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&hourly=temperature_2m"
    private var cancellable: Cancellable?
    
    @Published var questions = "ADA"
    
    init() {
    }
    
    func loadQuestions(){
        guard let url = URL(string: urlString) else{
            return
        }
        cancellable = URLSession.shared
            .dataTaskPublisher(for: url)
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { data, response in
                print(String(data: data, encoding: .utf8))
            })
    }
}

