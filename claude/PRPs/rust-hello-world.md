name: "Rust Hello World Project Setup PRP"
description: |
  Complete setup of a basic Rust "Hello, World!" project with proper structure, 
  testing, and development tooling configuration

---

## Goal

**Feature Goal**: Set up a complete, production-ready Rust "Hello, World!" project with proper project structure, testing framework, and development tooling

**Deliverable**: A fully functional Rust binary application that prints "Hello, world!" with unit tests, proper project structure, and all necessary configuration files

**Success Definition**: Project compiles, runs, passes all tests, and follows Rust community best practices with zero warnings from clippy and properly formatted code

## User Persona (if applicable)

**Target User**: Developer new to Rust or setting up first Rust project in this workspace

**Use Case**: Creating a foundation Rust project to serve as a template for future Rust development

**User Journey**: 
1. Developer runs cargo commands to create project
2. Project structure is created following Rust conventions
3. Code compiles and runs successfully
4. Tests pass and validate functionality
5. Project serves as foundation for expansion

**Pain Points Addressed**: 
- Uncertainty about proper Rust project structure
- Need for working example with tests
- Foundation for learning Rust development

## Why

- Establishes Rust development capability in the workspace
- Provides foundation for future Rust projects
- Demonstrates proper Rust project structure and conventions
- Enables learning and experimentation with Rust language

## What

Create a minimal but complete Rust application that:
- Prints "Hello, world!" to stdout
- Has proper Cargo.toml configuration
- Includes unit tests
- Follows Rust naming and structure conventions
- Passes all linting and formatting checks

### Success Criteria

- [ ] Project created with standard Rust structure
- [ ] Main.rs prints "Hello, world!" when executed
- [ ] Unit tests pass successfully
- [ ] Code formatted with rustfmt
- [ ] Zero warnings from clippy
- [ ] Documentation comments included

## All Needed Context

### Context Completeness Check

_Before writing this PRP, validate: "If someone knew nothing about this codebase, would they have everything needed to implement this successfully?"_

### Documentation & References

```yaml
# MUST READ - Include these in your context window
- url: https://doc.rust-lang.org/book/ch01-02-hello-world.html
  why: Official Rust Book's Hello World tutorial - exact steps and explanations
  critical: Shows proper main function syntax and println! macro usage

- url: https://doc.rust-lang.org/book/ch01-03-hello-cargo.html
  why: Cargo project creation and management fundamentals
  critical: Explains cargo new, cargo build, cargo run commands

- url: https://doc.rust-lang.org/cargo/guide/project-layout.html
  why: Defines standard Rust project directory structure
  critical: Must follow this exact structure for cargo to work properly

- url: https://doc.rust-lang.org/book/ch11-01-writing-tests.html
  why: How to write unit tests in Rust
  critical: Shows #[test] attribute and assert macros

- docfile: PRPs/ai_docs/rust_hello_world_setup.md
  why: Complete reference with exact code templates and commands
  section: All sections - this is the primary implementation guide
```

### Current Codebase tree (run `tree` in the root of the project) to get an overview of the codebase

```bash
/Users/vvonkledge/workspaces/spark/
├── PRPs/
│   ├── README.md
│   ├── templates/
│   │   └── prp_base.md
│   └── ai_docs/
│       └── rust_hello_world_setup.md
└── (other temporary example files from research)
```

### Desired Codebase tree with files to be added and responsibility of file

```bash
/Users/vvonkledge/workspaces/spark/
├── PRPs/                          # (existing)
├── hello_world/                   # Root directory of Rust project
│   ├── Cargo.toml                # Package manifest with metadata and dependencies
│   ├── src/                      # Source code directory
│   │   └── main.rs              # Entry point with main() function
│   └── tests/                    # Integration tests directory
│       └── integration_test.rs  # Basic integration test file
```

### Known Gotchas of our codebase & Library Quirks

```rust
// CRITICAL: This is a new Rust project in empty workspace
// No existing Rust conventions to follow
// Must establish patterns for future projects

// GOTCHA: println! is a macro, not a function - requires !
// GOTCHA: Semicolons required at end of statements
// GOTCHA: main() function must have exact signature: fn main() { }
// GOTCHA: Use snake_case for file names and functions
// GOTCHA: Use CamelCase for types and traits
```

## Implementation Blueprint

### Data models and structure

For this simple hello world project, we'll implement:

```rust
// Simple greeting function for demonstration
fn greet(name: &str) -> String {
    format!("Hello, {}!", name)
}

// Main function - entry point
fn main() {
    println!("Hello, world!");
}
```

### Implementation Tasks (ordered by dependencies)

```yaml
Task 1: CREATE hello_world project structure
  - EXECUTE: cargo new hello_world
  - VERIFY: Directory structure created at /Users/vvonkledge/workspaces/spark/hello_world
  - NAMING: Project name must be snake_case
  - PLACEMENT: Create as subdirectory in spark workspace

Task 2: MODIFY hello_world/Cargo.toml
  - IMPLEMENT: Complete package metadata
  - FOLLOW pattern: PRPs/ai_docs/rust_hello_world_setup.md (Cargo.toml Template section)
  - ADD: authors, description, license fields
  - PRESERVE: name, version, edition fields from cargo new

Task 3: MODIFY hello_world/src/main.rs
  - IMPLEMENT: greet function and enhanced main function
  - FOLLOW pattern: PRPs/ai_docs/rust_hello_world_setup.md (Unit Test section)
  - NAMING: greet function in snake_case
  - ADD: Unit test module with #[cfg(test)]

Task 4: CREATE hello_world/tests/integration_test.rs
  - IMPLEMENT: Basic integration test structure
  - FOLLOW pattern: PRPs/ai_docs/rust_hello_world_setup.md (Integration Test section)
  - NAMING: test functions start with test_
  - PLACEMENT: Must be in tests/ directory at project root

Task 5: VALIDATE build and execution
  - EXECUTE: cargo build in hello_world directory
  - VERIFY: No compilation errors
  - EXECUTE: cargo run
  - VERIFY: Outputs "Hello, world!" to stdout

Task 6: VALIDATE testing and code quality
  - EXECUTE: cargo test
  - VERIFY: All tests pass
  - EXECUTE: cargo fmt
  - EXECUTE: cargo clippy
  - VERIFY: No warnings or errors
```

### Implementation Patterns & Key Details

```rust
// PATTERN: Main function - must be exactly this signature
fn main() {
    println!("Hello, world!");  // CRITICAL: println! with exclamation mark
}

// PATTERN: Unit test module structure
#[cfg(test)]  // CRITICAL: This attribute excludes tests from release builds
mod tests {
    use super::*;  // CRITICAL: Import parent module items
    
    #[test]  // CRITICAL: Marks function as test
    fn test_greet() {
        assert_eq!(greet("Rust"), "Hello, Rust!");
    }
}

// PATTERN: Integration test file structure
// File: tests/integration_test.rs
#[test]
fn test_hello_world_runs() {
    // Integration tests treat crate as external dependency
    assert!(true);  // Placeholder - would test actual functionality
}

// PATTERN: Cargo.toml required fields
[package]
name = "hello_world"  // CRITICAL: Must match directory name
version = "0.1.0"     // CRITICAL: SemVer format
edition = "2021"      // CRITICAL: Rust edition - use 2021
```

### Integration Points

```yaml
FILESYSTEM:
  - location: /Users/vvonkledge/workspaces/spark/hello_world
  - permissions: Standard directory permissions (755)

ENVIRONMENT:
  - PATH: Must include $HOME/.cargo/bin for cargo commands
  - RUST_BACKTRACE: Set to 1 for debugging if needed

TOOLCHAIN:
  - rustc: Rust compiler (installed via rustup)
  - cargo: Package manager (installed with Rust)
  - rustfmt: Code formatter (included in default installation)
  - clippy: Linter (included in default installation)
```

## Validation Loop

### Level 1: Syntax & Style (Immediate Feedback)

```bash
# Navigate to project directory
cd /Users/vvonkledge/workspaces/spark/hello_world

# Format code
cargo fmt

# Check for common mistakes
cargo clippy

# Quick compilation check
cargo check

# Expected: Zero errors, zero warnings
```

### Level 2: Unit Tests (Component Validation)

```bash
# Run all tests
cargo test

# Run tests with output
cargo test -- --nocapture

# Run specific test
cargo test test_greet

# Expected: All tests pass (2 tests: 1 unit, 1 integration)
```

### Level 3: Integration Testing (System Validation)

```bash
# Build debug version
cargo build
# Verify: target/debug/hello_world exists

# Run the application
cargo run
# Expected output: "Hello, world!" 

# Build release version
cargo build --release
# Verify: target/release/hello_world exists

# Run release version directly
./target/release/hello_world
# Expected output: "Hello, world!"

# Generate documentation
cargo doc --open
# Expected: Documentation opens in browser
```

### Level 4: Creative & Domain-Specific Validation

```bash
# Verify project structure
tree -I target
# Expected: Matches desired structure

# Check for proper metadata
grep -E "authors|description|license" Cargo.toml
# Expected: All fields present

# Verify no unnecessary files
find . -type f -name "*.rs~" -o -name "*.swp"
# Expected: No temporary files

# Test with different Rust channels (if rustup available)
cargo +stable test
cargo +nightly test 2>/dev/null || echo "Nightly not installed"

# Size validation
du -sh target/release/hello_world
# Expected: Reasonable size for hello world (few MB)

# Performance check
time ./target/release/hello_world
# Expected: Near-instant execution
```

## Final Validation Checklist

### Technical Validation

- [ ] All 4 validation levels completed successfully
- [ ] All tests pass: `cargo test`
- [ ] No clippy warnings: `cargo clippy`
- [ ] Code properly formatted: `cargo fmt -- --check`
- [ ] Project builds without errors: `cargo build`
- [ ] Release build successful: `cargo build --release`

### Feature Validation

- [ ] Application prints "Hello, world!" when run
- [ ] greet function returns correct formatted string
- [ ] Unit test validates greet function
- [ ] Integration test runs successfully
- [ ] Project structure follows Rust conventions

### Code Quality Validation

- [ ] Follows Rust naming conventions (snake_case, CamelCase)
- [ ] Proper use of println! macro
- [ ] Test module properly configured with #[cfg(test)]
- [ ] Cargo.toml has all recommended metadata fields
- [ ] No compiler warnings with default settings

### Documentation & Deployment

- [ ] Code has basic documentation comments
- [ ] cargo doc generates documentation
- [ ] README could be added for project description
- [ ] Project can serve as template for future Rust projects

---

## Anti-Patterns to Avoid

- ❌ Don't forget the ! in println! - it's a macro, not a function
- ❌ Don't use print() or printf() - use println! macro
- ❌ Don't skip cargo new - use it to ensure proper structure
- ❌ Don't place tests in src/ without #[cfg(test)]
- ❌ Don't use camelCase for functions - use snake_case
- ❌ Don't omit semicolons at statement ends
- ❌ Don't ignore clippy warnings - fix them
- ❌ Don't commit target/ directory to version control