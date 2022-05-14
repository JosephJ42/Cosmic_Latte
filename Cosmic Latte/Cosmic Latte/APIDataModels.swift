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
        
        moonPhase = response.daily.first?.moon_phase ?? 0.00
        cloudCover = response.daily.first?.clouds ?? 0
        
    }
}
// data model for plants and their visibility

public struct planets: Hashable{
    let planetName : String
    let visible: Bool
    
    init(response: viewablePlanetsAPIResponse) {
        
        planetName = response.data.first?.name ?? ""
        visible = ((response.data.first?.aboveHorizon) != nil)
        
        
        
//        planetName = "\(response.planetsData.name)"
//        visible = response.planetsData.aboveHorizon
    }
}

public struct spaceNews{
    
    let title: String
    let url: String
    let imageUrl: String
    let newsSite: String
    let summary : String
    
    init(response: spaceNewsAPIResponse){
        
        title = response.title ?? ""
        url = response.url ?? ""
        imageUrl = response.imageUrl ?? ""
        newsSite = response.newsSite ?? ""
        summary = response.summary ?? ""
        

        
        
        
        
//        title = response.Article.first?.title ?? ""
//        url = response.Article.first?.url ?? ""
//        imageUrl = response.Article.first?.imageUrl ?? ""
//        newsSite = response.Article.first?.newsSite ?? ""
//        summary = response.Article.first?.summary ?? ""
            
    }
}

// old code, clean up before submission
//

//        title = response.SpaceNewsMain.title
//        url = response.SpaceNewsMain.url
//        imageUrl = response.SpaceNewsMain.imageUrl
//        newsSite = response.SpaceNewsMain.newsSite
//        summary = response.SpaceNewsMain.summary
