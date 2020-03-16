//
//  ContentView.swift
//  MultipleGame
//
//  Created by alexander on 28.10.2019.
//  Copyright © 2019 alexander. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isSettingState = true
    @State private var multipleAmount = 2
    @State private var selectedHowManyQuestions = 0
    
    var howManyQuestions = ["5", "10", "20", "All"]
    
    var body: some View {
        VStack {
            Spacer()
            
            if isSettingState {
                
                VStack (spacing: 44) {
                    GridStack(rows: 3, columns: 4) { row, col in
                        Button( action : {
                            self.multipleAmount = (col + 1) + row * 4
                        }) {
                            ZStack {
                                //Image("\(self.pictures.items[(col + 1) + row * 4])")
                                Text("\((col + 1) + row * 4)")
                                    .frame(width: 70, height: 50)
                                    .background(Color.red)
                            }
                        }
                    }
                    VStack {
                        Section(header: Text("How many questions you wont?")) {
                            Picker("Quantity of questions selection", selection: $selectedHowManyQuestions) {
                                ForEach(0..<howManyQuestions.count) {
                                    Text("\(self.howManyQuestions[$0])")
                                }
                            }.pickerStyle(SegmentedPickerStyle())
                        }
                    }
                }
            } else {
                Questions(questions: generateQuestions(howManyQuestions: howManyQuestions[selectedHowManyQuestions]))
            }
            
            Spacer()
            
            Button(action: {
                self.isSettingState.toggle()
            }) {
                Text(self.isSettingState ? "Start Game" : "Restart Game")
            }
        }
    }
    
    func generateQuestions(howManyQuestions: String) -> [(Int, Int)] {
        var result = [(Int, Int)]()
        let questionsWantCount: Int
        
        switch howManyQuestions {
        case "5":
            questionsWantCount = 5
        case "10":
            questionsWantCount = 10
        case "20":
            questionsWantCount = 20
        case "All":
            questionsWantCount = multipleAmount * 12
        default:
            fatalError()
        }
        
        for firstMultiple in 1...12 {
            for secondMultiple in 1...multipleAmount {
                result.append((firstMultiple, secondMultiple))
            }
        }
        
        let numbersLeft = questionsWantCount - result.count
        
        if numbersLeft > 0 {
            for _ in 1...numbersLeft {
                result.append( ( (Int.random(in: 1...12), Int.random(in: 1...multipleAmount) ) ) )
            }
        }
        
        return Array(result.shuffled()[0 ..< questionsWantCount])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
