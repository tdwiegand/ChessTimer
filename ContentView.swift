//
//  ContentView.swift
//  ChessTimer
//
//  Created by tomw on 7/25/22.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @ObservedObject var currentGame: Game
    @EnvironmentObject var viewRouter: ViewRouter
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    var body: some View {
        HStack{
            Button(action: currentGame.p1Press) {
                Text(currentGame.readableTime(clocktime: currentGame.p1time))
                    .font(.system(size: 40, design: .monospaced))
                    .foregroundColor(.black)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity)
            .buttonStyle(.bordered)
            .overlay(
                Group {
                    if currentGame.playState == .play && currentGame.activePlayer == .player1 {
                        RoundedRectangle(cornerRadius: 65)
                            .stroke(Color.black, lineWidth: 2)
                    }
                }
            )
            .padding()

            VStack{
                HStack{
                    Image(systemName: "chevron.left")
                        .font(.system(size:40))
                    Image(systemName:gameSetup.displayPersonOrFlag(white: gameSetup.white,player: GameSetupOptions.Players.player1, timeOnClock: currentGame.p1time))                    .font(.system(size:40))
                    Image(systemName: "chevron.left")
                        .font(.system(size:40))
                        .hidden()
                }.padding()
                Text(" ")
                    .font(.system(size:40))
                Button(action: {
                    if currentGame.playerFlagged {
                        currentGame.p1time = 1; currentGame.p2time = 1;  viewRouter.currentPage = .page1
                    } else {
                        currentGame.togglePlayPause()
                    }
                }) {
                    Image(systemName: currentGame.playPauseIcon(currentState: currentGame.playState))
                        .font(.system(size:40))
                }
                Text("")
                    .onReceive(timer) { _ in
                        if currentGame.playerFlagged == false {
                            currentGame.timerTick()
                        }
                    }
                Button(action:{viewRouter.currentPage = .page1; currentGame.p1time = 1; currentGame.p2time = 1}){
                    Image(systemName:"gearshape.fill")
                        .font(.system(size:40))
                }
                Text(" ")
                    .font(.system(size:40))
                HStack{
                    Image(systemName: "chevron.right")
                        .font(.system(size:40))
                        .hidden()
                    Image(systemName:gameSetup.displayPersonOrFlag(white: gameSetup.white,player: GameSetupOptions.Players.player2, timeOnClock: currentGame.p2time))
                    .font(.system(size:40))
                    Image(systemName: "chevron.right")
                        .font(.system(size:40))
                }.padding()            }.accentColor(Color(.black))
            Button(action: currentGame.p2Press) {
                Text(currentGame.readableTime(clocktime: currentGame.p2time))
                    .font(.system(size: 40, design: .monospaced))
                    .foregroundColor(.black)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity)
            .buttonStyle(.bordered)
            .overlay(
                Group {
                    if currentGame.playState == .play && currentGame.activePlayer == .player2 {
                        RoundedRectangle(cornerRadius: 65)
                            .stroke(Color.black, lineWidth: 2)
                    }
                }
            )
            .padding()
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(currentGame: currentGame)
            .previewInterfaceOrientation(.landscapeRight)
    }
}
