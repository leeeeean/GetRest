//
//  CalendarViewController.swift
//  GetRest
//
//  Created by 최리안 on 2023/04/26.
//

import UIKit
import RxCocoa
import RxSwift

final class PortfolioCalendarViewController: UIViewController {
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
    
    private lazy var startDateButton: UIButton = {
        let button = UIButton()
        buttonSetting(button)
        let date = todayDate()
        button.setTitle("시작일\n\(date)", for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(startDateButtonTapped), for: .touchUpInside)
        buttonDateToPickerDate(startPickerView, date: date)
        
        return button
    }()
    
    private lazy var endDateButton: UIButton = {
        let button = UIButton()
        buttonSetting(button)
        let date = todayDate()
        button.setTitle("마침일\n\(date)", for: .normal)
        button.backgroundColor = .appColor(.baseGray)
        button.addTarget(self, action: #selector(endDateButtonTapped), for: .touchUpInside)

        return button
    }()
    
    private func buttonSetting(_ button: UIButton) {
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .light)
    }
    
    private lazy var grayLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var startPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.isHidden = false
        return pickerView
    }()
    
    private lazy var endPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.isHidden = true
        return pickerView
    }()
    
    private lazy var dateButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .appColor(.lightGray)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        
        return stackView
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        button.backgroundColor = .appColor(.darkGray)
        
        return button
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        button.backgroundColor = .appColor(.baseGreen)

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
    let disposeBag = DisposeBag()
    let viewModel = PortfolioCalendarViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        bind(viewModel)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setPickerView(startPickerView)
        setPickerView(endPickerView)
    }
    
    func bind(_ viewModel: PortfolioCalendarViewModel) {
        cancelButton.rx.tap
            .bind { [weak self] _ in
                guard let self else { return }
                self.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        confirmButton.rx.tap
            .map{ [weak self] Void -> String in
                guard let self else { return "" }
                self.dismiss(animated: true)
                let startDate = buttonDateToOnlyDateString(startDateButton)
                let endDate = buttonDateToOnlyDateString(endDateButton)
                return "\(startDate) ~ \(endDate)"
            }
            .bind(to: viewModel.setDate)
            .disposed(by: disposeBag)
    }
    
    private func buttonDateToOnlyDateString(_ button: UIButton) -> String {
        let buttonLabel = (button.titleLabel?.text)!
        let startRangeIndex = buttonLabel.firstIndex(of: "2")
        return String(buttonLabel[startRangeIndex!...])
    }
    
    private func todayDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        let convertString = dateFormatter.string(from: date)
        return convertString
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
    
    private func buttonDateToPickerDate(_ picker: UIPickerView, date: String) {
        let startRangeIndex = date.firstIndex(of: "2")
        let yearMonthDay = dateToYearMonthDay(String(date[startRangeIndex!...]))
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
    
    private func layout() {
        
        view.backgroundColor = .clear
        
        [backgroundView, calendarBackgroundView]
            .forEach({ view.addSubview($0) })
        backgroundView.snp.makeConstraints{
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        calendarBackgroundView.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.height.equalTo(360.0)
            $0.width.equalTo(300.0)
        }
        
        [
            dateButtonStackView,
            grayLineView,
            startPickerView,
            endPickerView,
            cancelConfirmStackView,
        ]
            .forEach({ calendarBackgroundView.addSubview($0) })
        
        dateButtonStackView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(80.0)
        }
        grayLineView.snp.makeConstraints{
            $0.top.equalTo(dateButtonStackView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0.5)
        }
        startPickerView.snp.makeConstraints{
            $0.top.equalTo(grayLineView.snp.bottom).offset(20.0)
            $0.bottom.equalTo(cancelConfirmStackView.snp.top).offset(-20.0)
            $0.leading.trailing.equalToSuperview().inset(10.0)
        }
        endPickerView.snp.makeConstraints{
            $0.top.equalTo(grayLineView.snp.bottom).offset(20.0)
            $0.bottom.equalTo(cancelConfirmStackView.snp.top).offset(-20.0)
            $0.leading.trailing.equalToSuperview().inset(10.0)
        }
        cancelConfirmStackView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(60.0)
        }
        
        [startDateButton, endDateButton]
            .forEach({ dateButtonStackView.addArrangedSubview($0) })
        
        [cancelButton, confirmButton]
            .forEach({ cancelConfirmStackView.addArrangedSubview($0) })
    }
}

extension PortfolioCalendarViewController {
    @objc func startDateButtonTapped() {
        startDateButton.backgroundColor = .white
        endDateButton.backgroundColor = .appColor(.baseGray)
        startPickerView.isHidden = false
        endPickerView.isHidden = true
        
        let date = startDateButton.titleLabel?.text
        buttonDateToPickerDate(startPickerView, date: date!)
    }
    
    @objc func endDateButtonTapped() {
        endDateButton.backgroundColor = .white
        startDateButton.backgroundColor = .appColor(.baseGray)
        endPickerView.isHidden = false
        startPickerView.isHidden = true
        
        let date = endDateButton.titleLabel?.text
        buttonDateToPickerDate(endPickerView, date: date!)
    }
}

extension PortfolioCalendarViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        48
    }
}

extension PortfolioCalendarViewController: UIPickerViewDataSource {
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
        let month = calendarData[1][pickerView.selectedRow(inComponent: 1)]
        let day = calendarData[2][pickerView.selectedRow(inComponent: 2)]
        
        if pickerView == startPickerView {
            startDateButton.setTitle("시작일\n\(year). \(month). \(day)", for: .normal)
        } else {
            endDateButton.setTitle("마침일\n\(year). \(month). \(day)", for: .normal)
        }
    }
}
