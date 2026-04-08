---
title: TypeScript Generics
date: 2026-04-08
tags: [typescript, generics, learning]
category: learning
---

# TypeScript Generics

## 30-Second Summary
TypeScript generics let you write **code that works with any type** while still preserving type safety — you define the shape once, and TypeScript infers the specific type when you use it. The core mental model: generics are to types what functions are to values. Just as a function abstracts over inputs, a generic abstracts over types. The payoff: reusable components that are as type-safe as handwritten non-generic code.

---

## Essential Concepts (7)

### 1. Generic Functions
- **What it does**: Write one function that works with multiple types, TypeScript infers at call site
- **Key insight**: `<T>` is a **type parameter** — a variable for types, not values
- **First step**: `function identity<T>(x: T): T { return x }` → `identity(42)` gives `number`, `identity("hi")` gives `string`

### 2. Generic Interfaces & Types
- **What it does**: Define reusable type shapes that work with any type parameter
- **Key insight**: `interface Box<T> { value: T }` — the `T` is a placeholder filled in when you use it
- **First step**: `type Pair<A, B> = [A, B]` → `Pair<string, number>` is a tuple `[string, number]`

### 3. Constraints (`extends`)
- **What it does**: Limit what types can be passed to a generic — require certain properties exist
- **Key insight**: `extends` doesn't mean inheritance — it means "must be assignable to"
- **First step**: `function getLength<T extends { length: number }>(x: T): number` → works on strings, arrays; fails on numbers

### 4. `keyof` + Indexed Access Types
- **What it does**: Extract keys from a type, then access those key types dynamically
- **Key insight**: `keyof T` = union of all property names of T; `T[K]` = type of property K in T
- **First step**: `function getProperty<T, K extends keyof T>(obj: T, key: K): T[K]` — return type varies based on which key

### 5. Conditional Types (`T extends U ? X : Y`)
- **What it does**: Type-level if/else — choose a type based on whether another type matches a constraint
- **Key insight**: Evaluated at **type-check time**, not runtime — pure type machinery
- **First step**: `type IsArray<T> = T extends any[] ? true : false` → `IsArray<string[]>` = `true`, `IsArray<string>` = `false`

### 6. Utility Types (Mapped + Template Literals)
- **What it does**: Built-in generics that transform existing types (Partial, Required, Pick, Omit, Record)
- **Key insight**: `Partial<T>` = `{ [K in keyof T]?: T[K] }` — every property becomes optional
- **First step**: `Partial<User>`, `Pick<User, "id" | "name">`, `Omit<User, "password">`

### 7. `infer` Keyword
- **What it does**: Extract a type from within a conditional type — "infer this part for me"
- **Key insight**: Only valid inside the `extends` clause of a conditional type
- **First step**: `type ReturnType<T> = T extends (...args: any[]) => infer R ? R : never` → extracts function's return type

---

## Knowledge Graph

| 关系 | 说明 |
|------|------|
| **Related to** | TypeScript basic types, interfaces, union types, type guards |
| **Bridge** | Generics sit on top of all of these — add `<T>` anywhere you'd write a type, and you unlock generic behavior |
| **Contrast with** | `any` — `any` abandons type safety entirely; generics keep it. Overloads are runtime branching, generics are compile-time abstraction |

---

## Flashcards

```
Q1: What's the difference between <T> and <T extends Constraint>?
A1: <T> accepts ANY type; <T extends Constraint> only accepts types that have the required properties | cue: extends = "T must be at least X" — limits input types

Q2: What does keyof T return?
A2: A union of string/number literal types — all property names of T | cue: "keyof" = "what keys exist on" — like Object.keys() but at type level

Q3: Why use Pick<T, K> instead of just writing the picked type manually?
A3: Pick stays in sync with T — if T adds a property, Pick<T, "id"> still works. Manual writing drifts and becomes stale | cue: Pick is "live" not "baked"

Q4: When does infer fire?
A4: Only inside the extends clause of a conditional type, only when the condition is true | cue: infer = "I see this pattern, extract X from it"

Q5: Generic constraint says T extends { length: number }. What passes? What fails?
A5: Pass: string, array, { length: 5 }. Fail: number, boolean, { size: number } | cue: extends = "must have length: number property"
```

---

## Review Schedule

| Review | Timing | Focus |
|--------|--------|-------|
| 1st | After learning (same day) | Write a generic function + constrained generic from scratch |
| 2nd | 24 hours later | Use Pick/Omit/Partial on a real interface |
| 3rd | 3-5 days later | Explain keyof + indexed access to someone |
| 4th | 10-14 days later | Write a conditional type with infer (e.g., unwrap Promise) |
