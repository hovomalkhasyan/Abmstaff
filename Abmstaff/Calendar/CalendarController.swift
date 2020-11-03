//
//  CalendarController.swift
//  Abmstaff
//
//  Created by Hovo on 10/26/20.
//

import UIKit
import FSCalendar

class CalendarController: UIViewController {
    private var firstDate: Date?
    private var lastDate: Date?
    
    private var datesRange = [Date]()
    private var dates: [Date]? {
        self.datesRange.filter({ (date) -> Bool in
            let calendar = Calendar(identifier: .gregorian)
            return !calendar.isDateInWeekend(date)
        })
    }
    
    @IBOutlet weak var calendar: FSCalendar!
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarSetup()
        
    }
    
    @IBAction func xyz() {
        do {
            let params = try getAllDatesString().asDictionary()
            
            
        } catch {
            print(error)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func calendarSetup() {
        calendar.allowsMultipleSelection = true
        calendar.delegate = self
        calendar.dataSource = self
        
    }
    
    
    private func datesRange(from: Date, to: Date) -> [Date] {
        
        if from > to { return [Date]() }
        
        var tempDate = from
        var array = [tempDate]
        
        while tempDate < to {
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate)
        }
        return array
    }
    
}

extension CalendarController: FSCalendarDelegate, FSCalendarDataSource {
    func minimumDate(for calendar: FSCalendar) -> Date {
        let today = Date()
        let daysLater = Calendar.current.date(byAdding: .day, value: 15, to: today)!
        return daysLater
    }
    
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MMM-dd'T'HH:mm:ss'T"
        
        if firstDate == nil {
            firstDate = date
            datesRange.append(firstDate!)
            
//
            getAllDatesString()
            return
        }
        
        if firstDate != nil && lastDate == nil {
            if date <= firstDate! {
                calendar.deselect(firstDate!)
                firstDate = date
                datesRange.append(firstDate!)
                
                getAllDatesString()
                return
            }
            
            let range = datesRange(from: firstDate!, to: date)
            lastDate = range.last
            for d in range {
                calendar.select(d)
            }
            
            datesRange = range

            getAllDatesString()
            return
        }
        
        if firstDate != nil && lastDate != nil {
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }
            
            lastDate = nil
            firstDate = nil
            
            datesRange = []

        }
       
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        if firstDate != nil && lastDate != nil {
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }
            
            lastDate = nil
            firstDate = nil
            datesRange.removeAll()
            
        }
        
    }
    
    func getAllDatesString() -> VacantionRequestModel {
        if let firstItem = dates?.first {
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .gregorian)
            formatter.timeZone = TimeZone.current
            formatter.dateFormat = "yyyy-MMM-dd'T'HH:mm:ss'T"
            let str = formatter.string(from: firstItem)
            return VacantionRequestModel(startDt: str, days: dates!.count)
        }
        return VacantionRequestModel(startDt: "", days: 0)
    }
    
}

struct VacantionRequestModel: Codable {
    var startDt: String
    var days: Int
}

extension Encodable {
  func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }
}
