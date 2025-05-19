import Foundation

extension String {
    public var localized: String {
        let kLocalizedStringNotFound = "kLocalizedStringNotFound"
        var string = Bundle.main.localizedString(forKey: self, value: kLocalizedStringNotFound, table: nil)
        
        // not found
        if string == kLocalizedStringNotFound {
            string = self
        }
        
        return string;
    }
    
    public func localizeWithFormat(arguments: CVarArg...) -> String{
        return String(format: self.localized, arguments: arguments)
    }
    
    func replacingGermanUmlauts() -> String {
        let replacements: [String: String] = [
            "ä": "ae",
            "ö": "oe",
            "ü": "ue",
            "Ä": "Ae",
            "Ö": "Oe",
            "Ü": "Ue",
            "ß": "ss",
            
        ]
        
        var newString = self
        
        for (umlaut, replacement) in replacements {
            newString = newString.replacingOccurrences(of: umlaut, with: replacement)
        }
        
        return newString
    }
    
    func sanitizedFileName() -> String {
        let invalidCharacters = CharacterSet(charactersIn: "\\/:*?\"<>|").union(.whitespacesAndNewlines).union(.illegalCharacters).union(.controlCharacters)
        return self.components(separatedBy: invalidCharacters).joined(separator: "_")
    }
}
