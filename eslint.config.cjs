// eslint.config.cjs
const { createRequire } = require("node:module");
const { execSync } = require("node:child_process");

// get global node_modules path
const npmGlobalPath = execSync("npm root -g", { encoding: "utf-8" }).trim();

// create a require function relative to global node_modules
const requireGlobal = createRequire(npmGlobalPath + "/");

// require your globally installed packages
const { defineConfig, globalIgnores } = requireGlobal("eslint/config");
const globals = requireGlobal("globals");
const js = requireGlobal("@eslint/js");
const ts = requireGlobal("typescript-eslint");
const tsParser = requireGlobal("@typescript-eslint/parser");
const vuePlugin = requireGlobal("eslint-plugin-vue");
const vueParser = requireGlobal("vue-eslint-parser");
const htmlPlugin = requireGlobal("eslint-plugin-html");
const phpPlugin = requireGlobal("eslint-plugin-php-markup");

module.exports = defineConfig([
  // Global ignores
  globalIgnores([
    "dist/",
    "build/",
    "coverage/",
    "*.min.js",
  ]),

  // Globals
  {
    name: "Global/Globals",
    languageOptions: {
      globals:{
        ...globals.browser,
        ...globals.jest,
      },
    },
    linterOptions: {
      reportUnusedDisableDirectives: "warn",
      reportUnusedInlineConfigs: "warn",
    },
  },

  // Recommended rules for JS
  js.configs.recommended,

  // Strict rules for TS
  ...ts.configs.strict,

  // Recommended rules for Vue
  ...vuePlugin.configs["flat/recommended"],

  // JavaScript files
  {
    name: "Global/JavaScript",
    files: ["**/*.js", "**/*.jsx", "**/*.cjs", "**/*.mjs"],
    rules: {
      "no-unused-vars": "warn",
    },
  },

  // TypeScript files
  {
    name: "Global/TypeScript",
    files: ["**/*.ts", "**/*.tsx", "**/*.cts", "**/*.mts"],
    languageOptions: {
      parser: tsParser,
    },
  },

  // Vue files
  {
    name: "Global/Vue",
    files: ["**/*.vue"],
    languageOptions: {
      parser: vueParser,
      parserOptions: {
        parser: {
          js: "espree",
          ts: tsParser,
          "<template>": "espree",
        },
      },
    },
  },

  // HTML and PHP files with <script> blocks
  {
    name: "Global/HTML",
    files: ["**/*.html", "**/*.php"],
    plugins: { htmlPlugin, phpPlugin },
  },
]);
