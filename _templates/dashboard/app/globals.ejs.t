---
to: src/app/globals.css
force: true
---
@tailwind base;
@tailwind components;
@tailwind utilities;

/* jsoneditor styles */
.jsoneditor {
  @apply border-[thin] border-solid border-primary-500 rounded-lg !important;
}

.jsoneditor-menu {
  @apply bg-primary-500 border-b-primary-500 border-b border-solid rounded-t-md !important;
}

.jsoneditor-statusbar {
  @apply rounded-b-lg !important;
}

.jsoneditor-jmespath-label {
  @apply text-primary-500 !important;
}

.jsoneditor-modal .pico-modal-header {
  @apply bg-primary-500 !important;
}

.jsoneditor-modal .jsoneditor-button-group.jsoneditor-button-group-value-asc input.jsoneditor-button-asc, .jsoneditor-modal .jsoneditor-button-group.jsoneditor-button-group-value-desc input.jsoneditor-button-desc {
  @apply bg-primary-500 border-primary-500 !important;
}

.ace-jsoneditor .ace_scroller {
  @apply dark:bg-gray-800 !important;
}

.ace_variable {
  @apply dark:text-white !important;
}

.ace-jsoneditor .ace_gutter {
  @apply dark:bg-gray-700 dark:text-gray-400 !important;
}

.ace-jsoneditor .ace_marker-layer .ace_active-line {
  @apply dark:bg-gray-700 !important;
}

.ace-jsoneditor .ace_gutter-active-line {
  @apply dark:bg-gray-500 dark:text-gray-300 !important;
}

.jsoneditor-statusbar {
  @apply dark:bg-gray-700 dark:text-gray-500 dark:border-t-gray-500 !important;
}

/* quill styles */
.quill {
  @apply block w-full rounded-lg border disabled:cursor-not-allowed disabled:opacity-50 bg-gray-50 border-gray-300 text-gray-900 dark:border-gray-600 dark:bg-gray-700 dark:text-white dark:placeholder-gray-400 text-base focus:border-primary-500 focus:ring-primary-500 dark:focus:border-primary-500 dark:focus:ring-primary-500 sm:text-sm;
}

.ql-toolbar.ql-snow {
  @apply border-0 border-b dark:border-gray-500 !important;
}

.ql-container.ql-snow {
  @apply border-0 h-fit !important;
}

.ql-snow .ql-picker .ql-picker-options {
  @apply dark:text-white !important;
}

.ql-snow .ql-picker.ql-expanded .ql-picker-options {
  @apply dark:bg-gray-700 dark:border-gray-600 !important;
}

.ql-toolbar.ql-snow .ql-picker.ql-expanded .ql-picker-label {
  @apply dark:border-gray-600 !important;
}

.ql-snow.ql-toolbar button:not(.ql-active),
.ql-snow .ql-picker:not(.ql-expanded):not(:has(span.ql-active)):not(.ql-color-picker):not(.ql-icon-picker) {
  @apply dark:invert dark:hover:invert-0;
}

.ql-snow.ql-toolbar button:hover .ql-stroke, .ql-snow .ql-toolbar button:hover .ql-stroke, .ql-snow.ql-toolbar button.ql-active .ql-stroke, .ql-snow .ql-toolbar button.ql-active .ql-stroke, .ql-snow.ql-toolbar .ql-picker-label:hover .ql-stroke, .ql-snow .ql-toolbar .ql-picker-label:hover .ql-stroke, .ql-snow.ql-toolbar .ql-picker-label.ql-active .ql-stroke, .ql-snow .ql-toolbar .ql-picker-label.ql-active .ql-stroke, .ql-snow.ql-toolbar .ql-picker-item:hover .ql-stroke, .ql-snow .ql-toolbar .ql-picker-item:hover .ql-stroke, .ql-snow.ql-toolbar .ql-picker-item.ql-selected .ql-stroke, .ql-snow .ql-toolbar .ql-picker-item.ql-selected .ql-stroke, .ql-snow.ql-toolbar button:hover .ql-stroke-miter, .ql-snow .ql-toolbar button:hover .ql-stroke-miter, .ql-snow.ql-toolbar button.ql-active .ql-stroke-miter, .ql-snow .ql-toolbar button.ql-active .ql-stroke-miter, .ql-snow.ql-toolbar .ql-picker-label:hover .ql-stroke-miter, .ql-snow .ql-toolbar .ql-picker-label:hover .ql-stroke-miter, .ql-snow.ql-toolbar .ql-picker-label.ql-active .ql-stroke-miter, .ql-snow .ql-toolbar .ql-picker-label.ql-active .ql-stroke-miter, .ql-snow.ql-toolbar .ql-picker-item:hover .ql-stroke-miter, .ql-snow .ql-toolbar .ql-picker-item:hover .ql-stroke-miter, .ql-snow.ql-toolbar .ql-picker-item.ql-selected .ql-stroke-miter, .ql-snow .ql-toolbar .ql-picker-item.ql-selected .ql-stroke-miter {
  @apply stroke-primary-500 !important;
}

.ql-snow.ql-toolbar button:hover .ql-fill, .ql-snow .ql-toolbar button:hover .ql-fill, .ql-snow.ql-toolbar button:focus .ql-fill, .ql-snow .ql-toolbar button:focus .ql-fill, .ql-snow.ql-toolbar button.ql-active .ql-fill, .ql-snow .ql-toolbar button.ql-active .ql-fill, .ql-snow.ql-toolbar .ql-picker-label:hover .ql-fill, .ql-snow .ql-toolbar .ql-picker-label:hover .ql-fill, .ql-snow.ql-toolbar .ql-picker-label.ql-active .ql-fill, .ql-snow .ql-toolbar .ql-picker-label.ql-active .ql-fill, .ql-snow.ql-toolbar .ql-picker-item:hover .ql-fill, .ql-snow .ql-toolbar .ql-picker-item:hover .ql-fill, .ql-snow.ql-toolbar .ql-picker-item.ql-selected .ql-fill, .ql-snow .ql-toolbar .ql-picker-item.ql-selected .ql-fill, .ql-snow.ql-toolbar button:hover .ql-stroke.ql-fill, .ql-snow .ql-toolbar button:hover .ql-stroke.ql-fill, .ql-snow.ql-toolbar button:focus .ql-stroke.ql-fill, .ql-snow .ql-toolbar button:focus .ql-stroke.ql-fill, .ql-snow.ql-toolbar button.ql-active .ql-stroke.ql-fill, .ql-snow .ql-toolbar button.ql-active .ql-stroke.ql-fill, .ql-snow.ql-toolbar .ql-picker-label:hover .ql-stroke.ql-fill, .ql-snow .ql-toolbar .ql-picker-label:hover .ql-stroke.ql-fill, .ql-snow.ql-toolbar .ql-picker-label.ql-active .ql-stroke.ql-fill, .ql-snow .ql-toolbar .ql-picker-label.ql-active .ql-stroke.ql-fill, .ql-snow.ql-toolbar .ql-picker-item:hover .ql-stroke.ql-fill, .ql-snow .ql-toolbar .ql-picker-item:hover .ql-stroke.ql-fill, .ql-snow.ql-toolbar .ql-picker-item.ql-selected .ql-stroke.ql-fill, .ql-snow .ql-toolbar .ql-picker-item.ql-selected .ql-stroke.ql-fill {
  @apply fill-primary-500 !important;
}

.ql-snow.ql-toolbar button:hover, .ql-snow .ql-toolbar button:hover, .ql-snow.ql-toolbar button:focus, .ql-snow .ql-toolbar button:focus, .ql-snow.ql-toolbar button.ql-active, .ql-snow .ql-toolbar button.ql-active, .ql-snow.ql-toolbar .ql-picker-label:hover, .ql-snow .ql-toolbar .ql-picker-label:hover, .ql-snow.ql-toolbar .ql-picker-label.ql-active, .ql-snow .ql-toolbar .ql-picker-label.ql-active, .ql-snow.ql-toolbar .ql-picker-item:hover, .ql-snow .ql-toolbar .ql-picker-item:hover, .ql-snow.ql-toolbar .ql-picker-item.ql-selected, .ql-snow .ql-toolbar .ql-picker-item.ql-selected {
  @apply text-primary-500 !important;
}

/* input */
input {
  @apply bg-gray-50 border-gray-300 text-gray-900 focus:border-primary-500 focus:ring-primary-500 focus:outline-primary-500 dark:border-gray-600 dark:bg-gray-700 dark:text-white dark:placeholder-gray-400 dark:focus:border-primary-500 dark:focus:ring-primary-500 dark:focus:outline-primary-500;
}

input[type=number], input[type=tel], input[type=email], input[type=password] {
  @apply focus:outline-none dark:focus:outline-none !important;
}

/* chart styles */
.apexcharts-tooltip {
  @apply rounded-lg border-0 bg-white text-gray-500 shadow-lg dark:bg-gray-700 dark:text-gray-400 !important;
}

.apexcharts-tooltip .apexcharts-tooltip-title {
  @apply border-b border-gray-200 bg-gray-100 px-4 py-2 dark:border-gray-500 dark:bg-gray-600 !important;
}

.apexcharts-xaxistooltip {
  @apply rounded-lg border-0 bg-white text-gray-500 shadow-lg dark:bg-gray-700 dark:text-gray-300 !important;
}

.apexcharts-tooltip .apexcharts-tooltip-text-y-value {
  @apply dark:text-white;
}

.apexcharts-xaxistooltip-text {
  @apply text-sm font-medium !important;
}

.apexcharts-xaxistooltip:before,
.apexcharts-xaxistooltip:after {
  @apply border-0 !important;
}

/* SVG map styles */
.svgMap-map-wrapper {
  @apply bg-white !important;
}

.svgMap-map-image {
  @apply dark:bg-gray-800;
}

.svgMap-map-controls-wrapper {
  @apply bottom-0 left-0 shadow-none dark:bg-gray-800 !important;
}

.svgMap-map-controls-zoom {
  @apply dark:bg-gray-800 !important;
}

.svgMap-map-wrapper .svgMap-control-button {
  @apply rounded-lg border border-solid border-gray-300 hover:bg-gray-100 dark:border-gray-600 dark:hover:bg-gray-600 !important;
}

.svgMap-map-wrapper .svgMap-control-button.svgMap-zoom-button:after,
.svgMap-map-wrapper .svgMap-control-button.svgMap-zoom-button:before {
  @apply dark:bg-gray-600 dark:hover:bg-gray-500;
}

.svgMap-map-wrapper .svgMap-control-button:first-child {
  @apply mr-2 !important;
}

.svgMap-tooltip {
  @apply rounded-lg border-0 bg-white text-left shadow-lg dark:bg-gray-700 !important;
}

.svgMap-tooltip
  .svgMap-tooltip-content-container
  .svgMap-tooltip-flag-container {
  @apply mr-2 inline-block border-0 p-0 text-left !important;
}

.svgMap-tooltip
  .svgMap-tooltip-content-container
  .svgMap-tooltip-flag-container
  .svgMap-tooltip-flag {
  @apply inline-block h-4 border-0 p-0 !important;
}

.svgMap-tooltip .svgMap-tooltip-title {
  @apply inline-block pt-2 text-sm font-semibold text-gray-900 dark:text-white !important;
}

.svgMap-tooltip .svgMap-tooltip-content {
  @apply mt-0 !important;
}

.svgMap-tooltip .svgMap-tooltip-content table td {
  @apply text-left text-sm font-normal text-gray-500 dark:text-gray-400 !important;
}

.svgMap-tooltip .svgMap-tooltip-content table td span {
  @apply text-left text-sm font-semibold text-gray-900 dark:text-white !important;
}

.svgMap-tooltip .svgMap-tooltip-pointer {
  @apply hidden !important;
}

.svgMap-map-wrapper .svgMap-country {
  @apply dark:stroke-gray-800;
}

.svgMap-map-wrapper .svgMap-country {
  @apply dark:stroke-gray-800 !important;
}

.svgMap-country[fill="#4B5563"] {
  @apply fill-[#4B5563] !important;
}

/* kanban styles */

.drag-card {
  @apply opacity-100 !important;
  @apply rotate-6;
}

.ghost-card {
  @apply bg-gray-100/40 dark:bg-gray-600/40 !important;
}
