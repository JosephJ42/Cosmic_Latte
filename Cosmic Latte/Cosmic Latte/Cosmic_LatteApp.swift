//
//  Cosmic_LatteApp.swift
//  Cosmic Latte
//
//  Created by Joseph Jarvis on 04/04/2022.
//

import SwiftUI

@main
struct Cosmic_LatteApp: App {
    var body: some Scene {
        WindowGroup {
            

            let moonAndCloudCoverage = moonAndWeatherAPI()
            
            let moonAndCloudCoverageViewModel = moonViewModel(moonAndClouds: moonAndCloudCoverage)
            
            let planets = planetAPI()
            let planetsViewModel = planetViewModel(planets: planets)
            
            
            let spaceNews = spaceNewsAPI()
            let spaceNewsViewModel = spaceNewsViewModel(spaceNews: spaceNews)
            
            ContentView( moonAndCloudCoverageViewModel: moonAndCloudCoverageViewModel,
                         planetsViewModel: planetsViewModel, spaceNewsViewModel: spaceNewsViewModel)
            

        }
    }
}
