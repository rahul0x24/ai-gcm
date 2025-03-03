import Foundation

/// Utility functions for AI operations
enum AIUtils {
    /// Error types for AI operations
    enum AIError: Error {
        case modelUnavailable
        case generationFailed(String)
        case invalidResponse(String)
    }
    
    /// Get list of available Ollama models
    /// - Returns: Array of available model names
    static func getAvailableModels() -> [String] {
        // TODO: Implement Ollama API integration
        // For now, return an empty array as we'll need to implement the HTTP client
        return []
    }
    
    /// Check if a model is available in Ollama
    /// - Parameter model: The name of the model to check
    /// - Returns: Tuple containing availability status and list of available models
    static func checkModelAvailability(model: String) -> (isAvailable: Bool, availableModels: [String]) {
        let availableModels = getAvailableModels()
        let modelBase = model.split(separator: ":").first.map(String.init) ?? model
        
        let isAvailable = availableModels.contains { model in
            model == modelBase || model.hasPrefix("\(modelBase):")
        }
        
        return (isAvailable, availableModels)
    }
    
    /// Get a summary of the code changes using the specified model
    /// - Parameters:
    ///   - diff: The git diff content
    ///   - model: The model to use for summarization
    /// - Returns: Result containing the summary or error
    static func getCodeSummary(diff: String, model: String) async -> Result<String, AIError> {
        // TODO: Implement Ollama API integration
        // For now, return a placeholder error
        return .failure(.modelUnavailable)
    }
    
    /// Generate a commit message based on the code summary
    /// - Parameters:
    ///   - summary: The code change summary
    ///   - model: The model to use for commit message generation
    /// - Returns: Result containing the commit message or error
    static func generateCommitMessage(summary: String, model: String) async -> Result<CommitMessage, AIError> {
        // TODO: Implement Ollama API integration
        // For now, return a placeholder error
        return .failure(.modelUnavailable)
    }
} 
