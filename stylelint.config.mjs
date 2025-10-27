/** @type {import('stylelint').Config} */
export default {
  // Base configs to extend
  extends: [
    "stylelint-config-standard",
    "stylelint-config-standard-scss",
    "stylelint-config-hudochenkov/order",
    "stylelint-config-tailwindcss"
  ],

  // Plugins
  plugins: ["stylelint-order"],

  // Language overrides for SCSS, Less, Vue, HTML, PHP
  overrides: [
    {
      files: ["**/*.scss"],
      customSyntax: "postcss-scss"
    },
    {
      files: ["**/*.less"],
      customSyntax: "postcss-less"
    },
    {
      files: ["**/*.{vue,html,php}"],
      customSyntax: "postcss-html"
    }
  ],

  // Example rules
  // rules: {
  //   // Ordering plugin example
  //   "order/properties-order": [
  //     "display",
  //     "position",
  //     "top",
  //     "right",
  //     "bottom",
  //     "left",
  //     "width",
  //     "height",
  //     "margin",
  //     "padding",
  //     "color",
  //     "background"
  //   ]
  // },

  // Report stylelint-disable comments
  reportDescriptionlessDisables: true,
  reportInvalidScopeDisables: true,
  reportNeedlessDisables: true,

  // Allow empty input (won't error if no files match)
  allowEmptyInput: true,

  // Enable autofix when running with --fix
  fix: true
};
