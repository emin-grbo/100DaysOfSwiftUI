//
//  QuestionStyling.swift
//  MultiplicationTable
//
//  Created by roblack on 11/3/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct QuestionStyling: ViewModifier {
    let question: questionType
    var style: (color: Color, opacity: Double) {
        switch question {
        case .unanswered: return (Color.white, 0.5)
        case .correct: return (Color.green, 1)
        case .wrong: return (Color.red, 1)
        }
    }
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(style.color)
            .opacity(style.opacity)
    }
}

extension View {
    func colorize(question: questionType) -> some View {
        self.modifier(QuestionStyling(question: question))
    }
}
