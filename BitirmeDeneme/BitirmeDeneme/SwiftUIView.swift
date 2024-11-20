//
//  SwiftUIView.swift
//  BitirmeDeneme
//
//  Created by Hasan Hüseyin Kılıç on 18.11.2024.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        ZStack{
            Color.black
            .edgesIgnoringSafeArea(.all)
            VStack{
                Text("Alpha")
                    .foregroundStyle(
                        Color.white
                    )
                    .font(.title)
                    .padding()
                
                Spacer()
                VStack(alignment: .leading){
                    Text("Adınızı Giriniz")
                        .foregroundStyle(Color.white)
                        
                        
                    TextField("Adınızı Giriniz" , text: .constant(""))
                        
                }
                .padding(.horizontal)
                .frame(width: 300, height: 60)
               
                
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
                .foregroundStyle(Color.white)
               
                Spacer()
            }
            
            
          
            
        }
      
        
    }
}

#Preview {
    SwiftUIView()
}
