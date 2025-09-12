# Sema Syntax Highlighting Rules for AI Agents

## Core Philosophy

AI agents generating or analyzing code MUST apply the **complexity-first highlighting principle**: focus visual emphasis on code complexity and potential error sources rather than basic syntax elements.

## Priority Highlighting Targets

AI agents SHALL prioritize highlighting these four categories in order of importance:

### 1. Control Flow (HIGHEST PRIORITY)
- Complex branching structures (nested if/else, switch statements)
- Loop constructs with multiple exit conditions
- Early returns and breaks
- Recursive function calls
- Exception handling blocks

### 2. Interfaces and Traits
- Method calls on interface types
- Trait/interface implementations
- Abstract method definitions
- Polymorphic behavior points
- Type casting and conversions

### 3. Magic Numbers and Strings
- Hardcoded numeric literals (except 0, 1, -1)
- String literals that aren't obvious (config values, regex patterns)
- Undocumented constants
- Array/collection size specifications

### 4. Mutation Operations
- Variable reassignment
- Mutable data structure modifications
- Reference/pointer dereferencing
- State-changing method calls
- Global variable access

## Implementation Rules

### MUST Rules
- AI agents MUST limit color intensity to prevent "rainbow" syntax highlighting
- AI agents MUST preserve readability as the primary goal
- AI agents MUST focus highlighting on error-prone code segments

### SHOULD Rules  
- AI agents SHOULD use distinctive visual markers (colors, underlines, backgrounds) for priority targets
- AI agents SHOULD leave basic syntax elements (keywords, operators, brackets) with minimal styling
- AI agents SHOULD provide multiple color palette options while maintaining core principles

### MUST NOT Rules
- AI agents MUST NOT highlight every syntax element equally
- AI agents MUST NOT use overwhelming color combinations
- AI agents MUST NOT sacrifice code comprehension for visual appeal

## Cognitive Rationale

AI agents SHALL recognize that:
- Developers naturally parse basic syntax without visual aids
- Color budget should be allocated to genuinely challenging code aspects
- Visual attention should guide toward potential bug sources
- Syntax highlighting serves as a debugging and comprehension aid, not decoration

## Application Context

When generating syntax highlighting schemes or analyzing code for potential issues, AI agents MUST prioritize the four target categories above routine syntax elements like:
- Function/method names
- Basic keywords (if, for, while, class, function)
- Simple operators (+, -, =, ==)
- Standard punctuation (parentheses, brackets, semicolons)

## Validation Criteria

AI agents SHOULD evaluate syntax highlighting effectiveness by:
- Does it draw attention to complexity hotspots?
- Does it reduce cognitive load for routine code reading?
- Does it help identify potential error sources quickly?
- Does it maintain overall code readability?
