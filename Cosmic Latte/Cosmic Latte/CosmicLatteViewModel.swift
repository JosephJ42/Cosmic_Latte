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
    @Published var prediction : String = ""
    
    public let moonAndClouds: moonAndClouds
    
    public init (moonAndClouds: moonAndClouds){
        
        self.moonAndClouds = moonAndClouds
    }
    
    public func newsRefresh(){
        moonAndWeatherAPI().getUsersLocation { moonAndCloudsInfo in DispatchQueue.main.async{
            self.moonPhase =  moonPhaseCalculator(moonPhase: moonAndCloudsInfo.moonPhase)
            self.cloudCover = cloudCoverageCalculator(cloudCover: moonAndCloudsInfo.cloudCover)
            self.prediction = stargazingPrediction(moonPhase: moonAndCloudsInfo.moonPhase, cloudCover: moonAndCloudsInfo.cloudCover)
        }
    }
}
}

public func stargazingPrediction( moonPhase: Double, cloudCover: Int) -> String {
    
    var prediction: String = ""
    var moonPhaseScore: Double
    var cloudCoverScore : Double
    
    var moonPhaseText: String = moonPhaseCalculator(moonPhase: moonPhase)
    
    switch moonPhaseText{
        
    case "New Moon":
        moonPhaseScore = 100
    case "Waning Crescent":
        moonPhaseScore = 75
    case "Waxing Crescent":
        moonPhaseScore = 75
    case "Last Quarter":
        moonPhaseScore = 50
    case "First Quarter":
        moonPhaseScore = 50
    case "Waning Gibbous":
        moonPhaseScore = 25
    case "Waxing Gibbous":
        moonPhaseScore = 25
    case "Full Moon":
        moonPhaseScore = 1
    default:
        moonPhaseScore = 1
    }
    
    //
    
    var cloudCoverText: String = cloudCoverageCalculator(cloudCover: cloudCover)
    
    switch cloudCoverText{
        
    case "Clear Skys":
        cloudCoverScore = 100
        
    case "Partly Cloudy":
        cloudCoverScore = 50
        
    case "Overcast":
        cloudCoverScore = 1
        
    default:
        cloudCoverScore = 1
    }
    
    // Prediction Caculations
    var cloudCoverageCalcValue: Double = cloudCoverScore/100
    var moonValueCalcValue: Double = moonPhaseScore/100
    var predictionCalculatedValue : Double = (50*cloudCoverageCalcValue)+(50*moonValueCalcValue)


    switch predictionCalculatedValue{
        case 0...20:
            prediction = "Bad"
         
        case 21...40:
            prediction = "Poor"
            
        case 41...60:
            prediction = "Fair"
            
        case 61...80:
            prediction = "Good"
            
        case 81...100:
            prediction = "Great"
        
    default:
        prediction = "Prediction engine has broken or gone out of bounds"
        print("Prediction engine has broken or gone out of bounds")
    }
    
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
            moonPhaseString = "First Quarter"
        
        case 0.26 ... 0.49:
            moonPhaseString = "Waxing Gibbous"
        
        case 0.5:
            moonPhaseString = "Full Moon"
        
        case 0.51 ... 0.74:
            moonPhaseString = "Waning Gibbous"
        
        case 0.75:
            moonPhaseString = "Last Quarter"
        
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






