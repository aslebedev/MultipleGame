//
//  Questions.swift
//  MultipleGame
//
//  Created by alexander on 02.11.2019.
//  Copyright © 2019 alexander. All rights reserved.
//

import SwiftUI

struct Questions: View {
    
    @State private var answer = ""
    @State private var scores = 0
    @State private var questionsCounter = 0
    @State private var isCorrectAnswer: Bool?
    @State private var answerResult = ""
    @State private var showAnswerResult = false
    @State private var isGameOver = false
    @State private var gradientColor = Color.white
    
    var questions: [(Int, Int)]
    
    init(questions: [(Int, Int)]) {
        self.questions = questions
    }

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.white, gradientColor]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack (alignment: .center){
                
                if isGameOver {
                    Text("GAME OVER")
                        .font(.largeTitle)
                    Text("Your score: \(scores)")
                        .font(.title)
                } else {
                    
                    VStack (spacing: 44) {
                        Text(answerResult)
                            .opacity(showAnswerResult ? 1 : 0)
                        VStack {
                            Text("What is \(questions[questionsCounter].0) x \(questions[questionsCounter].1)?")
                            
                            TextField("", text: $answer)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.center)
                                .frame(width: 150, height: 30)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.black, lineWidth: 1)
                                )
                            
                            Button( action: {
                                self.checkAnswer()
                            }) {
                                Text("SUBMIT")
                            }
                        }
                    }
                }
            }
        }
    }
    
    func checkAnswer() {
        if answer.isEmpty { return }
        
        if Int(answer) == questions[questionsCounter].0 * questions[questionsCounter].1 {
            answerResult = "CORRECT"
            gradientColor = .green
            scores += 1
            isCorrectAnswer = true
        } else {
            answerResult = "WRONG"
            gradientColor = .red
            scores -= 1
            isCorrectAnswer = false
        }
        
        showAnswerResult = true
        questionsCounter += 1
        answer = ""
        
        if questionsCounter >= questions.count {
            gradientColor = .blue
            isGameOver = true
        }
    }
}

struct Questions_Previews: PreviewProvider {
    static var previews: some View {
        Questions(questions: [(Int, Int)]() )
    }
}
