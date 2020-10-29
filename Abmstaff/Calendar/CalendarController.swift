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
    
    private var datesRange: [Date]?
    @IBOutlet weak var calendar: FSCalendar!
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarSetup()

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
        let tenDaysLater = Calendar.current.date(byAdding: .day, value: 15, to: today)!
        return tenDaysLater
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        if firstDate == nil {
            firstDate = date
            datesRange = [firstDate!]
            
            print("datesRange contains: \(datesRange!)")
            
            return
        }
        
        if firstDate != nil && lastDate == nil {
            if date <= firstDate! {
                calendar.deselect(firstDate!)
                firstDate = date
                datesRange = [firstDate!]
                
                print("datesRange contains: \(datesRange!)")
                
                return
            }
            
            let range = datesRange(from: firstDate!, to: date)
            lastDate = range.last
            for d in range {
                calendar.select(d)
            }
            
            datesRange = range
            print("datesRange contains: \(datesRange!)")
            
            return
        }
        
        if firstDate != nil && lastDate != nil {
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }
            
            lastDate = nil
            firstDate = nil
            
            datesRange = []
            print("datesRange contains: \(datesRange!)")
        }
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        if firstDate != nil && lastDate != nil {
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }
            
            lastDate = nil
            firstDate = nil
            datesRange = []
            print("datesRange contains: \(datesRange!)")
        }
    }
}

