//
//  CounterView.swift
//  concurrency_ground
//
//  Created by sudo takuya on 2024/04/25.
//

import SwiftUI

class Counter: ObservableObject {
    @Published var count = 0
    
    func increment() async {
        count = count + 1
    }
}

struct CounterView: View {
    
    @StateObject var counter = Counter()
    
    var body: some View {
        VStack {
            Button(action: {
                Task {
                    await counter.increment()
                }
            }, label: {
                Text("increment")
            })
            Text("\(counter.count)")
        }
    }
}

#Preview {
    CounterView()
}
