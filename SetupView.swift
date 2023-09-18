//
//  Copyright (c) 2022 Dropbox Inc. All rights reserved.
//

import SwiftUI

struct SetupView: View {
    @ObservedObject var gameSetup: GameSetupOptions
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        VStack {
        Text("Game Setup").bold()
            HStack{
                Button(action: gameSetup.toggleWhitePlayer){
                    Image(systemName:gameSetup.displayPersonOrFlag(white: gameSetup.white,player: GameSetupOptions.Players.player1, timeOnClock: currentGame.p1time))
                        .font(.system(size:35))
                }.accentColor(Color(.black))
                Button(action: gameSetup.toggleWhitePlayer){
                    Text(gameSetup.sideIdentifier(amIWhite: .player1))}
                .buttonStyle(.bordered)
                Text("Sides")
                Button(action: gameSetup.toggleWhitePlayer){
                    Text(gameSetup.sideIdentifier(amIWhite: .player2))}
                .buttonStyle(.bordered)
                Button(action: gameSetup.toggleWhitePlayer){
                    Image(systemName:gameSetup.displayPersonOrFlag(white: gameSetup.white,player: GameSetupOptions.Players.player2, timeOnClock: currentGame.p2time))
                        .font(.system(size:35))
                }.accentColor(Color(.black))
            }
        Text("Time Control")
            HStack {
                ForEach(gameSetup.timeControlOptions) { timeControlOption in
                    Button(action: {
                        gameSetup.setTimeControl(selection: timeControlOption.timeControl)
                    }) {
                        Text(timeControlOption.timeDescription)
                    }
                    .buttonStyle(.bordered)
                    .tint(gameSetup.timeControl == timeControlOption.timeControl ? .blue : .gray)
                }
            }
            
            Text("Increment")
            HStack {
                ForEach(gameSetup.incrementButtonInfos) { buttonInfo in
                    Button(action: {
                        gameSetup.setIncrement(selection: buttonInfo.value)
                    }) {
                        Text(buttonInfo.label)
                    }
                    .buttonStyle(.bordered)
                    .tint(gameSetup.increment == buttonInfo.value ? .blue : .gray)
                    
                }
            }
            
            Text("Delay")
            HStack {
                ForEach(gameSetup.delayButtonInfos) { buttonInfo in
                    Button(action: {
                        gameSetup.setDelay(selection: buttonInfo.value)
                    }) {
                        Text(buttonInfo.label)
                    }
                    .buttonStyle(.bordered)
                    .tint(gameSetup.delay == buttonInfo.value ? .blue : .gray)
                }
            }
            Button(action:{currentGame = Game(playState: .pause, activePlayer: gameSetup.convertWhiteToActive(), timeControl: gameSetup.timeControl);
                viewRouter.currentPage = .page2}){
                Text("FIGHT")
                        .padding()
            }
            .buttonStyle(.bordered)
            .tint(.green)

        }
    }
    func doNothing() {
        print("hi")
    }
}

struct SetupView_Previews: PreviewProvider {
    static var previews: some View {
        SetupView(gameSetup: gameSetup).previewInterfaceOrientation(.landscapeRight)
    }
}


