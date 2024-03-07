//  Created by Yerassyl Tynymbay on 05.03.2024
//
//


import SwiftUI

struct MainView: View {
    @ObservedObject var viewState: MainViewState
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.opacity(0.1)
                    .ignoresSafeArea(.all)
                VStack(spacing: 20) {
                    Spacer()
                    VStack {
                        Text("Welcome to the Weather App ")
                            .bold()
                            .font(.title)
                        Text("Please go ahead to search your current location to get the weather")
                            .padding()
                    }
                    .multilineTextAlignment(.center)
                    .padding()
                    
                    TextField("Enter city name", text: $searchText)
                        .padding()
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                        .shadow(radius: 5)
                    
                    Button(action: {
                        if !searchText.isEmpty {
                            viewState.presenter?.searchWeather(for: searchText)
                        }
                    }) {
                        RoundedRectangle(cornerRadius: 16)
                            .frame(width:200,height: 30)
                            .overlay {
                                HStack(spacing: 25) {
                                    Text("Search")
                                        .foregroundColor(.white)
                                        .font(.title3)
                                    Image(systemName: "arrow.forward")
                                        .foregroundColor(.white)
                                }
                                .padding(.horizontal)
                            }
                    }
                    .padding(.horizontal)
                    
                    if let searchResults = viewState.searchResults {
                        List(searchResults, id: \.id) { result in
                            NavigationLink(destination: DetailWeatherView(weatherData: result)) {
                                VStack(alignment: .leading) {
                                    Text("\(result.sys.country).\(result.name)")
                                }
                                .padding()
                            }
                            .background(.white)
                        }
                        
                    }
                    
                    Spacer()
                }
                .onAppear {
                    viewState.presenter?.getWeather(for: "Almaty")
                }
            } .preferredColorScheme(.light)
           
        }
    }
}

struct MainPreviews: PreviewProvider {
    static var previews: some View {
        ApplicationViewBuilder.stub.build(view: .main)
    }
}

