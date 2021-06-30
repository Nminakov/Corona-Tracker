//
//  APICaller.swift
//  Cororna Tracker
//
//  Created by Никита on 28.06.2021.
//

import Foundation

class APICaller{
    static let shared = APICaller()
    
    private init(){}
    
    private struct Constants{
        static let allStatesUrl = URL(string: "https://api.covidtracking.com/v2/states.json")
    }
    
    enum DataScope{
        case national
        case state(State)
    }
    
    public func getCovidData(
        for scope: DataScope,
        complition: @escaping (Result<String, Error>) -> Void){
        
    }
    
    public func getStateList(complition: @escaping (Result<[State], Error>) -> Void){
        guard let url = Constants.allStatesUrl else {
            return
        }
        let task = URLSession.shared.dataTask(with: url){
            data, _, error in
            guard let data = data, error == nil else { return }
            
            do{
                let result = try JSONDecoder().decode(StateListResponse.self, from: data)
                let states = result.data
                complition(.success(states))
            } catch{
                complition(.failure(error))
            }
        }
        
        task.resume()
    }
}

struct StateListResponse: Codable {
    let data: [State]
}


struct State: Codable {
    let name: String
    let state_code: String
}


