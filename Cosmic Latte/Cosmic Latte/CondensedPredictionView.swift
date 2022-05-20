//
//  CondensedPredictionView.swift
//  Cosmic Latte
//
//  Created by Joey on 25/04/2022.
//

import SwiftUI
import CoreLocation
import MapKit

struct CondensedPredictionView: View {
    @ObservedObject var viewModelPrediction: moonViewModel
    @ObservedObject private var locationManger = getLocation()
        
    var body: some View {
        
        let location = "\(locationManger.locationCityGlobal ?? "")"
        
            ZStack{
                Color("appBackground")
                    .ignoresSafeArea()
                VStack{
                    ZStack(alignment: .top){
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: .infinity, height: 400, alignment: .top)
                            .background(Color("App image gallery background"))
                        
                        Image("background hill")
                            .resizable()
                            .frame(width: 400, height: 350)
                            .position(x: 250, y: 402)
                        
                        
                        
                        VStack{
                            Spacer().frame( height: 40)
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
                        
                   
                    }.frame(width: 360, height: 60, alignment: .top)
                    
                    ZStack{
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: 360, height: 60)
                            .background(Color("App textboxes and overlay"))
                            .cornerRadius(15)
                    } .frame(width: 360, height: 60, alignment: .top)
                
                    
                    ZStack{
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: 360, height: 200)
                            .background(Color("App textboxes and overlay"))
                            .cornerRadius(15)
                    }.frame(width: 360, height: 200, alignment: .top)
                    
                }
                //Condensed View Feed
                ZStack{
                    
                    ScrollView(){
                        Spacer().frame(height: 98)
    
                            VStack(){
                                
                                //Text("News Feed")
                                //Spacer().frame(height: 98)
                                Text("Location: \(location)")
                                    .padding()
                                    .frame(alignment: .center)
                                
                                List(viewModelPrediction.condensedPredictionsList) { predictions in
                                        
                                        HStack(){
                                            //image
                                            Image(predictions.moonPhase ?? "New Moon").resizable().frame(width: 70, height: 70)

                                            Spacer().frame(width: 24)
                                                //Text V stack
                                                VStack(alignment: .leading){

                                                    Text("Date: \(predictions.date ?? "")")
                                                        .font(.system(size: 16, design: .default))
                                                    Text("Prediction: \(predictions.stargazingPrediction ?? "")")
                                                        .font(.system(size: 16, design: .default))
                                                    Text("Conditions: \(predictions.condition ?? "") ")
                                                        .font(.system(size: 16, design: .default))
                                                }.frame(alignment: .leading)
                                        }
                                }.onAppear(perform: viewModelPrediction.refresh)
                                 .listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
                                
                            }.frame(width: 360, height: 660)
                                     .background(Color("App textboxes and overlay"))
                                     .cornerRadius(15)
                                     //.onAppear(perform: viewModelPrediction.refresh)
                        }
                }
            }
        }
    }

//struct CondensedPredictionView_Previews: PreviewProvider {
//    static var previews: some View {
//        CondensedPredictionView()
//            .preferredColorScheme(.light)
//    }
//}

//struct PredictionViewRow: View {
//
//    @ObservedObject var viewModelPrediction: predictionViewModel
//
//    var body: some View {
//
//        //.onAppear(perform: viewModelPrediction.refresh)
//         //.frame(width: 51, height: 97)
//
//    }
//}
