//
//  ContentView.swift
//  ICloud App
//
//  Created by Fedor Sychev on 20.11.2021.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack {
            Text("Hello! Here you can create notes!")
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .padding()
                .frame(width: screen.width*0.9, height: 100)
                .background(LinearGradient(colors: [Color.blue.opacity(0.3), Color.red.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color.blue.opacity(0.4), radius: 10, x: -10, y: -10)
            .shadow(color: Color.red.opacity(0.4), radius: 10, x: 10, y: 10)
            Spacer()
        }
    }
}

let screen = UIScreen.main.bounds

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
