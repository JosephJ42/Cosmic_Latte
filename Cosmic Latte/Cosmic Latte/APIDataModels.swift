//
//  APIDataModels.swift
//  Cosmic Latte
//
//  Created by Joseph Jarvis on 18/03/2022.
//

import Foundation
import CoreLocation

//Data model for moon phase and cloud coverage data
public struct moonAndClouds : Hashable {
    
    let moonPhase: Double
    let cloudCover: Int
    
    init(response: moonAndWeatherAPIResponse){
        
        moonPhase = response.moonAndCloud.moon_phase
        cloudCover = response.moonAndCloud.clouds
    }
}
// data model for plants and their visibility

public struct planets: Hashable{
    let planetName : String
    let visible: Bool
    
    init(response: viewablePlanetsAPIResponse) {
        planetName = "\(response.planetsData.name)"
        visible = response.planetsData.aboveHorizon
    }
}

public struct spaceNews: Hashable{
    let title: String
    let url: String
    let imageUrl: String
    let newsSite: String
    let summary : String
    
    init(response: spaceNewsAPIResponse){
        title = response.SpaceNewsMain.title 
        url = response.SpaceNewsMain.url
        imageUrl = response.SpaceNewsMain.imageUrl
        newsSite = response.SpaceNewsMain.newsSite
        summary = response.SpaceNewsMain.summary
        
    }
}

//
//

