//
//  ContentView.swift
//  Cosmic Latte
//
//  Created by Joseph Jarvis on 04/03/2022.
//

import SwiftUI

struct ContentView: View {
    
    let tabBackgroundColour = Color("App textboxes and overlay")
                                 
    var body: some View {
        TabView {
                    ZStack {
                        Color("appBackground")
                            .ignoresSafeArea()
                        
                        VStack {
                            MainView()
                                .padding()
                                .frame(maxHeight: .infinity)
                                .ignoresSafeArea()
                                
                            Rectangle()
                                .fill(Color.clear)
                                .frame(height: 108)
                                .background(tabBackgroundColour)
                        }
                        .font(.title2)
                        
                    }
                    .ignoresSafeArea()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    
            ZStack {
                Color("appBackground")
                    .ignoresSafeArea()
                
                VStack {
                    CondensedPredictionView()
                        .padding()
                        .frame(maxHeight: .infinity)
                        .ignoresSafeArea()
                        
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 108)
                        .background(tabBackgroundColour)
                }
                .font(.title2)
            }
                        .tabItem {
                            Image(systemName: "moon.stars")
                            Text("Prediction View")
                        }
                    
            ZStack {
                Color("appBackground")
                    .ignoresSafeArea()
                
                VStack {
                    SpaceNewsView()
                        .padding()
                        .frame(maxHeight: .infinity)
                        .ignoresSafeArea()
                        
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 108)
                        .background(tabBackgroundColour)
                }
                .font(.title2)
            }
                        .tabItem {
                            Image(systemName: "moon")
                            Text("Space News")
                        }
        } // tab bar animations go here
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portrait)
    }
}
