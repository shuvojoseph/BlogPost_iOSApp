//
//  BeautifulOutlineButtonStyle.swift
//  BlogPost_iOSApp
//
//  Created by Shuvo Joseph on 29/8/25.
//

import SwiftUI

struct BeautifulOutlineButtonStyle: ButtonStyle {
    var foregroundColor: Color = .blue
    var borderColor: Color = .blue
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.white)
            .foregroundColor(foregroundColor)
            .font(.subheadline)
            .fontWeight(.semibold)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(borderColor, lineWidth: 1)
            )
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

// Extension for relative date formatting
extension Date {
    func formatted(date: Date.FormatStyle.DateStyle, time: Date.FormatStyle.TimeStyle) -> String {
        self.formatted(.dateTime.year().month().day().hour().minute())
    }
}
