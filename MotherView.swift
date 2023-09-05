//
//  MotherView.swift
//  ChessTimer
//
//  Created by tomw on 7/31/22.
//

import SwiftUI

struct MotherView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        switch viewRouter.currentPage{
        case .page1: SetupView(gameSetup: gameSetup)
        case .page2: ContentView(currentGame: currentGame)
        }
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView().environmentObject(ViewRouter())
    }
}
