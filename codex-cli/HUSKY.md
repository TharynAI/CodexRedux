# Husky Git Hooks

This project uses [Husky](https://typicode.github.io/husky/) to enforce code quality checks before commits and pushes.

## What's Included


- **Pre-push Hook**: Runs tests and type checking before pushing to the remote repository.
  - Executes `npm test` to run all tests
  - Executes `npm run typecheck` to check TypeScript types

## Benefits

- Ensures consistent code style across the project
- Prevents pushing code with failing tests or type errors
- Reduces the need for style-related code review comments
- Improves overall code quality

## For Contributors

You don't need to do anything special to use these hooks. They will automatically run when you commit or push code.

If you need to bypass the hooks in exceptional cases:

```bash
# Skip pre-push hooks
git push --no-verify
```

Note: Please use these bypass options sparingly and only when absolutely necessary.

## Troubleshooting

If you encounter any issues with the hooks:

1. Make sure you have the latest dependencies installed: `npm install`
2. Ensure the hook script is executable (Unix systems): `chmod +x .husky/pre-push`
3. Check if there are any ESLint or Prettier configuration issues in your code
