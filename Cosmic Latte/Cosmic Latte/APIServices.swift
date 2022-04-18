//
//  apiServices.swift
//  Cosmic Latte
//
//  Created by joseph jarvis on 18/03/2022.
//

import Foundation
import CoreLocation

//Moon and cloud cover API request based on location

public final class moonAndWeatherAPI: NSObject {
    
    private let getLocation = CLLocationManager()
    private let moonAndWeatherAPIKey = "fb4536a4745851c5a49cfcb7a2a5b13f"
    private var completionHandler: (()-> Void)?
    
}


struct moonAndWeatherAPIResponse: Decodable{
    let name: String
    let main: moonAndWeatherAPIMain
    let moonAndWeather: [APIMoonAndWeather]
}

struct moonAndWeatherAPIMain: Decodable {
    
    
}

struct APIMoonAndWeather : Decodable{
    
    
    
}

//Plant API Request based on location

public final class planetAPI: NSObject {
    
    private let getLocation = CLLocationManager()
    private var completionHandler: (()-> Void)?
    
}

struct viewablePlantsAPIResponse: Decodable{
    let name: String
    let main: plantsAPIMain
    let plants: [APIplants]
}

struct plantsAPIMain: Decodable {
    
    
}

struct APIplants : Decodable{
    let description: String
    
}


// Space news API

public final class spaceNewsAPI: NSObject {
    
    private var completionHandler: (()-> Void)?
    
}

struct spaceNewsAPIResponse: Decodable{
    let name: String
    let main: spaceNewsAPIMain
    let spaceNews: [APISpaceNews]
}

struct spaceNewsAPIMain: Decodable {
    
    
}

struct APISpaceNews : Decodable{
    
    
}
