import Foundation

struct PasswordValidator {
    static func isValid(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{10,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }

    static func validate(password: String, confirmation: String) -> (isValid: Bool, error: String?) {
        guard password == confirmation else {
            return (false, "Passwords do not match.")
        }

        guard isValid(password) else {
            return (
                false,
                "Password must be at least 10 characters long, contain an uppercase letter, a lowercase letter, a number, and a special character."
            )
        }

        return (true, nil)
    }
}
