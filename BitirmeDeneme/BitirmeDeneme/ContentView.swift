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
    
    var body: some View {
        VStack {
            Text("Sahte Haber Tespiti")
                .font(.title)
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
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
