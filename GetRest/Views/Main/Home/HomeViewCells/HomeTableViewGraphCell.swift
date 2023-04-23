//
//  HomeTableViewGraphCell.swift
//  GetRest
//
//  Created by 최리안 on 2023/04/21.
//

import UIKit
import Charts

final class HomeTableViewGraphCell: UITableViewCell {
    static let identifier = "HomeTableViewGraphCell"
    
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.isUserInteractionEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var chart: BarChartView = {
        let chart = BarChartView()
        return chart
    }()

    func layout(){
        
        addSubview(scrollView)
        scrollView.snp.makeConstraints{
            $0.edges.equalToSuperview().inset(16.0)
        }
        
        let data = 4
        containerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.height.equalToSuperview()
            $0.width.equalTo(data * 150)
        }
        scrollView.setContentOffset(CGPoint(
            x: (data * 150) - Int(UIScreen.main.bounds.size.width) + 16,
            // scrollview 길이 - 폰의 가로 길이 + scrollview trailing inset
            y: 0
        ), animated: true)
        
        containerView.addSubview(chart)
        chart.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview().inset(10.0)
        }
        
        setChart()
        setDataCount(3, range: 3)
    }
    
    func setChart() {
        chart.chartDescription.enabled = false
        chart.pinchZoomEnabled = false
        chart.drawBarShadowEnabled = false
        chart.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
        let xAxis = chart.xAxis
        xAxis.centerAxisLabelsEnabled = true
        xAxis.labelPosition = .bottom
        xAxis.centerAxisLabelsEnabled = true
        xAxis.labelFont = .systemFont(ofSize: 15, weight: .medium)
        xAxis.granularity = 1
        xAxis.drawGridLinesEnabled = false
        xAxis.drawAxisLineEnabled = false
        
        chart.rightAxis.enabled = false
        chart.leftAxis.drawLabelsEnabled = false
        chart.leftAxis.drawAxisLineEnabled = false
        chart.leftAxis.axisMaximum = 15.0
        chart.leftAxis.axisMinimum = 0.0
        chart.leftAxis.setLabelCount(5, force: true)
        chart.legend.enabled = false
    }
    
    func setDataCount(_ count: Int, range: UInt32)   {
        let groupSpace = 0.2
        let barSpace = 0.1
        let barWidth = 0.1
        // (0.2 + 0.03) * 4 + 0.08 = 1.00 -> interval per "group"
        
        let groupCount = count + 1
        let startYear = 2020
        let endYear = startYear + groupCount
        
        let block: (Int) -> BarChartDataEntry = { (i) -> BarChartDataEntry in
            return BarChartDataEntry(x: Double(i), y: Double(10))
        }
        
        let yVals1 = (startYear ..< endYear).map(block)
        let yVals2 = (startYear ..< endYear).map(block)
        let yVals3 = (startYear ..< endYear).map(block)
        let yVals4 = (startYear ..< endYear).map(block)
        
        let set1 = BarChartDataSet(entries: yVals1, label: "c1")
        set1.setColor(UIColor.appColor(.baseGray))
        let set2 = BarChartDataSet(entries: yVals2, label: "c2")
        set2.setColor(UIColor.appColor(.baseGray))
        let set3 = BarChartDataSet(entries: yVals3, label: "c3")
        set3.setColor(UIColor.appColor(.baseGray))
        let set4 = BarChartDataSet(entries: yVals4, label: "c4")
        set4.setColors(UIColor.appColor(.baseGray), UIColor.appColor(.baseGray), UIColor.appColor(.baseGray), UIColor.appColor(.baseGreen))
        
        let data: BarChartData = [set1, set2, set3, set4]
        
        data.barWidth = barWidth
        
        chart.xAxis.axisMinimum = Double(startYear)
        chart.xAxis.axisMaximum = 2024

        data.groupBars(fromX: Double(startYear), groupSpace: groupSpace, barSpace: barSpace)

        chart.data = data
    }
}

