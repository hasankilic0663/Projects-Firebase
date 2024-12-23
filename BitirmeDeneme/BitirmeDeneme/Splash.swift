//
//  Splash.swift
//  BitirmeDeneme
//
//  Created by Hasan Hüseyin Kılıç on 3.12.2024.
//
import SwiftUI

struct Splash: View {
    @State private var isActive = false
    @State private var scaleEffect = 0.5
    @State private var opacity = 0.5

    var body: some View {
        if isActive {
            // Splash ekranından sonra yönlenecek ana ekran
            ContentView()
        } else {
            ZStack {
                Color(red: 8/255, green: 8/255, blue: 44/255)
                    .ignoresSafeArea() // Tüm ekranı kaplasın
                
                VStack {
                    Image("imagesss")
                        .resizable()
                        .scaledToFit()
//                        .frame(width: 200, height: 200)
                        .scaleEffect(scaleEffect)
                        .opacity(opacity)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 2.5)) {
                                scaleEffect = 1.0
                                opacity = 1.0
                            }
                        }
                    
                    
                }
            }
            .onAppear {
                // Splash ekranının süresi (2 saniye sonra ana ekrana geçiş)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    Splash()
}
