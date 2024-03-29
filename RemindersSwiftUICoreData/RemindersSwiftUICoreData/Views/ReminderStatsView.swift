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
                .background(.green)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
        }
    }
}

#Preview {
    ReminderStatsView(icon: "calendar",
                      title: "Today",
                      count: 9)
}
