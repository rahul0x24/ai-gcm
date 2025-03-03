import Foundation

/// Utility functions for Git operations
enum GitUtils {
    /// Error types for Git operations
    enum GitError: Error {
        case commandFailed(String)
        case processError(String)
    }
    
    /// Structure to hold git changes
    struct GitChanges {
        let staged: String
        let unstaged: String
    }
    
    /// Run a shell command and return its output
    /// - Parameters:
    ///   - command: The command to run
    ///   - args: Arguments for the command
    /// - Returns: The command output as a string
    /// - Throws: GitError if the command fails
    private static func runCommand(_ command: String, args: [String]) throws -> String {
        let process = Process()
        let pipe = Pipe()
        
        process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        process.arguments = [command] + args
        process.standardOutput = pipe
        process.standardError = pipe
        
        do {
            try process.run()
            process.waitUntilExit()
            
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            guard let output = String(data: data, encoding: .utf8) else {
                throw GitError.processError("Could not decode command output")
            }
            
            guard process.terminationStatus == 0 else {
                throw GitError.commandFailed(output)
            }
            
            return output
        } catch {
            throw GitError.processError(error.localizedDescription)
        }
    }
    
    /// Get both staged and unstaged git changes
    /// - Returns: GitChanges containing staged and unstaged diffs
    static func getGitChanges() -> Result<GitChanges, GitError> {
        do {
            let unstaged = try runCommand("git", args: ["diff"])
            let staged = try runCommand("git", args: ["diff", "--cached"])
            
            return .success(GitChanges(
                staged: staged.trimmingCharacters(in: .whitespacesAndNewlines),
                unstaged: unstaged.trimmingCharacters(in: .whitespacesAndNewlines)
            ))
        } catch {
            return .failure(error as! GitError)
        }
    }
    
    /// Get git status in short format
    /// - Returns: Git status output or error
    static func getGitStatus() -> Result<String, GitError> {
        do {
            let status = try runCommand("git", args: ["status", "--short"])
            return .success(status)
        } catch {
            return .failure(error as! GitError)
        }
    }
    
    /// Stage all git changes
    /// - Returns: Success or failure
    static func stageAllChanges() -> Result<Void, GitError> {
        do {
            _ = try runCommand("git", args: ["add", "-A"])
            return .success(())
        } catch {
            return .failure(error as! GitError)
        }
    }
    
    /// Commit staged changes with the given message
    /// - Parameter message: Commit message
    /// - Returns: Success or failure with message
    static func commitChanges(message: String) -> Result<String, GitError> {
        do {
            _ = try runCommand("git", args: ["commit", "-m", message])
            return .success("Changes committed successfully!")
        } catch {
            return .failure(error as! GitError)
        }
    }
} 
