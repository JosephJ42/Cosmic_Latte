//
//  MainView.swift
//  Cosmic Latte
//
//  Created by Joey on 25/04/2022.
//

import SwiftUI
import CoreLocation
import MapKit

struct MainView: View {
    //API View model
    @ObservedObject var viewModelOne: moonViewModel
    @ObservedObject var viewModelTwo: planetViewModel
    @ObservedObject private var locationManger = getLocation()


    var body: some View {
        
        //Planet Visability
        let isMercuryVisable = false
        let isVenusVisable = false
        let isMarsVisable = false
        let isJupiterVisable = false
        let isSaturnVisable = false
        let isUranusVisable = false
        let isNeptuneVisable = false
        let isPlutoVisable = false
        
        let isOvercast = false
        let isCloudy = false
        
        let moonStatus = viewModelOne.moonPhase
        
        let date = Text(Date(),
                        style: .date)
        
        let location = "\(locationManger.locationCityGlobal ?? "")"
        
        let prediction = viewModelOne.prediction
        
        let skyInfo = viewModelOne.cloudCover
        
        let visablePlanetList = Text("No planets")
        
        
        ZStack{
            Color("appBackground")
                .ignoresSafeArea()
            VStack{
                //Prediction Image View
                ZStack(alignment: .top){
                    Rectangle()
                        .fill(Color.clear)
                        .frame(width: .infinity, height: 400, alignment: .top)
                        .background(Color("App image gallery background"))
//                        .ignoresSafeArea()
                    
                    Image("background hill")
                        .resizable()
                        .frame(width: 400, height: 350)
                        .position(x: 250, y: 402)
                    
                    VStack{
                        
                        Spacer().frame( height: 55)
                        //Top Planet Row
                        HStack{
                            VStack{
                                Spacer().frame( height: 20)
                                Image("Neptune")
                                    .resizable()
                                    .frame(width: 75, height: 75, alignment: .center)
                                    .opacity(isNeptuneVisable ? 1:0)
                            }.frame(width: 75, height: 75, alignment: .center)
                            Image("Mercury")
                                .resizable()
                                .frame(width: 75, height: 75, alignment: .center)
                                .opacity(isMercuryVisable ? 1:0)
                            VStack{
                                Spacer().frame( height: 20)
                                Image("Mars")
                                    .resizable()
                                    .frame(width: 75, height: 75, alignment: .center)
                                    .opacity(isMarsVisable ? 1:0)
                            }.frame(width: 75, height: 75, alignment: .center)
                        }
                        
                        //Middle Planet Row
                        HStack{
                            Spacer()
                            Image("Venus")
                                .resizable()
                                .frame(width: 75, height: 75, alignment: .center)
                                .opacity(isVenusVisable ? 1:0)
                            Spacer().frame(width: 30)
                            Image(moonStatus)
                                .resizable()
                                .frame(width: 120, height: 120, alignment: .center)
                            Spacer().frame(width: 30)
                            Image("Saturn")
                                .resizable()
                                .frame(width: 75, height: 75, alignment: .center)
                                .opacity(isSaturnVisable ? 1:0)
                            Spacer()
                        }
                        
                        //Bottom (ha) Planet Row
                        HStack{
                            VStack{
                                Image("Jupiter")
                                    .resizable()
                                    .frame(width: 75, height: 75, alignment: .center)
                                    .opacity(isJupiterVisable ? 1:0)
                                Spacer().frame( height: 20)
                            }.frame(width: 75, height: 75, alignment: .center)
                            
                            Image("Pluto")
                                .resizable()
                                .frame(width: 75, height: 75, alignment: .center)
                                .opacity(isPlutoVisable ? 1:0)
                            
                            VStack{
                                Image("Uranus") //ha
                                    .resizable()
                                    .frame(width: 75, height: 75, alignment: .center)
                                    .opacity(isUranusVisable ? 1:0)
                                Spacer().frame( height: 20)
                                
                            }.frame(width: 75, height: 75, alignment: .center)
                        }
                    }
                    
                    //The Cloud Stack
                    ZStack{
                        //Overcast
                        VStack{

                            Spacer().frame( height: 65)
                            
                            HStack{
                            
                            Image("Overcast")
                                .resizable()
                                .frame(width: 350, height: 270, alignment: .center)
                                .opacity(isOvercast ? 1:0)
                                
                            }
                        }.frame(width: 500, height: 355, alignment: .top)
                        
                        VStack{

                            Spacer().frame( height: 50)
                            VStack{
                                
                                HStack{
                                    
                                Image("Partly Cloudy")
                                    .resizable()
                                    .frame(width: 120, height: 120, alignment: .center)
                                    .opacity(isCloudy ? 1:0)
                                    
                                    Spacer().frame( width: 150)
                                    
                                }
                                
                                HStack{
                                    Image("Partly Cloudy")
                                        .resizable()
                                        .frame(width: 130, height: 130, alignment: .center)
                                        .opacity(isCloudy ? 1:0)
                                    
                                    Spacer().frame( width: 120)
                                    
                                    VStack{
                                        Image("Partly Cloudy")
                                            .resizable()
                                            .frame(width: 120, height: 120, alignment: .center)
                                            .opacity(isCloudy ? 1:0)
                                        
                                        Spacer().frame(height: 50)
                                    }
                                    
                                }
                                
                                
                            }.frame(width: 500, height: 355, alignment: .top)
                            
                        }.frame(width: 500, height: 355, alignment: .top)
                        
                        
                        
                    }.frame(width: 500, height: 355, alignment: .top)
                    
                }.frame(width: 500, height: 355, alignment: .top)
                 .ignoresSafeArea()
                
                Spacer().frame( height: 70)
                
                ZStack{
                    Rectangle()
                        .fill(Color.clear)
                        .frame(width: 360, height: 60)
                        .background(Color("App textboxes and overlay"))
                        .cornerRadius(15)
                    
                    HStack{
                    
                        Text("Date: \(date)")
                            .font(.system(size: 18, design: .default))
                            
                        
                        Spacer().frame(width: 20)
                        
                        Text("Location: \(location)" )
                            .font(.system(size: 18, design: .default))
                        
//                        Text("Location: \(formattedLat), \(formattedLon)" )
//                            .font(.system(size: 18, design: .default))
                    }
                }.frame(width: 360, height: 60, alignment: .top)
                
                ZStack{
                    Rectangle()
                        .fill(Color.clear)
                        .frame(width: 360, height: 60)
                        .background(Color("App textboxes and overlay"))
                        .cornerRadius(15)
                    
                    VStack(alignment: .leading){
                        Text("Stargazing Prediction: \(prediction)")
                            .font(.system(size: 18, design: .default))
                        
                    }.frame(width: 360, height: 60)

                }.frame(width: 360, height: 60)
            
                
                ZStack{
                    Rectangle()
                        .fill(Color.clear)
                        .frame(width: 360, height: 200)
                        .background(Color("App textboxes and overlay"))
                        .cornerRadius(15)
                    
                    VStack (alignment: .leading){
                        Text("Local Space Events:")
                            .font(.system(size: 18, design: .default))
                            
                            
                        Text("Tonight the moon will be a \(moonStatus).")
                            .font(.system(size: 16, design: .default))
                        
                        Text("\(visablePlanetList) will be visable from your location.")
                            .font(.system(size: 16, design: .default))
                        
                        Spacer().frame(height: 20)
                        
                        Text("General Information:")
                            .font(.system(size: 18, design: .default))
                        
                        Text("Conditions: \(skyInfo)")
                            .font(.system(size: 16, design: .default))
                    
                        
                    }.frame(width: 360, height: 200)
                
                }.frame(width: 360, height: 200, alignment: .top)
            }
        }.onAppear(perform: viewModelOne.refresh)
         .onAppear(perform: viewModelTwo.planetVisibilityRefresh)
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView(viewModelOne: moonViewModel)
//
//    }
//}
