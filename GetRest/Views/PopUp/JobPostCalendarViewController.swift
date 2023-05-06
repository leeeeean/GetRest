//
//  JobPostCalendarViewController.swift
//  GetRest
//
//  Created by 최리안 on 2023/05/06.
//

import UIKit

protocol JobPostCalendarButtonTappedDelegate: AnyObject {
    func calendarConfirmButtonTapped(date: String)
}

final class JobPostCalendarViewController: UIViewController {
    private lazy var backgroundView: UIView = {
        let view = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: self.view.frame.size.width,
            height: self.view.frame.size.height
        ))
        view.backgroundColor = .gray
        view.layer.opacity = 0.5
        
        return view
    }()
    
    private lazy var calendarBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()

    private lazy var datePickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self

        currentDateToPickerDate(pickerView)
        return pickerView
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        button.backgroundColor = .appColor(.darkGray)
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        button.backgroundColor = .appColor(.baseGreen)
        button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelConfirmStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        
        return stackView
    }()
    
    private let calendarData: [[Int]] = [Array(2012...2023), Array(1...12), Array(1...31)]
    private var pickedDate: String = "2012.01.01"
    var currentDate = "2012.01.01"
    
    weak var delegate: JobPostCalendarButtonTappedDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setPickerView(datePickerView)
    }
    
    private func currentDateToPickerDate(_ picker: UIPickerView) {
        let yearMonthDay = dateToYearMonthDay(currentDate)
        let yearRow = yearMonthDay.0 - 2012
        picker.selectRow(yearRow, inComponent: 0, animated: true)
        picker.selectRow(yearMonthDay.1-1, inComponent: 1, animated: true)
        picker.selectRow(yearMonthDay.2-1, inComponent: 2, animated: true)
    }
    
    private func dateToYearMonthDay(_ date: String) -> (Int, Int, Int) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. dd"
        let strToDate = dateFormatter.date(from: date)!
        
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"
        let year = Int(yearFormatter.string(from: strToDate)) ?? 2023
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MM"
        let month = Int(monthFormatter.string(from: strToDate)) ?? 4
        
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "dd"
        let day = Int(dayFormatter.string(from: strToDate)) ?? 15
        
        return (year, month, day)
    }
    
    private func setPickerView(_ pickerView: UIPickerView) {
        pickerView.subviews[1].backgroundColor = .clear
        
        let line1 = UIView(frame: CGRect(x: 10, y: 0, width: 60, height: 2))
        let line2 = UIView(frame: CGRect(x: 10, y: 48, width: 60, height: 2))
        let line3 = UIView(frame: CGRect(x: 100, y: 0, width: 60, height: 2))
        let line4 = UIView(frame: CGRect(x: 100, y: 48, width: 60, height: 2))
        let line5 = UIView(frame: CGRect(x: 190, y: 0, width: 60, height: 2))
        let line6 = UIView(frame: CGRect(x: 190, y: 48, width: 60, height: 2))
        [line1, line2, line3, line4, line5, line6]
            .forEach({ $0.backgroundColor = .appColor(.baseGreen) })
        
        [line1, line2, line3, line4, line5, line6]
            .forEach { pickerView.subviews[1].addSubview($0) }
    }
    
    private func layout() {
        
        view.backgroundColor = .clear
        
        [backgroundView, calendarBackgroundView]
            .forEach({ view.addSubview($0) })
        backgroundView.snp.makeConstraints{
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        calendarBackgroundView.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.height.equalTo(270.0)
            $0.width.equalTo(300.0)
        }
        
        [
            datePickerView,
            cancelConfirmStackView,
        ]
            .forEach({ calendarBackgroundView.addSubview($0) })
        
        datePickerView.snp.makeConstraints{
            $0.top.equalToSuperview().inset(20.0)
            $0.bottom.equalTo(cancelConfirmStackView.snp.top).offset(-20.0)
            $0.leading.trailing.equalToSuperview().inset(10.0)
        }
        cancelConfirmStackView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(60.0)
        }
        
        [cancelButton, confirmButton]
            .forEach({ cancelConfirmStackView.addArrangedSubview($0) })
    }
}

extension JobPostCalendarViewController {
    @objc func confirmButtonTapped() {
        dismiss(animated: true)
        delegate?.calendarConfirmButtonTapped(date: pickedDate)
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
}

extension JobPostCalendarViewController {}

extension JobPostCalendarViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        52
    }
}

extension JobPostCalendarViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        calendarData[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        "\(calendarData[component][row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let year = calendarData[0][pickerView.selectedRow(inComponent: 0)]
        let month = String(format: "%02d", calendarData[1][pickerView.selectedRow(inComponent: 1)])
        let day = String(format: "%02d", calendarData[2][pickerView.selectedRow(inComponent: 2)])
        
        pickedDate = "\(year). \(month). \(day)"
    }
}
