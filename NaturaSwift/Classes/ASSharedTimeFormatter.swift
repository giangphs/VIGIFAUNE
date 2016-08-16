//
//  ASSharedTimeFormatter.swift
//  NaturaSwift
//
//  Created by Manh on 6/27/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
class ASSharedTimeFormatter: NSObject {
    /**
     *	@Author Clément Padovani, 14-09-29 10:09
     *
     *	@brief  NSDateFormatter with date format of type: yyyy-MM-dd'T'HH:mm:ssZZZZ
     */
    
    var _inputFormatter:NSDateFormatter!;
    
    /**
     *	@Author Clément Padovani, 14-09-29 10:09
     *
     *	@brief  NSDateFormatter with date format of type: dd-MM-yyyy HH:mm
     */
    
    var _outputFormatter:NSDateFormatter!;
    
    /**
     *	@Author Clément Padovani, 14-09-29 10:09
     *
     *	@brief  NSDateFormatter with date format of type: dd/MM/yyyy
     */
    
    var _dateFormatter:NSDateFormatter!;
    
    /**
     *	@Author Clément Padovani, 14-09-29 10:09
     *
     *	@brief  NSDateFormatter with date format of type: dd-MM-yyyy H:mm
     */
    
    var _timeFormatter:NSDateFormatter!;
    
    /**
     *	@Author Clément Padovani, 14-09-29 10:09
     *
     *	@brief  NSDateFormatter with date format of type: d MMM yyyy à h:mm
     */
    
    var _outputFormatterBis:NSDateFormatter!;
    
    /**
     *	@Author Clément Padovani, 14-09-29 10:09
     *
     *	@brief  NSDateFormatter with date format of type: yyyy-M-d
     */
    
    var _dateFormatterBis:NSDateFormatter!;
    
    /**
     *	@Author Clément Padovani, 14-09-29 10:09
     *
     *	@brief  NSDateFormatter with date format of type: dd/MM/yyyy HH:mm
     */
    
    var _dateFormatterTer:NSDateFormatter!;
    
    /**
     *	@Author Clément Padovani, 14-09-29 10:09
     *
     *	@brief  NSDateFormatter with date format of type: d MMMM
     */
    
    var _monthFormatter:NSDateFormatter!;
    
    /**
     *	@Author Clément Padovani, 14-09-29 10:09
     *
     *	@brief  NSDateFormatter with date format of type: EEEE
     */
    
    var _weekDayFormatter:NSDateFormatter!;
    
    /**
     *	@Author Clément Padovani, 14-09-30 08:09
     *
     *	@brief  NSDateFormatter with date format of type: EEEE d MMMM
     */
    
    var _sectionHeaderViewDateFormatter:NSDateFormatter!;
    
    /**
     *	@Author Clément Padovani, 14-10-01 08:10
     *
     *	@brief  NSDateFormatter with relative formatting.
     */
    
    var _sectionHeaderViewDateRelativeFormatter:NSDateFormatter!;
    
    /**
     *	@Author Clément Padovani, 14-09-30 11:09
     *
     *	@brief  NSDateFormatter with date format of type: HH:mm
     */
    
    var _timeFormatterBis:NSDateFormatter!;
    
    /**
     *	@Author Clément Padovani, 14-09-29 10:09
     *
     *	@brief  Use this singleton to access the date formatters.
     *
     *	@return The shared time formatter singleton.
     */
    static func checkFormatString(formatString: String,forFormatter dateFormatter: NSDateFormatter)
    {
        let formatterFormatString: String = dateFormatter.dateFormat;
        assert(formatString == formatterFormatString, "ASSERT. \(formatterFormatString) format string is supposed to be equal to \(formatString)");
    }

    static let sharedFormatter = ASSharedTimeFormatter();
    
    override init() {
        super.init();
        
    }
    
    func inputFormatter() -> NSDateFormatter {
        if (_inputFormatter == nil) {
            let inputFormatter: NSDateFormatter = NSDateFormatter();
            inputFormatter.locale = NSLocale(localeIdentifier: "fr_FR");
            inputFormatter.timeZone = NSTimeZone(name: "Europe/Paris");
            inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ";
            _inputFormatter = inputFormatter;
        }
        return _inputFormatter;
    }
    func outputFormatter() -> NSDateFormatter {
        if (_outputFormatter == nil) {
            let outputFormatter: NSDateFormatter = NSDateFormatter();
            outputFormatter.locale = NSLocale(localeIdentifier: "fr_FR");
            outputFormatter.timeZone = NSTimeZone(name: "Europe/Paris");
            outputFormatter.dateFormat = "dd-MM-yyyy HH:mm";
            _outputFormatter = outputFormatter;
        }
        return _outputFormatter;
    }
    func dateFormatter() -> NSDateFormatter {
        if (_dateFormatter == nil) {
            let dateFormatter: NSDateFormatter = NSDateFormatter();
            dateFormatter.locale = NSLocale(localeIdentifier: "fr_FR");
            dateFormatter.timeZone = NSTimeZone(name: "Europe/Paris");
            dateFormatter.dateFormat = "dd/MM/yyyy";
            _dateFormatter = dateFormatter;
        }
        return _dateFormatter;
    }
    func timeFormatter() -> NSDateFormatter {
        if (_timeFormatter == nil) {
            let timeFormatter: NSDateFormatter = NSDateFormatter();
            timeFormatter.locale = NSLocale(localeIdentifier: "fr_FR");
            timeFormatter.timeZone = NSTimeZone(name: "Europe/Paris");
            timeFormatter.dateFormat = "dd-MM-yyyy H:mm";
            _timeFormatter = timeFormatter;
        }
        return _timeFormatter;
    }
    func outputFormatterBis() -> NSDateFormatter {
        if (_outputFormatterBis == nil) {
            let outputFormatterBis: NSDateFormatter = NSDateFormatter();
            outputFormatterBis.locale = NSLocale(localeIdentifier: "fr_FR");
            outputFormatterBis.timeZone = NSTimeZone(name: "Europe/Paris");
            outputFormatterBis.dateFormat = "d MMM yyyy à H:mm";
            _outputFormatterBis = outputFormatterBis;
        }
        return _outputFormatterBis;
    }
    func dateFormatterBis() -> NSDateFormatter {
        if (_dateFormatterBis == nil) {
            let dateFormatterBis: NSDateFormatter = NSDateFormatter();
            dateFormatterBis.locale = NSLocale(localeIdentifier: "fr_FR");
            dateFormatterBis.timeZone = NSTimeZone(name: "Europe/Paris");
            dateFormatterBis.dateFormat = "d MMM yyy";
            _dateFormatterBis = dateFormatterBis;
        }
        return _dateFormatterBis;
    }
    func dateFormatterTer() -> NSDateFormatter {
        if (_dateFormatterTer == nil) {
            let dateFormatterTer: NSDateFormatter = NSDateFormatter();
            dateFormatterTer.locale = NSLocale(localeIdentifier: "fr_FR");
            dateFormatterTer.timeZone = NSTimeZone(name: "Europe/Paris");
            dateFormatterTer.dateFormat = "dd/MM/yyyy HH:mm";
            _dateFormatterTer = dateFormatterTer;
        }
        return _dateFormatterTer;
    }
    func monthFormatter() -> NSDateFormatter {
        if (_monthFormatter == nil) {
            let monthFormatter: NSDateFormatter = NSDateFormatter();
            monthFormatter.locale = NSLocale(localeIdentifier: "fr_FR");
            monthFormatter.timeZone = NSTimeZone(name: "Europe/Paris");
            monthFormatter.dateFormat = "d MMMM";
            _monthFormatter = monthFormatter;
        }
        return _monthFormatter;
    }
    func fnweekDayFormatter() -> NSDateFormatter {
        if (_weekDayFormatter == nil) {
            let weekDayFormatter: NSDateFormatter = NSDateFormatter();
            weekDayFormatter.locale = NSLocale(localeIdentifier: "fr_FR");
            weekDayFormatter.timeZone = NSTimeZone(name: "Europe/Paris");
            weekDayFormatter.dateFormat = "d MMMM";
            _weekDayFormatter = weekDayFormatter;
        }
        return _weekDayFormatter;
    }
    func sectionHeaderViewDateFormatter() -> NSDateFormatter {
        if (_sectionHeaderViewDateFormatter == nil) {
            let sectionHeaderViewDateFormatter: NSDateFormatter = NSDateFormatter();
            sectionHeaderViewDateFormatter.locale = NSLocale(localeIdentifier: "fr_FR");
            sectionHeaderViewDateFormatter.timeZone = NSTimeZone(name: "Europe/Paris");
            sectionHeaderViewDateFormatter.dateFormat = "EEEE d MMMM";
            _sectionHeaderViewDateFormatter = sectionHeaderViewDateFormatter;
        }
        return _sectionHeaderViewDateFormatter;
    }
    func sectionHeaderViewDateRelativeFormatter() -> NSDateFormatter {
        if (_sectionHeaderViewDateRelativeFormatter == nil) {
            let sectionHeaderViewDateRelativeFormatter: NSDateFormatter = NSDateFormatter();
            sectionHeaderViewDateRelativeFormatter.locale = NSLocale(localeIdentifier: "fr_FR");
            sectionHeaderViewDateRelativeFormatter.timeZone = NSTimeZone(name: "Europe/Paris");
            sectionHeaderViewDateRelativeFormatter.timeStyle = NSDateFormatterStyle.NoStyle;
            sectionHeaderViewDateRelativeFormatter.dateStyle = NSDateFormatterStyle.ShortStyle;
            sectionHeaderViewDateRelativeFormatter.doesRelativeDateFormatting = true;
            _sectionHeaderViewDateRelativeFormatter = sectionHeaderViewDateRelativeFormatter;
        }
        return _sectionHeaderViewDateRelativeFormatter;
    }
    func timeFormatterBis() -> NSDateFormatter {
        if (_timeFormatterBis == nil) {
            let timeFormatterBis: NSDateFormatter = NSDateFormatter();
            timeFormatterBis.locale = NSLocale(localeIdentifier: "fr_FR");
            timeFormatterBis.timeZone = NSTimeZone(name: "Europe/Paris");
            timeFormatterBis.dateFormat = "HH:mm";
            _timeFormatterBis = timeFormatterBis;
        }
        return _timeFormatterBis;
    }
    
    
}