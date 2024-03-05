//
//  MainView.swift
//  Weather
//
//  Created by Yerassyl Tynymbay on 05.03.2024
//  
//

import SwiftUI

struct MainView: View {
           
    @StateObject var viewState: MainViewState
    
    var body: some View {
        Text("Hello iOS")
    }
}

struct MainPreviews: PreviewProvider {
    static var previews: some View {
        ApplicationViewBuilder.stub.build(view: .main)
    }
}

