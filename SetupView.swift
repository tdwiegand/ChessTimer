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
            HStack{
                Button(action: { gameSetup.setTimeControl(selection: .halfMin) } ){
                    Text("30s")}
                .buttonStyle(.bordered)
                .tint(gameSetup.timeControl == .halfMin ? .blue : .gray)
                Button(action: {gameSetup.setTimeControl(selection: .oneMin)}){
                    Text("1m")}
                .buttonStyle(.bordered)
                .tint(gameSetup.timeControl == .oneMin ? .blue : .gray)
                Button(action: {gameSetup.setTimeControl(selection: .fiveMin)}){
                    Text("5m")}
                .buttonStyle(.bordered)
                .tint(gameSetup.timeControl == .fiveMin ? .blue : .gray)
                Button(action: {gameSetup.setTimeControl(selection: .tenMin)}){
                    Text("10m")}
                .buttonStyle(.bordered)
                .tint(gameSetup.timeControl == .tenMin ? .blue : .gray)
                Button(action: {gameSetup.setTimeControl(selection: .fifteenMin)}){
                    Text("15m")}
                .buttonStyle(.bordered)
                .tint(gameSetup.timeControl == .fifteenMin ? .blue : .gray)
                Button(action: {gameSetup.setTimeControl(selection: .thirtyMin)}){
                    Text("30m")}
                .buttonStyle(.bordered)
                .tint(gameSetup.timeControl == .thirtyMin ? .blue : .gray)
                Button(action: {gameSetup.setTimeControl(selection: .sixtyMin)}){
                    Text("60m")}
                .buttonStyle(.bordered)
                .tint(gameSetup.timeControl == .sixtyMin ? .blue : .gray)
            }
        Text("Increment")
            HStack{
                Button(action: {gameSetup.setIncrement(selection: .none)}){
                    Text("none")}
                .buttonStyle(.bordered)
                .tint(gameSetup.increment == .none ? .blue : .gray)
                Button(action: {gameSetup.setIncrement(selection: .oneS)}){
                    Text("1s")}
                .buttonStyle(.bordered)
                .tint(gameSetup.increment == .oneS ? .blue : .gray)
                Button(action: {gameSetup.setIncrement(selection: .twoS)}){
                    Text("2s")}
                .buttonStyle(.bordered)
                .tint(gameSetup.increment == .twoS ? .blue : .gray)
                Button(action: {gameSetup.setIncrement(selection: .fiveS)}){
                    Text("5s")}
                .buttonStyle(.bordered)
                .tint(gameSetup.increment == .fiveS ? .blue : .gray)
                Button(action: {gameSetup.setIncrement(selection: .tenS)}){
                    Text("10s")}
                .buttonStyle(.bordered)
                .tint(gameSetup.increment == .tenS ? .blue : .gray)
            }
        Text("Delay")
            HStack{
                Button(action: {gameSetup.setDelay(selection: .none)}){
                    Text("none")}
                .buttonStyle(.bordered)
                .tint(gameSetup.delay == .none ? .blue : .gray)
                Button(action: {gameSetup.setDelay(selection: .oneS)}){
                    Text("1s")}
                .buttonStyle(.bordered)
                .tint(gameSetup.delay == .oneS ? .blue : .gray)
                Button(action: {gameSetup.setDelay(selection: .twoS)}){
                    Text("2s")}
                .buttonStyle(.bordered)
                .tint(gameSetup.delay == .twoS ? .blue : .gray)
                Button(action: {gameSetup.setDelay(selection: .fiveS)}){
                    Text("5s")}
                .buttonStyle(.bordered)
                .tint(gameSetup.delay == .fiveS ? .blue : .gray)
                Button(action: {gameSetup.setDelay(selection: .tenS)}){
                    Text("10s")}
                .buttonStyle(.bordered)
                .tint(gameSetup.delay == .tenS ? .blue : .gray)
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


