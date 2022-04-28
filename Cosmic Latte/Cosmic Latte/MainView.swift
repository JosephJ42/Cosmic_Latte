//
//  MainView.swift
//  Cosmic Latte
//
//  Created by Joey on 25/04/2022.
//

import SwiftUI

struct MainView: View {
    
    //Planet Visability
    var isMercuryVisable = false 
    var isVenusVisable = false
    var isMarsVisable = false
    var isJupiterVisable = false
    var isSaturnVisable = false
    var isUranusVisable = false
    var isNeptuneVisable = false
    var isPlutoVisable = false
    
    var moonStatus = "Full Moon"
    
    var body: some View {
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
                        
                        Spacer().frame( height: 40)
                        //Top Planet Row
                        HStack{
                            Image("Neptune")
                                .resizable()
                                .frame(width: 75, height: 75, alignment: .center)
                                .opacity(isNeptuneVisable ? 1:0)
                            Image("Mercury")
                                .resizable()
                                .frame(width: 75, height: 75, alignment: .center)
                                .opacity(isMercuryVisable ? 1:0)
                            Image("Mars")
                                .resizable()
                                .frame(width: 75, height: 75, alignment: .center)
                                .opacity(isMarsVisable ? 1:0)
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
                            Image("Jupiter")
                                .resizable()
                                .frame(width: 75, height: 75, alignment: .center)
                                .opacity(isJupiterVisable ? 1:0)
                            Image("Pluto")
                                .resizable()
                                .frame(width: 75, height: 75, alignment: .center)
                                .opacity(isPlutoVisable ? 1:0)
                            Image("Uranus") //ha
                                .resizable()
                                .frame(width: 75, height: 75, alignment: .center)
                                .opacity(isUranusVisable ? 1:0)
                        }
                    }
                    
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
                        Text("Date:")
                        Spacer().frame(width: 50)
                        Text("Location:")
                    }
                }.frame(width: 360, height: 60, alignment: .top)
                
                ZStack{
                    Rectangle()
                        .fill(Color.clear)
                        .frame(width: 360, height: 60)
                        .background(Color("App textboxes and overlay"))
                        .cornerRadius(15)
                    
                    HStack{
                        Text("Stargazing Prediction:")
                    }
                
                } .frame(width: 360, height: 60, alignment: .top)
            
                
                ZStack{
                    Rectangle()
                        .fill(Color.clear)
                        .frame(width: 360, height: 200)
                        .background(Color("App textboxes and overlay"))
                        .cornerRadius(15)
                    
                    VStack{
                        Text("Local Space Events:")
                        Text("Misc Text")
                        
                        Text("General Information:")
                        Text("Misc text")
                        Text("")
                        
                    }
                
                }.frame(width: 360, height: 200, alignment: .top)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
