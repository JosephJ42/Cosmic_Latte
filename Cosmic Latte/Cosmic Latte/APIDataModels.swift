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
        var moonPhase: [Double] = []
        var cloudCover: [Int] = []

        init(response: moonAndWeatherAPIResponse){
            
            response.daily.forEach{ instance in
                
                moonPhase.append(instance.moon_phase)
                cloudCover.append(instance.clouds)
            }
        //print(moonPhase)
        //print(cloudCover)
        }
    }

// data model for plants and their visibility

public struct planets: Hashable{
    
    var planetName : [String] = []

    
    init(response: viewablePlanetsAPIResponse) {
        
        response.data.forEach { name in
            
            planetName.append(name.name)
        }
        
        //print(planetName)
           
    }
}

public struct spaceNews{
    
    var title: [String] = []
    var  url: [String] = []
    var  imageUrl: [String] = []
    var  newsSite: [String] = []
    var  summary : [String] = []
    
    init(response: [SpaceNewsAPIMain]){
        
        
        response.forEach{ article in
            
            title.append(article.title ?? "")
            
            url.append(article.url ?? "")
            
            imageUrl.append(article.imageUrl ?? "")
            
            newsSite.append(article.newsSite ?? "")
            
            summary.append(article.summary ?? "")
        }
        
    }
}
