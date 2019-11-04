//
//  TableValue.swift
//  MultiplicationTable
//
//  Created by roblack on 10/30/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import Foundation

class TableValue: ObservableObject {
    
    init() {
        self.numberOfQuestions = UserDefaults.standard.integer(forKey: "qNum")
        self.value = UserDefaults.standard.integer(forKey: "tableValue")
        self.questionsArray = [questionType]()
    }
    
    var questionsArray: [questionType]
    
    @Published var numberOfQuestions: Int  {
           didSet {
               UserDefaults.standard.set(self.numberOfQuestions, forKey: "qNum")
            questionsArray = [questionType]()
            for _ in 1...numberOfQuestions {
                
                questionsArray.append(questionType.unanswered)
            }
           }
       }
    
    @Published var value: Int {
        didSet {
            UserDefaults.standard.set(self.value, forKey: "tableValue")
        }
    }
}

enum questionType {
    case unanswered
    case correct
    case wrong
}


