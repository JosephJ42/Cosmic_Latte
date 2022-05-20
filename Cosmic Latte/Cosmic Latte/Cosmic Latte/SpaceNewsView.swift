//
//  SpaceNewsView.swift
//  Cosmic Latte
//
//  Created by Joey on 25/04/2022.
//

import SwiftUI

struct SpaceNewsView: View {
    
    
    
    @ObservedObject var viewModelSpaceNews: spaceNewsViewModel
    
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
                
                //News Feed
                ZStack{
                    ScrollView(){
                        Spacer().frame(height: 98)
    
                            VStack(){
                                
                                Text("News Feed")
                                
                                List (viewModelSpaceNews.articles) { articles in
                                    Link(destination: URL(string: articles.url ?? "")!){
                                        HStack{
                                            AsyncImage(url: URL(string: articles.imageUrl ?? "")){ phase in
                                                if let image = phase.image{
                                                    image.resizable()
                                                    .frame(width: 150, height: 125)
                                                }else{
                                                    Image(systemName: "exclamationmark.circle")
                                                }
                                            }.scaledToFit()
                                             .frame(width: 150, height: 125)
                                             .cornerRadius(15)


                                            Spacer().frame(width: 10)
                                            VStack(alignment: .leading){
                                                Text(articles.title ?? "")
                                                    .font(.system(size: 12, design: .default))
                                                Text("Source: \(articles.newsSite ?? "")")
                                                    .font(.system(size: 10, design: .default))
                                                Text("")
                                                Text(articles.summary ?? "") 
                                                    .font(.system(size: 10, design: .default))
                                                    .fixedSize(horizontal: false, vertical: true)

                                            }
                                        }
                                    }.foregroundColor(.primary)
                                }.onAppear(perform: viewModelSpaceNews.newsRefresh)
                                 .listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
                                
                            }.frame(width: 360, height: 660)
                                     .background(Color("App textboxes and overlay"))
                                     .cornerRadius(15)
                        }
                    }
            }
        }
    }


//struct SpaceNewsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SpaceNewsView()
//    }
//}

//struct NewsRow: View {
//
//    @ObservedObject var viewModelSpaceNews: spaceNewsViewModel
//
//
//
//    var body: some View {
//        HStack{
//            AsyncImage(url: URL(string: viewModelSpaceNews.newsImageUrl)) //viewModel.newsImageUrl
//                .frame(width: 125, height: 100)
//                .cornerRadius(15)
//
//
//            Spacer().frame(width: 10)
//            VStack(alignment: .leading){
//                Text(viewModelSpaceNews.title) //viewModel.title
//                    .font(.system(size: 12, design: .default))
//                Text(viewModelSpaceNews.newsSource) //viewModel.newsSource
//                    .font(.system(size: 10, design: .default))
//                Text(viewModelSpaceNews.newsDescription) //viewModel.newsDescription
//                    .font(.system(size: 10, design: .default))
//
//            }
//
//        }.onAppear(perform: viewModelSpaceNews.newsRefresh)
//    }
//}
