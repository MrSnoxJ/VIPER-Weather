//
//  MainRouter.swift
//  Weather
//
//  Created by Yerassyl Tynymbay on 05.03.2024
//  
//

import Foundation
import SwiftUI
final class MainRouter: MainRouterProtocol {
    var navigation: any NavigationServiceType 

    init(navigation: any NavigationServiceType) {
        self.navigation = navigation
    }

    func navigateToDetailView(with weather: WeatherData) {
        
        
        let detailView = DetailWeatherView(weatherData: weather)
        
        let detailNavigation = NavigationView {
            detailView
        }
        UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: detailNavigation)
    }
}

