//
//  ChessTimerApp.swift
//  ChessTimer
//
//  Created by tomw on 7/25/22.
//

import SwiftUI

@main

struct ChessTimerApp: App {
    @StateObject var viewRouter = ViewRouter()
    var body: some Scene {
        WindowGroup {
            MotherView().environmentObject(viewRouter)
            //SetupView(gameSetup: gameSetup)
        }
    }
}

class GameSetupOptions: ObservableObject {
    enum Players {
        case player1, player2
    }

    
    enum timeControls {
        case halfMin, oneMin, fiveMin, tenMin, fifteenMin,thirtyMin, sixtyMin
    }

    
    struct TimeControlOption: Identifiable {
        let id = UUID()
        let timeControl: GameSetupOptions.timeControls
        let timeDescription: String
    }
    
    let timeControlOptions = [
        TimeControlOption(timeControl: .halfMin, timeDescription: "30s"),
        TimeControlOption(timeControl: .oneMin, timeDescription: "1m"),
        TimeControlOption(timeControl: .fiveMin, timeDescription: "5m"),
        TimeControlOption(timeControl: .tenMin, timeDescription: "10m"),
        TimeControlOption(timeControl: .fifteenMin, timeDescription: "15m"),
        TimeControlOption(timeControl: .thirtyMin, timeDescription: "30m"),
        TimeControlOption(timeControl: .sixtyMin, timeDescription: "60m"),
    ]
    
    enum increments {
        case none, oneS, twoS, fiveS, tenS
    }
    
    struct IncrementButtonInfo: Identifiable {
        let id = UUID()
        let label: String
        let value: GameSetupOptions.increments
    }

    let incrementButtonInfos: [IncrementButtonInfo] = [
        IncrementButtonInfo(label: "none", value: .none),
        IncrementButtonInfo(label: "1s", value: .oneS),
        IncrementButtonInfo(label: "2s", value: .twoS),
        IncrementButtonInfo(label: "5s", value: .fiveS),
        IncrementButtonInfo(label: "10s", value: .tenS),
    ]
    
    
    enum delays {
        case none, oneS, twoS, fiveS, tenS
    }
    
    struct DelayButtonInfo: Identifiable {
        let id = UUID()
        let label: String
        let value: GameSetupOptions.delays
    }
    
    let delayButtonInfos: [DelayButtonInfo] = [
        DelayButtonInfo(label: "none", value: .none),
        DelayButtonInfo(label: "1s", value: .oneS),
        DelayButtonInfo(label: "2s", value: .twoS),
        DelayButtonInfo(label: "5s", value: .fiveS),
        DelayButtonInfo(label: "10s", value: .tenS),
    ]
    
    @Published var white: Players = .player1
    @Published var timeControl: timeControls = .sixtyMin
    @Published var increment: increments = .none
    @Published var delay: delays = .none
    
    func setTimeControl(selection: timeControls){
        self.timeControl = selection
        print (self.timeControl)
        }
    func setIncrement(selection: increments){
        self.increment = selection
        }
    func setDelay(selection: delays){
        self.delay = selection
    }
    func toggleWhitePlayer(){
        if self.white == .player1{
            self.white = .player2
        } else {self.white = .player1}
    }
    
    func sideIdentifier(amIWhite:GameSetupOptions.Players) -> String {
        if amIWhite == self.white {
            return "White"
        } else {
            return "Black"
        }
    }
    
    func convertWhiteToActive() -> Game.activePlayers {
        if self.white == .player1{
            return Game.activePlayers.player1
        } else { return Game.activePlayers.player2}
    }
    
    func displayPersonOrFlag(white:GameSetupOptions.Players, player: GameSetupOptions.Players, timeOnClock:Int) -> String {
        if white == player && timeOnClock > 0 {
            return "person"
        } else if white == player && timeOnClock == 0 {
            return "flag"
        } else if white != player && timeOnClock > 0 {
            return "person.fill"
        } else { return "flag.fill"}
    }
    
    init(white:Players, timeControl:timeControls, increment:increments, delay:delays){
        self.white = white
        self.timeControl = timeControl
        self.increment = increment
        self.delay = delay
    }
    
}




class Game: ObservableObject {
    enum playStates {
        case play, pause
    }
    

    enum activePlayers {
        case player1, player2
    }
    
    @Published var playState: playStates
    var activePlayer: activePlayers
    var playerFlagged: Bool
    @Published var p1time: Int
    @Published var p2time: Int
    let timeDict: [GameSetupOptions.timeControls: Int] =
    [
        GameSetupOptions.timeControls.halfMin:300,
        GameSetupOptions.timeControls.oneMin:600,
        GameSetupOptions.timeControls.fiveMin:3000,
        GameSetupOptions.timeControls.tenMin:6000,
        GameSetupOptions.timeControls.fifteenMin:9000,
        GameSetupOptions.timeControls.thirtyMin:18000,
        GameSetupOptions.timeControls.sixtyMin:36000
    ]
    
    let incrementDict : [GameSetupOptions.increments: Int] =
    [
        GameSetupOptions.increments.none:0,
        GameSetupOptions.increments.oneS:10,
        GameSetupOptions.increments.twoS:20,
        GameSetupOptions.increments.fiveS:50,
        GameSetupOptions.increments.tenS:100
    ]
    
    let delayDict: [GameSetupOptions.delays: Int] =
    [
        GameSetupOptions.delays.none:0,
        GameSetupOptions.delays.oneS:10,
        GameSetupOptions.delays.twoS:20,
        GameSetupOptions.delays.fiveS:50,
        GameSetupOptions.delays.tenS:100
    ]
    
    var delayCounter: Int = 0
    
    func playPauseIcon(currentState: playStates) -> String {
        return currentState == .play ? "pause.fill" : "play.fill"
    }
    
    func readableTime(clocktime: Int) -> String {
        let minutes = clocktime/600
        let seconds = ((clocktime%600)/10)
        let tenths = clocktime%10
        if clocktime >= 600 {
            return "\(minutes)m \(seconds)s"
        } else if clocktime < 600 && clocktime >= 100 {
            return "   \(seconds)s"
        } else {
            return "   \(seconds).\(tenths)s"
        }
    }
    
    func timerTick() {
        if delayCounter > 0 {
            delayCounter -= 1
        } else {
        if self.playState == .play {
            if self.activePlayer == .player1 {
                self.p1time -= 1
            }
            else { self.p2time -= 1
            }
        }
        if self.p1time == 0 || self.p2time == 0 {
            self.playerFlagged = true
            print("flagged")
            }
        }
    }
    
    
    func togglePlayPause() {
        self.playState = (self.playState == .play) ? .pause : .play
    }
    
    func p1Press() {
        if self.activePlayer == .player1 && self.playState == .play {
            if self.p1time > 0 {self.p1time += currentGame.incrementDict[gameSetup.increment]!
                self.delayCounter = self.delayDict[gameSetup.delay]!
                self.activePlayer = .player2}
        }
    }
    
    func p2Press() {
        if self.activePlayer == .player2 && self.playState == .play {
            if self.p2time > 0 {self.p2time += currentGame.incrementDict[gameSetup.increment]!
                self.delayCounter = self.delayDict[gameSetup.delay]!
                self.activePlayer = .player1}
        }
    }
    
    func setInitialTime(timeToSet:GameSetupOptions.timeControls) -> Int {
        if timeToSet == .halfMin{
            return 300
        } else if timeToSet == .oneMin{
            return 600
        } else if timeToSet == .tenMin{
            return 1000
        } else if timeToSet == .fifteenMin{
            return 1500
        } else if timeToSet == .thirtyMin{
            return 3000
        } else {
            return 6000
        }
    }
    
    
    init(playState:playStates, activePlayer:activePlayers, timeControl:GameSetupOptions.timeControls){
        self.playState = playState
        self.activePlayer = activePlayer
        self.p1time = timeDict[timeControl]!
        self.p2time = timeDict[timeControl]!
        self.playerFlagged = false
    }
}

var gameSetup = GameSetupOptions(white: .player1, timeControl: .tenMin, increment: .twoS, delay: .none)
var currentGame = Game(playState: .pause, activePlayer: .player1, timeControl:GameSetupOptions.timeControls.tenMin)



