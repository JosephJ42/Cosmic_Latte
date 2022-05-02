//
//  CosmicLatteViewModel.swift
//  Cosmic Latte
//
//  Created by Joseph Jarvis on 20/03/2022.
//

import Foundation

// Moon and Weather

public class moonViewModel : ObservableObject {
    
    @Published var moonPhase : String = ""
    @Published var cloudCover : String = ""
    @Published var prediction : String = "Prediction engine says no"
    
    public let moonAndClouds: moonAndClouds
    
    public init (moonAndClouds: moonAndClouds){
        
        self.moonAndClouds = moonAndClouds
    }
    
    public func newsRefresh(){
        moonAndWeatherAPI().getUsersLocation { moonAndCloudsInfo in DispatchQueue.main.async{
            self.moonPhase =  moonPhaseCalculator(moonPhase: moonAndCloudsInfo.moonPhase)
            self.cloudCover = cloudCoverageCalculator(cloudCover: moonAndCloudsInfo.cloudCover)
            self.prediction = stargazingPrediction(moonPhase: moonAndCloudsInfo.moonPhase, cloudCover: moonAndCloudsInfo.cloudCover).self
        }
    }
}
}

public func stargazingPrediction( moonPhase: Double, cloudCover: Int) -> String {
    
    var prediction: String = ""
    var moonphase: String = moonPhaseCalculator(moonPhase: moonPhase)
    
    
//    var predictionCalculatedValue : Double =  / cloudCover
//
//
//    switch prediction
//
    
    
    
    return prediction
}

public func moonPhaseCalculator( moonPhase: Double) -> String {
    var moonPhaseString: String = ""
    
    switch moonPhase{
        case 0:
            moonPhaseString = "New Moon"
        
        case 0.1 ... 0.24:
            moonPhaseString = "Waxing Crescent"
        
        case 0.25:
            moonPhaseString = "First Quarter Moon"
        
        case 0.26 ... 0.49:
            moonPhaseString = "Waxing Gibous"
        
        case 0.5:
            moonPhaseString = "Full Moon"
        
        case 0.51 ... 0.74:
            moonPhaseString = "Waning Gibous"
        
        case 0.75:
            moonPhaseString = "Last Quarter Moon"
        
        case 0.76 ... 0.99:
            moonPhaseString = "Waning Crescent"
        
        case 1:
            moonPhaseString = "New Moon"

        default:
            moonPhaseString = "No Moon"
    }
    
    return moonPhaseString
}

public func cloudCoverageCalculator(cloudCover: Int) -> String {
    
    var cloudCoverageString: String = ""
    
    switch cloudCover{
        
    case 0...30:
        cloudCoverageString = "Clear Skys"
        
    case 31...69:
        cloudCoverageString = "Partly Cloudy"
        
    case 70...100:
        cloudCoverageString = "Overcast"
        
    default:
        cloudCoverageString = "Clouds be gone"
    }
    
    
    return cloudCoverageString
}

//Planet data

public class planetViewModel:ObservableObject{
    
    @Published var name : String = ""
    @Published var planetVisable : Bool = false
    
    public let planets: planets
    
    public init (planets: planets){
        self.planets = planets
    }
    
    public func planetVisibilityRefresh(){
        self.name = planets.planetName
        self.planetVisable = planets.visible
    }
    
    
}

// Space news

public class spaceNewsViewModel: ObservableObject{
    
    @Published var title: String = "No Title"
    @Published var newsSource : String = "No Source"
    @Published var newsDescription : String = "No description"
    @Published var newsImageUrl : String = ""
    @Published var newsArticleLinkUrl: String = ""
    
    public let spaceNews: spaceNews
    
    public init(spaceNews: spaceNews){
        self.spaceNews = spaceNews
    }
  
    public func newsRefresh(){
        self.title = spaceNews.title
        self.newsSource = spaceNews.newsSite
        self.newsDescription = spaceNews.summary
        self.newsImageUrl = spaceNews.imageUrl
        self.newsArticleLinkUrl = spaceNews.url
        
    }
    
// Old refresh keep got later use
//    public func newsRefresh(){
//        spaceNewsAPI{ spaceNews in DispatchQueue.main.async {
//                self?.title = spaceNews.title
//                self?.newsSource = spaceNews.newsSite
//                self?.newsDescription = spaceNews.summary
//                self?.newsImageUrl = spaceNews.imageUrl
//                self?.newsArticleLinkUrl = spaceNews.url
//            }
//        }
//    }
}






