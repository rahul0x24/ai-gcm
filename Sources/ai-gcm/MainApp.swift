import ArgumentParser
import Foundation

/// Main command structure for the AI-GCM tool
@main
struct AIGCM: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "ai-gcm",
        abstract: "A tool for Git Commit Message generation using AI",
        version: "1.0.0"
    )
} 
