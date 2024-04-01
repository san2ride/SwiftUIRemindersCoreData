//
//  ReminderStatsView.swift
//  RemindersSwiftUICoreData
//
//  Created by Cause I'm Electric on 3/29/24.
//

import SwiftUI

struct ReminderStatsView: View {
    
    let icon: String
    let title: String
    let count: Int?
    let iconColor: Color = .blue
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Image(systemName: icon)
                        .foregroundColor(iconColor)
                        .font(.title)
                    Text(title)
                        .opacity(0.8)
                }
                Spacer()
                if let count {
                    Text("\(count)")
                        .font(.largeTitle)
                }
            }.padding()
                .frame(maxWidth: .infinity)
                .background(colorScheme == .dark ? Color.darkGray : Color.offWhite)
                .foregroundColor(colorScheme == .dark ? Color.offWhite : Color.darkGray)
                .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
        }
    }
}

#Preview {
    ReminderStatsView(icon: "calendar",
                      title: "Today",
                      count: 9)
}
