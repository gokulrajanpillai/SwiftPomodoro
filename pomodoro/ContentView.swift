//
//  ContentView.swift
//  pomodoro
//
//  Created by Gokul Rajan on 29.03.23.
//

import SwiftUI

struct ContentView: View {
    @State private var minutes = 25
    @State private var seconds = 0
    @State private var isBreakTime = false
    @State private var isPaused = true
    @State private var timer: Timer?
    
    private var timeRemaining: Int {
        return minutes * 60 + seconds
    }
    
    private var pomodoroTime: Int {
        return isBreakTime ? 5 * 60 : minutes * 60 + seconds
    }
    
    private var breakTime: Int {
        return isBreakTime ? minutes * 60 + seconds : 5 * 60
    }
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Text("\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))")
                .font(.system(size: 80))
                .padding()
            
            HStack {
                Button(action: {
                    if isPaused {
                        startTimer()
                    } else {
                        pauseTimer()
                    }
                }) {
                    Image(systemName: isPaused ? "play" : "pause")
                        .font(.system(size: 30))
                        .tint(Color.white)
                }
                .padding()
                
                Button(action: resetTimer) {
                    Image(systemName: "arrow.counterclockwise")
                        .font(.system(size: 30))
                }
                .padding()
            }
            
            HStack {
 
                Spacer()

                Button(action: {
                    isBreakTime = false
                    resetTimer()
                }) {
                    Text("Pomodoro")
                        .foregroundColor(isBreakTime ? .secondary : Color.white)
                        .font(.system(size: 20))
                        .bold()
                }
                .padding()
                
                Spacer()
            }
            
            HStack {
 
                Spacer()

                Button(action: {
                    isBreakTime = true
                    resetTimer()
                }) {
                    Text("Break")
                        .foregroundColor(isBreakTime ? Color.white : .secondary)
                        .font(.system(size: 20))
                        .bold()
                }
                .padding()
                
                Spacer()
            }
            
            Spacer()
        }
        .onAppear {
            resetTimer()
        }
        .padding()
        .foregroundColor(Color.white)
        .background(Color.black)
        .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: .topLeading
            )
    }
    
    private func startTimer() {
        isPaused = false
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                seconds -= 1
                if seconds < 0 {
                    seconds = 59
                    minutes -= 1
                }
            } else {
                resetTimer()
            }
        }
    }
    
    private func pauseTimer() {
        isPaused = true
        timer?.invalidate()
        timer = nil
    }
    
    private func resetTimer() {
        isPaused = true
        timer?.invalidate()
        timer = nil
        minutes = isBreakTime ? 5 : 25
        seconds = 0
    }
}


    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

