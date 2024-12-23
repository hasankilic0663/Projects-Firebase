//
//  ContentView.swift
//  BitirmeDeneme
//
//  Created by Hasan Hüseyin Kılıç on 10.11.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = NewsViewModel()
    @State private var urlText = ""
    @State private var progress: CGFloat = 0.3
    
    var body: some View {
        ZStack {
            Color(red: 8/255, green: 8/255, blue: 44/255)
                .ignoresSafeArea() // Tüm ekranı kaplasın
            
            VStack {
                Spacer()
                Image("imagesss")
                    .frame(width: 50, height: 50)
                    .scaledToFit()
                Text("Sahte Haber Tespiti")
                    .font(.title)
                    .foregroundStyle(.white)
                    .padding()
                
                TextField("Haber URL'si girin", text: $urlText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    .padding()
                    
                
                Button(action: {
                    viewModel.validateNews(url: urlText)
                }) {
                    Text("Doğruluğunu Kontrol Et")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(viewModel.isLoading)
                .padding()
                
                if viewModel.isLoading {
                    ProgressView("Yükleniyor...")
                    
                }
                
                if let result = viewModel.validationResult {
                    VStack {
                        Text("Doğruluk Oranı: \(Int(result.accuracy * 100))%")
                            .font(.headline)
                            .foregroundColor(result.accuracy > 0.5 ? .green : .red)
                        
                        Text(result.explanation)
                            .font(.subheadline)
                            .padding()
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8)
                        .fill(result.accuracy > 0.5 ? Color.green.opacity(0.2) : Color.red.opacity(0.2)))
                    .padding()
                }
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                    ZStack {
                                  // Çemberin dış halkası
                                  Circle()
                                      .stroke(Color.gray.opacity(0.3), lineWidth: 10)
                                      .frame(width: 150, height: 150)
                                  
                                  // İlerleyen Çember
                                  Circle()
                                      .trim(from: 0.0, to: progress) // Orana göre çemberin kesilmesi
                                      .stroke(Color.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                                      .frame(width: 150, height: 150)
                                      .rotationEffect(.degrees(-90)) // Başlangıç noktası yukarıya alınır
                                      .animation(.easeInOut(duration: 1.0), value: progress)
                              }
                }
               
              
                          
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
