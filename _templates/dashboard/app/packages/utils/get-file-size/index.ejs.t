---
to: src/packages/utils/get-file-size/index.ts
---

export const getFileSize = async (url: string): Promise<any> => {
  try {
    // Fetch the file
    const response = await fetch(url)

    // Check if the request was successful
    if (!response.ok) {
      throw new Error(`Error fetching file: ${response.statusText}`)
    }

    // Convert the response to a Blob
    const fileBlob = await response.blob()

    // Get the size of the Blob (in bytes)
    const sizeInByte = fileBlob.size

    // convert size from byte to KB
    const sizeInKB = Math.round(sizeInByte / 1024)

    return sizeInKB
  } catch (error) {
    console.error('Error:', error)
    return null
  }
}
