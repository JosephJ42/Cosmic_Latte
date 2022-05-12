//
//  apiServices.swift
//  Cosmic Latte
//
//  Created by joseph jarvis on 18/03/2022.
//

import Foundation
import CoreLocation
import MapKit

//Moon and cloud cover API request based on location

public final class moonAndWeatherAPI: NSObject, CLLocationManagerDelegate {
    
    public override init(){
        super.init()
        getLocation.delegate = self
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {return}
        makeMoonAndCloudDataRequest(forCoordinates: location.coordinate)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Issue with data: \(error.localizedDescription)")
    }
    
    
    private let getLocation = CLLocationManager()
    private let moonAndWeatherAPIKey = "fb4536a4745851c5a49cfcb7a2a5b13f"
    private var completionHandler: ((moonAndClouds) -> Void)?
    
    public func getUsersLocation(_ completionHandler: @escaping((moonAndClouds)-> Void)){
        self.completionHandler = completionHandler
        getLocation.requestWhenInUseAuthorization()
        getLocation.startUpdatingLocation()
    }
    
    private func makeMoonAndCloudDataRequest(forCoordinates coordinates: CLLocationCoordinate2D){
            guard let moonAndCloudAPIString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&exclude=hourly&appid=\(moonAndWeatherAPIKey)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            else {return}
        
            print("Moon and cloud API request Running")
            
            guard let url = URL(string: moonAndCloudAPIString) else {return}
            
            URLSession.shared.dataTask(with: url){ data, response, error in
                guard error == nil, let data = data else {return}
            
                if let response = try? JSONDecoder().decode(moonAndWeatherAPIResponse.self, from: data){
                    self.completionHandler?(moonAndClouds(response: response))
                }
                
                print("At Moon Response")
                print(response)
                
                
            }.resume()
    }
}


struct moonAndWeatherAPIResponse: Decodable{
    let daily: [moonAndWeatherAPIMain]
}

struct moonAndWeatherAPIMain: Decodable {
    let moon_phase: Double
    let clouds : Int
    
    enum CodingKeys: CodingKey{
        case moon_phase
        case clouds
        
    }
}


//Plant API Request based on location

public final class planetAPI: NSObject, CLLocationManagerDelegate {
    
    public override init(){
        super.init()
        getLocation.delegate = self
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {return}
        makePlanetDataRequest(forCoordinates: location.coordinate)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Issue with data: \(error.localizedDescription)")
    }
    
    
    private let getLocation = CLLocationManager()
    private var completionHandler: ((planets)-> Void)?
    
    
    public func getUsersLocation(_ completionHandler: @escaping((planets)-> Void)){
        self.completionHandler = completionHandler
        getLocation.requestWhenInUseAuthorization()
        getLocation.startUpdatingLocation()
    }
    
        private func makePlanetDataRequest(forCoordinates coordinates: CLLocationCoordinate2D){
            guard let planetAPIString = "https://visible-planets-api.herokuapp.com/v2?latitude=\(coordinates.latitude)&longitude=\(coordinates.longitude)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            else {return}
            
            print("Planet API request Running")
            
            guard let url = URL(string: planetAPIString) else {return}
            
            URLSession.shared.dataTask(with: url){ data, response, error in guard error == nil, let data = data else {return}
            
                if let response = try? JSONDecoder().decode(viewablePlanetsAPIResponse.self, from: data){
                self.completionHandler?(planets(response: response))
            }
                
                print("At Planet Response")
                print(response)
                
        }.resume()
    }
}


struct viewablePlanetsAPIResponse: Decodable, Hashable{
    let data: [planetsAPIMain]
}

struct planetsAPIMain: Decodable, Hashable{
    let name: String
    let aboveHorizon : Bool
    
    enum CodingKeys: CodingKey{
        case name
        case aboveHorizon
    }
}


// Space news API

public final class spaceNewsAPI: NSObject, CLLocationManagerDelegate {
    
    public override init(){
        super.init()
        getLocation.delegate = self
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        spaceNewsDataRequest()
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Issue with data: \(error.localizedDescription)")
    }
    
        
    private let getLocation = CLLocationManager()
    private var completionHandler: ((spaceNews)-> Void)?
    
    
    public func getNewsData(_ completionHandler: @escaping((spaceNews)-> Void)){
            self.completionHandler = completionHandler
            getLocation.requestWhenInUseAuthorization()
            getLocation.startUpdatingLocation()
    }
    
    
    private func spaceNewsDataRequest(){
        guard let spaceNewsAPIString = "https://api.spaceflightnewsapi.net/v3/articles".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else {return}
        
        print("Space New API request Running")
        
        guard let url = URL(string: spaceNewsAPIString) else {return}
            
        URLSession.shared.dataTask(with: url){ data, response, error in guard error == nil, let data = data else {return}
            
            if let response = try? JSONDecoder().decode(spaceNewsAPIResponse.self, from: data){
                self.completionHandler?(spaceNews(response: response))
            }
            
            print("At Spacew news Response")
            print(response)
        }.resume()
    }
    
    
}

struct spaceNewsAPIResponse: Decodable{
    
    let title: String?
    let url: String?
    let imageUrl: String?
    let newsSite: String?
    let summary : String?
    
    enum CodingKeys: CodingKey{
        case title, url, imageUrl, newsSite, summary
    }
    
    //typealias is used to handle issue with this data consisting of an unnamed array of dictionaries
    //let Article : [spaceNewsAPIMain]
}

struct spaceNewsAPIMain: Decodable, Hashable {
    let title: String?
    let url: String?
    let imageUrl: String?
    let newsSite: String?
    let summary : String?
    
    enum CodingKeys: CodingKey{
        case title, url, imageUrl, newsSite, summary
    }
    
    
}
