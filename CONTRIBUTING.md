# Contributing to Mush

First off, thank you for considering contributing to Mush! It's people like you that make Mush such a great tool for modern data engineering.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Development Setup](#development-setup)
- [Development Process](#development-process)
- [Pull Request Process](#pull-request-process)
- [Project Structure](#project-structure)
- [Style Guidelines](#style-guidelines)
- [Testing](#testing)
- [Documentation](#documentation)

## 🤝 Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct. By participating, you are expected to uphold this code. Please report unacceptable behavior to [sporolyum@gmail.com].

## 🛠️ Development Setup

1. **Fork and Clone**
   ```bash
   git clone https://github.com/yourusername/mush.git
   cd mush
   ```

2. **Environment Setup**
   ```bash
   make setup     # Creates .env file from template
   make check     # Verifies all dependencies
   ```

3. **Launch Development Environment**
   ```bash
   make launch-dev
   ```

## 🔄 Development Process

1. **Create a Branch**
   ```bash
   git checkout -b feat/your-feature-name
   # or
   git checkout -b fix/your-fix-name
   ```

2. **Make Your Changes**
   - Write clean, maintainable code
   - Follow the style guidelines
   - Add tests for new features
   - Update documentation as needed

3. **Verify Your Changes**
   ```bash
   make test           # Run all tests
   make lint           # Check code style
   make format         # Format code
   ```

## 🔍 Pull Request Process

1. **Before Submitting**
   - [ ] Update documentation
   - [ ] Add/update tests
   - [ ] Run full test suite
   - [ ] Format code
   - [ ] Update changelog if needed

2. **Submitting**
   - Fill in the pull request template
   - Link any relevant issues
   - Request review from maintainers

3. **After Submitting**
   - Respond to review comments
   - Make requested changes
   - Rebase if needed

## 📁 Project Structure