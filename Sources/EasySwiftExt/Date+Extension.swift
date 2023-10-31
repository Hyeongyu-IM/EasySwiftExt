//
//  Date+Extension.swift
//  bbarge
//
//  Created by 임현규 on 2022/04/25.
//

import Foundation

///사용할 데이트포맷 설정
public enum DateFormat: String {
    ///yyyy-MM-dd hh:mm:ss
    case defaultFormat = "yyyy-MM-dd hh:mm:ss"
    ///yyyy-MM-dd HH:mm:ss
    case default24Format = "yyyy-MM-dd HH:mm:ss"
    ///dd-MM-yyyy hh:mm:ss.SSSSS
    case requestDateFormat = "dd-MM-yyyy hh:mm:ss.SSSSS"
    ///yyyyMMddHHmmss
    case YYYYMMDDHHmmss = "yyyyMMddHHmmss"
    ///yyyyMMddHHmm
    case YYYYMMDDHHmm = "yyyyMMddHHmm"
    ///yyyyMMdd
    case YYYYMMDD = "yyyyMMdd"
    ///yyyyMM
    case YYYYMM = "yyyyMM"
    ///yyyyDotM
    case YYYYDotM = "yyyy.M"
    ///YYYYMMddHH:mm
    case YYYYMMddHH_mm = "YYYYMMddHH:mm"
    ///YYYY.MM.dd HH:mm
    case YYYYDotMMDotddSpaceHH_mm = "YYYY.MM.dd HH:mm"
    ///YY.MM.dd HH:mm
    case YYDotMMDotddSpaceHH_mm = "YY.MM.dd HH:mm"
    ///yyyy.MM
    case YYYYDotMM = "yyyy.MM"
    ////yyyy년  mm월
    case YYYYyearMMmonth = "YYYY년 MM월"
    ///yyyy-MM-dd
    case YYYYdashMMdashDD = "yyyy-MM-dd"
    ///yyyy.MM.dd
    case YYYYdotMMdotDD = "yyyy.MM.dd"
    ///yy.MM.dd
    case YYdotMMdotDD = "yy.MM.dd"
    ///HH:mm
    case HH_mm = "HH:mm"
    ///MM월 dd일
    case MMMonthddDay = "MM월 dd일"
    ///M월 d일
    case MD = "M월 d일"
    ///M월 dd일
    case MDD = "M월 dd일"
    ///M월 d일(EEE)
    case MDEEE = "M월 d일(EEE)"
    ///H : m
    case H_m = "H : m"
    ///yyyy년 MM월 dd일
    case YYYYMMddwithText = "yyyy년 MM월 dd일"
    ///yyyy. MM. dd
    case YYYYDotSpaceMMDotSpaceDDDot = "yyyy. MM. dd"
    ///yyyy.MM.dd(EEE) HH:mm
    case YYYYDotMMDotDDEEEHH_mm = "yyyy.MM.dd(EEE) HH:mm"
    ///yyyy.MM.dd(EEE)
    case YYYYDotMMDotDDEEE = "yyyy.MM.dd(EEE)"
    ///yyyy.MM.dd (E)
    case yyyyMMDDdotSpaceE = "yyyy.MM.dd (E)"
}

extension Date {
    func convertToString(withFormat format: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.timeZone = .KR
        dateFormatter.locale = .KR
        return dateFormatter.string(from: self)
    }
    
    ///#오전#오후 구분
    func isAM() -> Bool {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: self)
        if let hour = components.hour {
            return hour < 12
        }
        return false
    }
    
    /**
     현재 시간의 분을 반환합니다.
     - Returns: 현재 시간의 분 TimeZone(abbreviation: "GMT") nil인 경우 -1
     */
    func getMin() -> Int {
        var calendar = Calendar.current
        guard let timeZone = TimeZone(abbreviation: "GMT") else { return -1 }
        calendar.timeZone = timeZone
        let diff = calendar.dateComponents([.minute], from: self)
        if let min = diff.minute {
            return min
        }
        return 0
    }
}

// MARK: - Initializers
public extension Date {
    /**
    특정 캘린더 구성 요소로부터 새로운 날짜를 생성합니다.

    - Parameters:
      - calendar: 캘린더 (기본값은 그레고리력).
      - timeZone: 시간대 (기본값은 한국 표준시).
      - era: 연대 (기본값은 현재 연대).
      - year: 년 (기본값은 현재 년도).
      - month: 월 (기본값은 현재 월).
      - day: 일 (기본값은 오늘).
      - hour: 시간 (기본값은 현재 시간).
      - minute: 분 (기본값은 현재 분).
      - second: 초 (기본값은 현재 초).
      - nanosecond: 나노초 (기본값은 현재 나노초).
    */
    init?(
        calendar: Calendar? = Calendar(identifier: .gregorian),
        timeZone: TimeZone? = .KR,
        era: Int? = Date().era,
        year: Int? = Date().year,
        month: Int? = Date().month,
        day: Int? = Date().day,
        hour: Int? = Date().hour,
        minute: Int? = Date().minute,
        second: Int? = Date().second,
        nanosecond: Int? = Date().nanosecond) {
        var components = DateComponents()
        components.calendar = calendar
        components.timeZone = timeZone
        components.era = era
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        components.nanosecond = nanosecond

        guard let date = calendar?.date(from: components) else { return nil }
        self = date
    }

    /**
    UNIX 타임스탬프로부터 새로운 날짜 객체를 생성합니다.

    - Parameters:
      - unixTimestamp: UNIX 타임스탬프.
    */
    init(unixTimestamp: Double) {
        self.init(timeIntervalSince1970: unixTimestamp)
    }

    /**
    정수 리터럴로부터 날짜 객체를 생성합니다.

    - Parameters:
      - value: 정수 값, 예: 20171225 또는 2017_12_25 등.
    */
    init?(integerLiteral value: Int) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        guard let date = formatter.date(from: String(value)) else { return nil }
        self = date
    }

}

// MARK: - Properties
public extension Date {
    var calendar: Calendar { Calendar.current }

    var year: Int {
        get {
            return calendar.component(.year, from: self)
        }
        set {
            guard newValue > 0 else { return }
            let currentYear = calendar.component(.year, from: self)
            let yearsToAdd = newValue - currentYear
            if let date = calendar.date(byAdding: .year, value: yearsToAdd, to: self) {
                self = date
            }
        }
    }

    var month: Int {
        get {
            return calendar.component(.month, from: self)
        }
        set {
            let allowedRange = calendar.range(of: .month, in: .year, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentMonth = calendar.component(.month, from: self)
            let monthsToAdd = newValue - currentMonth
            if let date = calendar.date(byAdding: .month, value: monthsToAdd, to: self) {
                self = date
            }
        }
    }

    var day: Int {
        get {
            return calendar.component(.day, from: self)
        }
        set {
            let allowedRange = calendar.range(of: .day, in: .month, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentDay = calendar.component(.day, from: self)
            let daysToAdd = newValue - currentDay
            if let date = calendar.date(byAdding: .day, value: daysToAdd, to: self) {
                self = date
            }
        }
    }

    var weekday: Int {
        return calendar.component(.weekday, from: self)
    }

    var hour: Int {
        get {
            return calendar.component(.hour, from: self)
        }
        set {
            let allowedRange = calendar.range(of: .hour, in: .day, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentHour = calendar.component(.hour, from: self)
            let hoursToAdd = newValue - currentHour
            if let date = calendar.date(byAdding: .hour, value: hoursToAdd, to: self) {
                self = date
            }
        }
    }

    var minute: Int {
        get {
            return calendar.component(.minute, from: self)
        }
        set {
            let allowedRange = calendar.range(of: .minute, in: .hour, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentMinutes = calendar.component(.minute, from: self)
            let minutesToAdd = newValue - currentMinutes
            if let date = calendar.date(byAdding: .minute, value: minutesToAdd, to: self) {
                self = date
            }
        }
    }

    var second: Int {
        get {
            return calendar.component(.second, from: self)
        }
        set {
            let allowedRange = calendar.range(of: .second, in: .minute, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentSeconds = calendar.component(.second, from: self)
            let secondsToAdd = newValue - currentSeconds
            if let date = calendar.date(byAdding: .second, value: secondsToAdd, to: self) {
                self = date
            }
        }
    }

    var nanosecond: Int {
        get {
            return calendar.component(.nanosecond, from: self)
        }
        set {
            #if targetEnvironment(macCatalyst)
            // The `Calendar` implementation in `macCatalyst` does not know that a nanosecond is 1/1,000,000,000th of a second
            let allowedRange = 0..<1_000_000_000
            #else
            let allowedRange = calendar.range(of: .nanosecond, in: .second, for: self)!
            #endif
            guard allowedRange.contains(newValue) else { return }

            let currentNanoseconds = calendar.component(.nanosecond, from: self)
            let nanosecondsToAdd = newValue - currentNanoseconds

            if let date = calendar.date(byAdding: .nanosecond, value: nanosecondsToAdd, to: self) {
                self = date
            }
        }
    }

    var millisecond: Int {
        get {
            return calendar.component(.nanosecond, from: self) / 1_000_000
        }
        set {
            let nanoSeconds = newValue * 1_000_000
            #if targetEnvironment(macCatalyst)
            // The `Calendar` implementation in `macCatalyst` does not know that a nanosecond is 1/1,000,000,000th of a second
            let allowedRange = 0..<1_000_000_000
            #else
            let allowedRange = calendar.range(of: .nanosecond, in: .second, for: self)!
            #endif
            guard allowedRange.contains(nanoSeconds) else { return }

            if let date = calendar.date(bySetting: .nanosecond, value: nanoSeconds, of: self) {
                self = date
            }
        }
    }
    
    func isPastTime(date: Date) -> Bool {
        var calendar = Calendar.current
        calendar.timeZone = .KR
        let diff = calendar.dateComponents([.minute], from: self, to: date)
        if let min = diff.minute {
            return min < 0
        }
        return false
    }
    
    func isPastDay(date: Date) -> Bool {
        var calendar = Calendar.current
        calendar.timeZone = .KR
        let diff = calendar.dateComponents([.day], from: self, to: date)
        if let day = diff.day { return day < 0 }
        return false
    }
}

// MARK: - Methods
public extension Date {
    func adding(_ component: Calendar.Component, value: Int) -> Date {
        return calendar.date(byAdding: component, value: value, to: self)!
    }

    mutating func add(_ component: Calendar.Component, value: Int) {
        if let date = calendar.date(byAdding: component, value: value, to: self) {
            self = date
        }
    }

    func beginning(of component: Calendar.Component) -> Date? {
        if component == .day {
            return calendar.startOfDay(for: self)
        }

        var components: Set<Calendar.Component> {
            switch component {
            case .second:
                return [.year, .month, .day, .hour, .minute, .second]

            case .minute:
                return [.year, .month, .day, .hour, .minute]

            case .hour:
                return [.year, .month, .day, .hour]

            case .weekOfYear, .weekOfMonth:
                return [.yearForWeekOfYear, .weekOfYear]

            case .month:
                return [.year, .month]

            case .year:
                return [.year]

            default:
                return []
            }
        }

        guard !components.isEmpty else { return nil }
        return calendar.date(from: calendar.dateComponents(components, from: self))
    }

    func end(of component: Calendar.Component) -> Date? {
        switch component {
        case .second:
            var date = adding(.second, value: 1)
            date = calendar.date(from:
                calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date))!
            date.add(.second, value: -1)
            return date

        case .minute:
            var date = adding(.minute, value: 1)
            let after = calendar.date(from:
                calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date))!
            date = after.adding(.second, value: -1)
            return date

        case .hour:
            var date = adding(.hour, value: 1)
            let after = calendar.date(from:
                calendar.dateComponents([.year, .month, .day, .hour], from: date))!
            date = after.adding(.second, value: -1)
            return date

        case .day:
            var date = adding(.day, value: 1)
            date = calendar.startOfDay(for: date)
            date.add(.second, value: -1)
            return date

        case .weekOfYear, .weekOfMonth:
            var date = self
            let beginningOfWeek = calendar.date(from:
                calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
            date = beginningOfWeek.adding(.day, value: 7).adding(.second, value: -1)
            return date

        case .month:
            var date = adding(.month, value: 1)
            let after = calendar.date(from:
                calendar.dateComponents([.year, .month], from: date))!
            date = after.adding(.second, value: -1)
            return date

        case .year:
            var date = adding(.year, value: 1)
            let after = calendar.date(from:
                calendar.dateComponents([.year], from: date))!
            date = after.adding(.second, value: -1)
            return date

        default:
            return nil
        }
    }

    func dayName(ofStyle style: DayNameStyle = .full) -> String {
        // http://www.codingexplorer.com/swiftly-getting-human-readable-date-nsdateformatter/
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .KR
        dateFormatter.timeZone = .KR
        var format: String {
            switch style {
            case .oneLetter:
                return "EEEEE"
            case .threeLetters:
                return "EEE"
            case .full:
                return "EEEE"
            }
        }
        dateFormatter.setLocalizedDateFormatFromTemplate(format)
        return dateFormatter.string(from: self)
    }
}

extension Date {
    func isSameDay(date: Date) -> Bool {
        var calendar = Calendar.current
        calendar.timeZone = .KR
        return calendar.compare(self, to: date, toGranularity: .day) == .orderedSame
    }
    func isSameMonth(date: Date) -> Bool {
        var calendar = Calendar.current
        calendar.timeZone = .KR
        return calendar.compare(self, to: date, toGranularity: .month) == .orderedSame
    }
}
