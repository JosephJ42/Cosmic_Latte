//
//  CondensedPredictionView.swift
//  Cosmic Latte
//
//  Created by Joey on 25/04/2022.
//

import SwiftUI

struct CondensedPredictionView: View {
    var body: some View {
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
                    
                    VStack{
                        Spacer().frame(height: 98)
                        List(){
                            Text("Location:")
                            
                            PredictionViewRow()
                            
                            
                            
                            }.frame(width: 360, height: 660)
                             .background(Color("App textboxes and overlay"))
                             .cornerRadius(15)
                        }
                    
                    }
                }
            }
        }

struct CondensedPredictionView_Previews: PreviewProvider {
    static var previews: some View {
        CondensedPredictionView()
            .preferredColorScheme(.light)
    }
}

struct PredictionViewRow: View {
    
    //@ObservedObject var viewModel: moonViewModel
    
    
    
    var body: some View {
        HStack{
            //image
            Image("Full Moon")
            
            Spacer().frame(width: 20)
            //Text V stack
            VStack{
                Text("Date:")
                Text("Prediction:")
                Text("Conditions:")
            }.frame(alignment: .leading)
            
        }
    }
}