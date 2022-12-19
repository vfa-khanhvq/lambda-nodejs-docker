module.exports = {
    env: {
        browser: true,
        commonjs: true,
        es6: false,
    },
    globals: {
        Atomics: 'readonly',
        SharedArrayBuffer: 'readonly',
    },
    parserOptions: {
        ecmaVersion: 2018,
    },
    plugins: ['prettier'],
    extends: ['plugin:prettier/recommended'],
    rules: {
        semi: ['error', 'always'],
        quotes: ['error', 'single'],
        indent: 'off',
        'no-trailing-spaces': 'error',
        'no-unused-vars': 'error',
        'prefer-const': 'off',
        'require-await': 'off',
        'prettier/prettier': 'error',
        'arrow-body-style': 'off',
        'prefer-arrow-callback': 'off',
    },
};
