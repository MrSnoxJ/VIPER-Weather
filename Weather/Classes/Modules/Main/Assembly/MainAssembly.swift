//
//  MainAssembly.swift
//  Weather
//
//  Created by Yerassyl Tynymbay on 05.03.2024
//  
//


import SwiftUI

final class MainAssembly: Assembly {
    
    func build() -> some View {
        
        let navigation = container.resolve(NavigationAssembly.self).build()

        // Router
        let router = MainRouter(navigation: navigation)

        // Interactor
        let interactor = MainInteractor()

        //ViewState
        let viewState =  MainViewState()

        // Presenter
        let presenter = MainPresenter(router: router,
                                                           interactor: interactor,
                                                           viewState: viewState)
        
        viewState.set(with: presenter)
        
        // View
        let view = MainView(viewState: viewState)
        return view
    }
}
