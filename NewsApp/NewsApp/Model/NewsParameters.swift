//
//  File.swift
//  NewsApp
//
//  Created by Andrew on 4/10/18.
//  Copyright © 2018 Andrew Konchak. All rights reserved.
//

import UIKit

public enum NewsCategory: String {
    
    case business = "Business"
    case politics = "Politics"
    case sport = "Sport"
    case technology = "Technology"
    case general = "General"
    
    static let allCategories: [NewsCategory] = [.general, .business, .politics, .sport, .technology]
    
    var tabBarTag: Int {
        switch self {
        case .general:
            return 0
        case .business:
            return 1
        case .politics:
            return 2
        case .sport:
            return 3
        case .technology:
            return 4
        }
    }
    
    var tabBarImg: UIImage {
        switch self {
        case .general:
            return #imageLiteral(resourceName: "all")
        case .business:
            return #imageLiteral(resourceName: "business")
        case .politics:
            return #imageLiteral(resourceName: "politics")
        case .sport:
            return #imageLiteral(resourceName: "sport")
        case .technology:
            return #imageLiteral(resourceName: "technology")
        }
    
    }
    
}

public enum NewsSources : String {
    case AustralianBroadcastCorporation = "abc-news-au"
    case ArsTechnica = "ars-technica"
    case AP = "associated-press"
    case BBC = "bbc-news"
    case BBCSport = "bbc-sport"
    case Bild = "bild"
    case Bloomberg = "bloomberg"
    case BusinessInsider = "business-insider"
    case BusinessInsiderUK = "business-insider-uk"
    case BuzzFeed = "buzzfeed"
    case CNBC = "cnbc"
    case CNN = "cnn"
    case DailyMail = "daily-mail"
    case Engadget = "engadget"
    case EntertainmentWeekly = "entertainment-weekly"
    case ESPN = "espn"
    case ESPNCricInfo = "espn-cric-info"
    case FinancialTimes = "financial-times"
    case Focus = "focus"
    case FootballItalia = "football-italia"
    case Fortune = "fortune"
    case FourFourTwo = "four-four-two"
    case FoxSports = "fox-sports"
    case Google = "google-news"
    case GruenderSzene = "gruender-szene"
    case HackerNews = "hacker-news"
    case IGN = "ign"
    case Independent = "independent"
    case Mashable = "mashable"
    case Metro = "metro"
    case Mirror = "mirror"
    case MTVNews = "mtv-news"
    case MTVNewsUK = "mtv-news-uk"
    case NatGeo = "national-geographic"
    case NewScientist = "new-scientist"
    case NewsWeek = "newsweek"
    case NewYorkMagazine = "new-york-magazine"
    case NFLNews = "nfl-news"
    case Polygon = "polygon"
    case Recode = "recode"
    case Reddit = "reddit-r-all"
    case Reuters = "reuters"
    case SkyNews = "sky-news"
    case SkySportsNews = "sky-sports-news"
    case SpiegelOnline = "spiegel-online"
    case t3n = "t3n"
    case TalkSport = "talksport"
    case TechCrunch = "techcrunch"
    case TechRadar = "techradar"
    case TheEconomist = "the-economist"
    case TheGuardianAU = "the-guardian-au"
    case TheGuardianUK = "the-guardian-uk"
    case TheHindu = "the-hindu"
    case HuffPo = "the-huffington-post"
    case TheLadBible = "the-lad-bible"
    case NTY = "the-new-york-times"
    case TNW = "the-next-web"
    case TheSportBible = "the-sport-bible"
    case TheTelegraph = "the-telegraph"
    case TheTimesOfIndia = "the-times-of-india"
    case TheVerge = "the-verge"
    case WSJ = "the-wall-street-journal"
    case TheWatshingtonPost = "the-washington-post"
    case Time = "timet"
    case USA = "usa-today"
    case Wired = "wired-de"
    
}

public enum NewsCountry: String {
    case australia = "au"
    case germany = "de"
    case unitedKingdom = "gb"
    case india = "in"
    case italy = "it"
    case unitedStates = "us"
    case russia = "ru"
    case ukraine = "ua"
}

