//
//  MainContracts.swift
//  Weather
//
//  Created by Yerassyl Tynymbay on 05.03.2024
//  
//

import SwiftUI


// Router
protocol MainRouterProtocol: RouterProtocol {

}

// Presenter
protocol MainPresenterProtocol: PresenterProtocol {

}

// Interactor
protocol MainInteractorProtocol: InteractorProtocol {

}

// ViewState
protocol MainViewStateProtocol: ViewStateProtocol {
    func set(with presenter: MainPresenterProtocol)
}
