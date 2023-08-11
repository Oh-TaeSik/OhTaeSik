//
//  PieChartView.swift
//  OhTaeSik
//
//  Created by 이승진 on 2023/08/01.
//

import SwiftUI

@available(iOS 13.0, *)
public struct PieChartView: View {
    public let values: [Double]
    public let names: [String]
    public let formatter: (Double) -> String
    
    public var colors: [Color]
    public var backgroundColor: Color
    
    public var widthFraction: CGFloat
    public var innerRadiusFraction: CGFloat
    
    @State private var activeIndex: Int = -1
    @StateObject var viewModel = ReadViewModel()

    var slices: [PieSliceData] {
        let sum = values.reduce(0, +)
        var endDeg: Double = 0
        var tempSlices: [PieSliceData] = []
        
        for (i, value) in values.enumerated() {
            let degrees: Double = value * 360 / sum
            tempSlices.append(PieSliceData(startAngle: Angle(degrees: endDeg), endAngle: Angle(degrees: endDeg + degrees), text: String(format: "%.0f%%", value * 100 / sum), color: self.colors[i]))
            endDeg += degrees
        }
        return tempSlices
    }
    
    public init(values:[Double], names: [String], formatter: @escaping (Double) -> String, colors: [Color] = [Color.pink, Color.mint, Color.yellow], backgroundColor: Color = Color(red: 21 / 255, green: 24 / 255, blue: 30 / 255, opacity: 1.0), widthFraction: CGFloat = 0.75, innerRadiusFraction: CGFloat = 0.60){
        self.values = values
        self.names = names
        self.formatter = formatter
        
        self.colors = colors
        self.backgroundColor = backgroundColor
        self.widthFraction = widthFraction
        self.innerRadiusFraction = innerRadiusFraction
    }
    
    public var body: some View {
        GeometryReader { geometry in
            VStack{
                ZStack{
                    ForEach(0..<self.values.count, id: \.self){ i in
                        PieSliceView(pieSliceData: self.slices[i])
                            .scaleEffect(self.activeIndex == i ? 1.03 : 1)
//                            .animation(Animation.spring())
//                            .withAnimation(Animation.spring())
//                            .animation(self.activeIndex == i ? .spring() : nil)
                    }
                    .frame(width: widthFraction * geometry.size.width, height: widthFraction * geometry.size.width)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                let radius = 0.5 * widthFraction * geometry.size.width
                                let diff = CGPoint(x: value.location.x - radius, y: radius - value.location.y)
                                let dist = pow(pow(diff.x, 2.0) + pow(diff.y, 2.0), 0.5)
                                if (dist > radius || dist < radius * innerRadiusFraction) {
                                    self.activeIndex = -1
                                    return
                                }
                                var radians = Double(atan2(diff.x, diff.y))
                                if (radians < 0) {
                                    radians = 2 * Double.pi + radians
                                }
                                
                                for (i, slice) in slices.enumerated() {
                                    if (radians < slice.endAngle.radians) {
                                        self.activeIndex = i
                                        break
                                    }
                                }
                            }
                            .onEnded { value in
                                self.activeIndex = -1
                            }
                    )
                    Circle()
                        .fill(self.backgroundColor)
                        .frame(width: widthFraction * geometry.size.width * innerRadiusFraction, height: widthFraction * geometry.size.width * innerRadiusFraction)
                    
                    VStack {
                        Text(self.activeIndex == -1 ? "Total" : names[self.activeIndex])
                            .font(.title)
                            .foregroundColor(Color.gray)
                        if viewModel.totalCalorie != nil {
                            Text(self.formatter(self.activeIndex == -1 ? Double(viewModel.totalCalorie ?? "0") ?? 0.0 : values[self.activeIndex]))
                                .font(.title)
                        } else {
                            Text("0 kcal")
                                .font(.title)
                        }
                    }
                    .onAppear() {
                        viewModel.observeTotalCalorie()
                    }
                }
                PieChartRows(colors: self.colors, names: self.names, values: self.values.map { self.formatter($0) }, percents: self.values.map { String(format: "%.0f%%", $0 * 100 / self.values.reduce(0, +)) })
                GeometryReader { gr in
                    Path { g in
                        let rect = CGRect(origin: .zero, size: gr.size) // 그림을 그릴 수 있는 사각형
                        g.move(to: CGPoint(x: rect.size.width/2, y: 0))
                        g.addQuadCurve(
                            to: CGPoint(x: rect.size.width/2, y: rect.size.height),
                            control: CGPoint(x: rect.width, y: rect.height)
                        )
                        g.addQuadCurve(
                            to: CGPoint(x: rect.size.width/2, y: 0),
                            control: CGPoint(x: 0, y: rect.height)
                        )
                    }
                    .fill(
                        LinearGradient(
                            gradient: Gradient (
                                colors: [Color.pink, Color.mint, Color.yellow]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                }
            }
            .background(self.backgroundColor)
            .foregroundColor(Color.white)
        }
    }
}


@available(iOS 13.0, *)
struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView(values: [12, 543, 995], names: ["탄수화물", "단백질", "지방"], formatter: {value in String(format: "%.1f(g)", value)})
    }
}

