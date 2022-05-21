//
//  CosmicLatteViewModel.swift
//  Cosmic Latte
//
//  Created by Joseph Jarvis on 20/03/2022.
//

import Foundation
import CoreLocation
import MapKit
import SwiftUI



//==================
// Moon and Weather
//==================

public class moonViewModel : ObservableObject {
    
    @Published var condensedPredictionsList: [predictions] = []
    @Published var date: String = "No date"
    @Published var location : String = "No Location"
    @Published var moonPhase : String = "Full Moon"
    @Published var cloudCover : String = "Null"
    @Published var prediction : String = "Null"
    
    public let moonAndClouds: moonAndWeatherAPI
    
    public init (moonAndClouds: moonAndWeatherAPI){
        
        self.moonAndClouds = moonAndClouds
    }
    
    public func refresh(){
        moonAndClouds.getUsersLocation { moonAndCloudsInfo in DispatchQueue.main.async{
            
            self.date = findDate(daysInFuture: 0)
            
            self.location = getLocationString()
            self.moonPhase =  moonPhaseCalculator(moonPhase: moonAndCloudsInfo.moonPhase[0])
            self.cloudCover = cloudCoverageCalculator(cloudCover: moonAndCloudsInfo.cloudCover[0])
            self.prediction = stargazingPrediction(moonPhase: moonAndCloudsInfo.moonPhase[0], cloudCover: moonAndCloudsInfo.cloudCover[0])
            
            self.condensedPredictionsList = getPredictions(moonPhase: moonAndCloudsInfo.moonPhase, condition: moonAndCloudsInfo.cloudCover)
            
        }
    }
}
}

public func getLocationString() -> String {

    let locationManger = getLocation()

    //let location = locationManger.location != nil ? locationManger.location!.coordinate : CLLocationCoordinate2D()
    
    let city : String = locationManger.locationCityGlobal ?? ""
 
    //print("the City is: \(locationManger.locationCityGlobal ?? "")")
    
    return city
}

// The below code has been adepted from the following link
//https://stackoverflow.com/questions/62704004/swiftui-get-city-locality-information-from-users-location
public class getLocation: NSObject, ObservableObject{
    
    private let locationManager = CLLocationManager()
    @Published var location : CLLocation? = nil
    @Published var locationNameGlobal : CLLocation? = nil
    @Published var locationCityGlobal : String? = nil
    @Published var locationCountryNameGlobal : String? = nil
    
    
    override init(){
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
    }
}

extension getLocation: CLLocationManagerDelegate{
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        guard let location = locations.last else{
            return
        }
        
        self.location = location
        
        
        let geoCoder = CLGeocoder()
        let locationToGetName = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude )
        
               geoCoder.reverseGeocodeLocation(locationToGetName, completionHandler:
                   {
                       placemarks, error -> Void in

                       // Place details
                       guard let placeMark = placemarks?.first else { return }

                       // Location name
                       if let locationName = placeMark.location {
                           //print(locationName)
                           self.locationNameGlobal = locationName
                           //print(self.locationNameGlobal!)
                       }
                       // City
                   if placeMark.subAdministrativeArea != nil {
                           //print(city)
                           self.locationCityGlobal = placeMark.subAdministrativeArea!
                           //print(self.locationCityGlobal!)
                          
                       }
                       // Country
                   if placeMark.country != nil {
                           //print(country)
                           self.locationCountryNameGlobal = placeMark.country!
                           //print(self.locationCountryNameGlobal!)
                       }
               })
    }
    
}
//Adepted code ends

//=================================
// Condensed View View Model
//=================================

public class predictionViewModel: ObservableObject {
    
    @Published var condensedPredictionsList: [predictions] = []
    
    public let moonAndClouds: moonAndWeatherAPI
    
    public init (moonAndClouds: moonAndWeatherAPI){
        
        self.moonAndClouds = moonAndClouds
    }
    
    public func predictonRefresh(){
        moonAndClouds.getUsersLocation { predictionInfo in DispatchQueue.main.async{
            
            self.condensedPredictionsList = getPredictions(moonPhase: predictionInfo.moonPhase, condition: predictionInfo.cloudCover)
            
        }
            print("print Predictions: ")
            print(self.condensedPredictionsList)
    
    }
}
}

public func getPredictions(moonPhase : [Double], condition :[Int]) -> [predictions]{
    
    var prediction: predictions
    var predictionArray: [predictions] = []
    
    for i in 0..<8{
        
        let moonPhaseName = moonPhaseCalculator(moonPhase: moonPhase[i])
        let date = findDate(daysInFuture: i)
        let stargazingPrediction =  stargazingPrediction(moonPhase: moonPhase[i], cloudCover: condition[i])
        let cloudCoverage = cloudCoverageCalculator(cloudCover: condition[i])
        
        prediction = predictions(moonPhase: moonPhaseName, date: date, stargazingPrediction: stargazingPrediction, condition: cloudCoverage)

        predictionArray.append(prediction)
    }
    
    print(predictionArray)
    
    return predictionArray
    
}

public struct predictions: Identifiable {
   
    public let id = UUID()
    let moonPhase: String?
    let date: String?
    let stargazingPrediction: String?
    let condition: String?
    
}

// The Below date code was Adapted from :
//https://stackoverflow.com/questions/54084023/how-to-get-the-todays-and-tomorrows-date-in-swift-4

public func findDate (daysInFuture: Int) -> String{
    
    let calendar = Calendar.current
    // Use the following line if you want midnight UTC instead of local time
    //calendar.timeZone = TimeZone(secondsFromGMT: 0)
    let today = Date()
    let midnight = calendar.startOfDay(for: today)
    let tomorrow = calendar.date(byAdding: .day, value: daysInFuture, to: midnight)!
    
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/YYYY"
    
    let formattedDate: String = dateFormatter.string(from: tomorrow)
    
    return formattedDate
}
// end of adapted code


//=================================
// Cosmic Lattes Prediction Engine
//=================================
public func stargazingPrediction( moonPhase: Double, cloudCover: Int) -> String {
    
    var prediction: String = ""
    var moonPhaseScore: Double
    var cloudCoverScore : Double
    
    let moonPhaseText: String = moonPhaseCalculator(moonPhase: moonPhase)
    
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
    
    let cloudCoverText: String = cloudCoverageCalculator(cloudCover: cloudCover)
    
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
    let cloudCoverageCalcValue: Double = cloudCoverScore/100
    let moonValueCalcValue: Double = moonPhaseScore/100
    let predictionCalculatedValue : Double = (50*cloudCoverageCalcValue)+(50*moonValueCalcValue)


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

//======================
// Moon Phase Caculator
//======================
//
//
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
            moonPhaseString = ""
    }
    
    return moonPhaseString
}

//==========================
// Cloud Coverage Caculator
//==========================
//
//
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

//=============
// Planet data
//=============
public class planetViewModel:ObservableObject{
    

    @Published var planetList : String = "No planets"
    
    @Published var isMercuryVisable : Bool = false
    @Published var isVenusVisable : Bool = false
    @Published var isMarsVisable : Bool = false
    @Published var isJupiterVisable : Bool = false
    @Published var isSaturnVisable : Bool = false
    @Published var isUranusVisable : Bool = false
    @Published var isNeptuneVisable : Bool = false
    @Published var isPlutoVisable : Bool = false
    
    public let planets: planetAPI
    
    public init (planets: planetAPI){
        self.planets = planets
    }
    
    public func planetVisibilityRefresh(){
        planets.getUsersLocation { planetInfo in DispatchQueue.main.async{
            
            self.planetList = getPlanetString(planetList: planetInfo.planetName)
            
            self.isMercuryVisable = checkPlanet(planetBeingChecked: "Mercury", planetList: planetInfo.planetName)
            self.isVenusVisable = checkPlanet(planetBeingChecked: "Venus", planetList: planetInfo.planetName)
            self.isMarsVisable = checkPlanet(planetBeingChecked: "Mars", planetList: planetInfo.planetName)
            self.isJupiterVisable = checkPlanet(planetBeingChecked: "Jupiter", planetList: planetInfo.planetName)
            self.isSaturnVisable = checkPlanet(planetBeingChecked: "Saturn", planetList: planetInfo.planetName)
            self.isUranusVisable = checkPlanet(planetBeingChecked: "Uranus", planetList: planetInfo.planetName)
            self.isNeptuneVisable = checkPlanet(planetBeingChecked: "Neptune", planetList: planetInfo.planetName)
            self.isPlutoVisable = checkPlanet(planetBeingChecked: "Pluto", planetList: planetInfo.planetName)
        }
        }
    }
}


public func getPlanetString(planetList: [String]) -> String {
    
    var planetString = "No plants"
    var planetListFiltered : [String]
    
    //removes the moon from the planet list
    if planetList.contains("Moon"){
        
        planetListFiltered = planetList.filter{$0 != "Moon"}
        
    }else{
        
        planetListFiltered = planetList
    }
    
    if planetListFiltered.count == 8{
        planetString = "All planets"
    }
    else if planetListFiltered.count < 8 && planetListFiltered.isEmpty == false {
        
        planetString = planetListFiltered.joined(separator: ", ")
        
    }
    else{
        planetString = "No plants"
    }
    
    return planetString
}



public func checkPlanet(planetBeingChecked: String , planetList: [String]) -> Bool{
    
    var isPresent: Bool = false
    
    if planetList.contains(planetBeingChecked){
        isPresent = true
    }
    
    return isPresent
}

// Space news

public class spaceNewsViewModel: ObservableObject{
    
    @Published var articles: [articles] = []
    
    @Published var title: [String] = []
    @Published var newsSource : [String] = []
    @Published var newsDescription : [String] = []
    @Published var newsImageUrl : [String] = []
    @Published var newsArticleLinkUrl: [String] = []
    
    
    public let spaceNews: spaceNewsAPI
    
    public init(spaceNews: spaceNewsAPI){
        self.spaceNews = spaceNews
    }
  
    public func newsRefresh(){
        spaceNews.getNewsData{ spaceNewsInfo in DispatchQueue.main.async {
            
            self.articles = getArticles(title: spaceNewsInfo.title, source: spaceNewsInfo.newsSite, desription: spaceNewsInfo.summary, imageUrl: spaceNewsInfo.imageUrl, url: spaceNewsInfo.url )
            
            }
        }
    }
}
    
public func getArticles(title : [String], source : [String] , desription : [String], imageUrl : [String], url : [String]) -> [articles]{
    
    var article: articles
    
    var articleArray: [articles] = []
    
    for i in 0..<7{
        
        
        article = articles(title: title[i], url: url[i], imageUrl: imageUrl[i], newsSite: source[i], summary: desription[i])

        articleArray.append(article)
    }
    
    return articleArray
}

public struct articles: Identifiable{
   
    public let id = UUID()
    let title: String?
    let url: String?
    let imageUrl: String?
    let newsSite: String?
    let summary : String?
}
