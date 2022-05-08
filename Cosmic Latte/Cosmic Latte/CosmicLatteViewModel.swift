//
//  CosmicLatteViewModel.swift
//  Cosmic Latte
//
//  Created by Joseph Jarvis on 20/03/2022.
//

import Foundation
import CoreLocation
import MapKit

// Moon and Weather

public class moonViewModel : ObservableObject {
    
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
            
//            self.location = getLocationString()
            self.moonPhase =  moonPhaseCalculator(moonPhase: moonAndCloudsInfo.moonPhase)
            self.cloudCover = cloudCoverageCalculator(cloudCover: moonAndCloudsInfo.cloudCover)
            self.prediction = stargazingPrediction(moonPhase: moonAndCloudsInfo.moonPhase, cloudCover: moonAndCloudsInfo.cloudCover)
            
        }
    }
}
}

//public func getLocationString() -> String {
//
//    let locationManger = getLocation()
//
//    let location = locationManger.location != nil ? locationManger.location!.coordinate : CLLocationCoordinate2D()
//
//    let city = locationManger.locationCityGlobal
//
//    return city
//}




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
    
    public let planets: planetAPI
    
    public init (planets: planetAPI){
        self.planets = planets
    }
    
    public func planetVisibilityRefresh(){
        planets.getUsersLocation { planetInfo in DispatchQueue.main.async{
        self.name = planetInfo.planetName
        self.planetVisable = planetInfo.visible
        }
        }
    }
}

// Space news

public class spaceNewsViewModel: ObservableObject{
    
    @Published var title: String = "No Title"
    @Published var newsSource : String = "No Source"
    @Published var newsDescription : String = "No description"
    @Published var newsImageUrl : String = ""
    @Published var newsArticleLinkUrl: String = ""
    
    public let spaceNews: spaceNewsAPI
    
    public init(spaceNews: spaceNewsAPI){
        self.spaceNews = spaceNews
    }
  
    public func newsRefresh(){
        spaceNews.getNewsData{ spaceNewsInfo in DispatchQueue.main.async {
            self.title = spaceNewsInfo.title
            self.newsSource = spaceNewsInfo.newsSite
            self.newsDescription = spaceNewsInfo.summary
            self.newsImageUrl = spaceNewsInfo.imageUrl
            self.newsArticleLinkUrl = spaceNewsInfo.url
        
            }
        }
    }
}
    

// The below code has been adepted from the following link
//
//
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
                           print(locationName)
                           self.locationNameGlobal = locationName
                           print(self.locationNameGlobal!)
                       }
                       // City
                       if let city = placeMark.subAdministrativeArea {
                           print(city)
                           self.locationCityGlobal = placeMark.subAdministrativeArea!
                           print(self.locationCityGlobal!)
                          
                       }
                       // Country
                       if let country = placeMark.country {
                           print(country)
                           self.locationCountryNameGlobal = placeMark.country!
                           print(self.locationCountryNameGlobal!)
                       }
               })
    }
    
}


