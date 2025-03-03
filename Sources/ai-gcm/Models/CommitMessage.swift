import Foundation

/// A structure representing a conventional commit message
struct CommitMessage: Codable {
    /// The commit message that follows conventional commit format.
    /// Must be between 1 and 72 characters long and start with a type (e.g., feat, fix, etc.).
    let message: String
    
    enum ValidationError: Error {
        case messageTooShort
        case messageTooLong
        case invalidFormat
    }
    
    init(message: String) throws {
        // Validate message length
        guard message.count >= 1 else {
            throw ValidationError.messageTooShort
        }
        guard message.count <= 72 else {
            throw ValidationError.messageTooLong
        }
        
        // Validate conventional commit format
        let commitTypes = ["feat", "fix", "refactor", "docs", "style", "test", "chore"]
        let hasValidPrefix = commitTypes.contains { message.lowercased().hasPrefix("\($0):") }
        guard hasValidPrefix else {
            throw ValidationError.invalidFormat
        }
        
        self.message = message
    }
} 
