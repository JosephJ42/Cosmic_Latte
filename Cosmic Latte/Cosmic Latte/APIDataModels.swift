//
//  APIDataModels.swift
//  Cosmic Latte
//
//  Created by Joseph Jarvis on 18/03/2022.
//

import Foundation
import CoreLocation
import SwiftUI

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
    
    var planetName : [String] = []

    
    init(response: viewablePlanetsAPIResponse) {
        
        
        response.data.forEach { name in
            
            planetName.append(name.name)
            
        }
        
        print(planetName)
           
    }
}

public struct spaceNews{
    
    let title: String
    let url: String
    let imageUrl: String
    let newsSite: String
    let summary : String
    
    init(response: SpaceNewsAPIMain){
        
       // print("here")
        
       // print(response.self)
        
        title = response.title ?? ""
        url = response.url ?? ""
        imageUrl = response.imageUrl ?? ""
        newsSite = response.newsSite ?? ""
        summary = response.summary ?? ""
        
//        print(response.newsData.description)
        
//        title = response.newsData.first?.title ?? ""
//        url = response.newsData.first?.url ?? ""
//        imageUrl = response.newsData.first?.imageUrl ?? ""
//        newsSite = response.newsData.first?.newsSite ?? ""
//        summary = response.newsData.first?.summary ?? ""
        
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
