//
//  BeautifulButtonStyle.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 29/8/25.
//
import SwiftUI

struct BeautifulButtonStyle: ButtonStyle {
    var backgroundColor: Color = .blue
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(backgroundColor)
            .foregroundColor(.white)
            .font(.headline)
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .shadow(color: backgroundColor.opacity(0.3), radius: 5, x: 0, y: 2)
    }
}
