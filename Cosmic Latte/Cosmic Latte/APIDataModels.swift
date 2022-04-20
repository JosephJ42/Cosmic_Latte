//
//  APIDataModels.swift
//  Cosmic Latte
//
//  Created by Joseph Jarvis on 18/03/2022.
//

import Foundation

public struct moonAndClouds{
    let moonPhase: [Double]
    let cloudCover: [Int]
    
    init(response: moonAndWeatherAPIResponse){
        moonPhase = response.moonAndCloud.moon_phase
        cloudCover = response.moonAndCloud.clouds
        
    }
    
}

public struct planets{
    let planetName : [String]
    let visiable: [Bool]
    
    init (response: viewablePlanetsAPIResponse){
        planetName = response.planetInfo.name
        visiable = response.planetInfo.aboveHorizon
    }
    
    
    
}

public struct spaceNews{
    let title: [String]
    let url: [String]
    let imageUrl: [String]
    let newsSite: [String]
    let summary : [String]
    let publishedAt: [String]
    
    init (response: spaceNewsAPIResponse ){
        title = response.SpaceNewsMain.title
        url = response.SpaceNewsMain.url
        imageUrl = response.SpaceNewsMain.imageUrl
        newsSite = response.SpaceNewsMain.newsSite
        summary = response.SpaceNewsMain.summary
        publishedAt = response.SpaceNewsMain.publishedAt
        
    }
    
    
    
    
    
}
