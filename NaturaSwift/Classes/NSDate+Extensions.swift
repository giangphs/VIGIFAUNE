//
//  NSDate+Extensions.swift
//  NaturaSwift
//
//  Created by Manh on 6/30/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
extension NSDate
{
    static func convertNSStringDateToNSDateX1(dateString: String?) -> NSDate?
    {
        if dateString == nil {
            return nil;
        }
        let inputFormatter: NSDateFormatter = NSDateFormatter();
        inputFormatter.locale = NSLocale(localeIdentifier: "fr_FR");
        inputFormatter.timeZone = NSTimeZone(name: "Europe/Paris");
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ";
        let convertedDate: NSDate = inputFormatter.dateFromString(dateString!)!;
        return convertedDate;
    }
    func timeAgo() -> String {
        let now: NSDate = NSDate();
        let deltaSeconds: Double = fabs(self.timeIntervalSinceDate(now)) - 5*60 - 20;
        let deltaMinutes: Double = deltaSeconds / 60;
        if(deltaSeconds < 5) {
            return "A l'instant";
        } else if(deltaSeconds < 60) {
            return String(format: "%d seconds ago.",Int(deltaSeconds));
        } else if(deltaSeconds < 120) {
            return "Il y a 1 minute";
        } else if (deltaMinutes < 60) {
            return String(format: "Il y a %d minutes",Int(deltaMinutes));

        } else if (deltaMinutes < 120) {
            return "Il y a 1 heure";
        } else if (deltaMinutes < (24 * 60)) {
            return String(format: "Il y a %d heures",Int(floor(deltaMinutes/60)));
        } else if (deltaMinutes < (24 * 60 * 2)) {
            return "Hier";
        } else if (deltaMinutes < (24 * 60 * 7)) {
            return String(format: "Il y a %d jours",Int(floor(floor(deltaMinutes/(60 * 24)))));

        } else if (deltaMinutes < (24 * 60 * 31)) {
            return String(format: "Il y a %d semaine",Int(floor(deltaMinutes/(60 * 24 * 7))));

        } else if (deltaMinutes < (24 * 60 * 61)) {
            return "Il y a 1 mois";
        } else if (deltaMinutes < (24 * 60 * 365.25)) {
            return String(format: "Il y a %d mois",Int(floor(deltaMinutes/(60 * 24 * 30))));

        } else if (deltaMinutes < (24 * 60 * 731)) {
            return "l'année dernière.";
        }
        return String(format: "Il y a %d ans",Int(floor(deltaMinutes/(60 * 24 * 365))));

    }
}