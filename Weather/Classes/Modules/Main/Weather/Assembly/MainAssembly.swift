//
//  MainAssembly.swift
//  Weather
//
//  Created by Yerassyl Tynymbay on 05.03.2024
//

import SwiftUI

final class MainAssembly: Assembly {
    
    func build() -> some View {
        let navigation = container.resolve(NavigationAssembly.self).build()
        let router = MainRouter(navigation: navigation)
        let weatherService = DefaultWeatherService(apiKey: "2e806c6aeb44e18ccaef341a22c7474c")
        let interactor = MainInteractor( weatherService: weatherService)
        let viewState = MainViewState()
        let presenter = MainPresenter(router: router,
                                      interactor: interactor,
                                      viewState: viewState)
        viewState.set(with: presenter, interactor: interactor)
        
        viewState.weatherData = nil
        
        return AnyView(MainView(viewState: viewState))
    }
}
