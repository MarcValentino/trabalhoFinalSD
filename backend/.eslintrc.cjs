/* eslint-env node */
module.exports = {
  extends: ['eslint:recommended', 'plugin:@typescript-eslint/recommended'],
  parser: '@typescript-eslint/parser',
  plugins: ['@typescript-eslint'],
  root: true,
  rules: {
    'indent': ['error', 2],
    'no-multi-spaces': ['error'],
    'semi': ['error', 'always']
  }
};