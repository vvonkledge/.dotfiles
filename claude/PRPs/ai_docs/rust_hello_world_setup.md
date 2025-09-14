# Rust Hello World Setup - Complete Reference

## Quick Start Commands

```bash
# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Create new project
cargo new hello_world
cd hello_world

# Build and run
cargo build
cargo run
```

## Project Structure (MUST FOLLOW)

```
hello_world/
├── Cargo.toml          # Package configuration
├── src/
│   └── main.rs         # Entry point
└── tests/              # Integration tests (optional)
```

## Cargo.toml Template (EXACT FORMAT)

```toml
[package]
name = "hello_world"
version = "0.1.0"
edition = "2021"
authors = ["Your Name <your.email@example.com>"]
description = "A simple hello world application in Rust"
license = "MIT OR Apache-2.0"

[dependencies]
# No dependencies needed for basic hello world
```

## src/main.rs Template (EXACT CODE)

```rust
fn main() {
    println!("Hello, world!");
}
```

## Testing Template

### Unit Test in src/main.rs

```rust
fn greet(name: &str) -> String {
    format!("Hello, {}!", name)
}

fn main() {
    println!("{}", greet("world"));
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_greet() {
        assert_eq!(greet("Rust"), "Hello, Rust!");
    }
}
```

### Integration Test in tests/integration_test.rs

```rust
// This would test the public API if this were a library
#[test]
fn test_hello_world_runs() {
    // Integration tests go here
    assert!(true);
}
```

## Essential Cargo Commands

```bash
# Project Management
cargo new project_name    # Create new project
cargo build               # Compile project
cargo run                 # Build and run
cargo check              # Check for errors without building

# Testing
cargo test               # Run all tests
cargo test test_name     # Run specific test

# Code Quality
cargo fmt                # Format code
cargo clippy            # Lint code
cargo doc --open        # Generate and view documentation

# Release Build
cargo build --release   # Optimized build
cargo run --release     # Run optimized build
```

## Common Patterns and Gotchas

### MUST FOLLOW:
1. **File naming**: Use snake_case for files and directories
2. **Function naming**: Use snake_case for functions
3. **Type naming**: Use CamelCase for types, traits, enums
4. **Constants**: Use SCREAMING_SNAKE_CASE
5. **Semicolons**: Required at end of statements
6. **Main function**: Must be exactly `fn main() { }`

### GOTCHAS TO AVOID:
1. **println! is a macro**: Always include the `!`
2. **Strings**: Use `&str` for string slices, `String` for owned strings
3. **Module system**: `mod` loads files, not includes them
4. **Privacy**: Items are private by default, use `pub` to make public
5. **Edition**: Always specify edition in Cargo.toml (use "2021")

## Project Validation Commands

```bash
# Run these in order to validate the project
cargo build              # Should compile without errors
cargo test               # Should pass all tests
cargo fmt -- --check     # Should be properly formatted
cargo clippy            # Should have no warnings
cargo run               # Should print "Hello, world!"
```

## Environment Variables (if needed)

```bash
export RUST_BACKTRACE=1     # Enable backtraces for debugging
export RUST_LOG=debug        # Enable debug logging
```

## VS Code Setup (Optional but Recommended)

1. Install rust-analyzer extension
2. Add to settings.json:
```json
{
    "rust-analyzer.check.command": "clippy",
    "editor.formatOnSave": true
}
```

## Directory Permissions

Ensure the project directory has proper permissions:
```bash
# Unix/Linux/macOS
chmod 755 hello_world
chmod 644 hello_world/Cargo.toml
chmod 644 hello_world/src/main.rs
```

## Troubleshooting

### "linker 'cc' not found" (Linux/WSL)
```bash
sudo apt update
sudo apt install build-essential
```

### "link.exe not found" (Windows)
Install Visual Studio Build Tools with C++ development workload

### PATH not updated
Add manually to shell config:
```bash
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```