---
to: src/packages/utils/get-file-type-from-url/index.ts
---

/**
 * Extracts the file extension from a given URL.
 *
 * This function takes a URL as input and attempts to extract the file extension
 * from it. The file extension is identified as the substring that follows the last
 * dot (.) in the URL, but before any query parameters.
 *
 * @param {string} url - The URL from which to extract the file extension.
 * @returns {string | null} The file extension if found, otherwise `null`.
 *
 * @example
 * const fileType = getFileTypeFromUrl('http://example.com/file.png?query=123');
 * console.log(fileType); // Output: 'png'
 *
 * @example
 * const fileType = getFileTypeFromUrl('http://example.com/file');
 * console.log(fileType); // Output: null
 */

export const getFileTypeFromUrl = (url: string): string | null => {
  const matches = url.match(/\.([a-zA-Z0-9]+)(?=\?|$)/)
  return matches ? matches[1] : null
}

/**
 * Checks and returns the file extension from a given URL.
 *
 * This function utilizes `getFileTypeFromUrl` to extract the file extension
 * from the provided URL. If no file extension is found, it returns `null`.
 *
 * @param {string} url - The URL to check for the file extension.
 * @returns {string | null} The file extension if found, otherwise `null`.
 *
 * @example
 * const fileType = checkFileType('http://example.com/file.png?query=123');
 * console.log(fileType); // Output: 'png'
 *
 * @example
 * const fileType = checkFileType('http://example.com/file');
 * console.log(fileType); // Output: null
 */
export const checkFileType = (url: string): string | null => {
  const type = getFileTypeFromUrl(url)
  return type
}
