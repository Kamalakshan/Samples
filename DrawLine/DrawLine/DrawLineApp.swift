//
//  DrawLineApp.swift
//  DrawLine
import SwiftUI

struct ColoredLineDrawingView: View {
    @State private var lines: [[CGPoint]] = []
    @State private var currentLine: [CGPoint] = []
    @State private var colors: [Color] = [Color.red, Color.green, Color.blue, Color.white]

    var body: some View {
        GeometryReader { _ in
            ZStack {
                Path { path in
                    let line = currentLine
                    if let firstPoint = line.first {
                        path.move(to: firstPoint)
                        for point in line {
                            path.addLine(to: point)
                        }
                    }
                }
                .stroke(LinearGradient(gradient: Gradient(colors: colors), startPoint: .leading, endPoint: .trailing), lineWidth: 5)
                .background(Color.black)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            let point = value.location
                            currentLine.append(point)
                        }

                        .onEnded { _ in
                            lines.append(currentLine)
                        }
                )
                VStack {
                    Spacer()
                    Button("Clear") {
                        currentLine.removeAll()
                    }
                    .padding()
                }
            }
        }
    }
}

@main
struct ColoredLineDrawingApp: App {
    var body: some Scene {
        WindowGroup {
            ColoredLineDrawingView()
        }
    }
}
