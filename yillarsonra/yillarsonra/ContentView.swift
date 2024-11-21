//
//  ContentView.swift
//  yillarsonra
//
//  Created by Hasan Hüseyin Kılıç on 6.11.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                
                .font(.largeTitle)
                .foregroundStyle(.tint)
                .padding()
            HStack {
                Text("SwiftUI")
                    .font(.headline)
                    .foregroundStyle(.black)
                Text("by Yillarson")
                    .font(.caption)
                    .foregroundStyle(.black)
                    .padding(.horizontal, 10)
                    .overlay {
                       
                        ZStack {
                            Rectangle()
                                .stroke()
                            
                            Rectangle()
                                .stroke(style: StrokeStyle(lineWidth: 10, color: .black))
                        }
                    }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
