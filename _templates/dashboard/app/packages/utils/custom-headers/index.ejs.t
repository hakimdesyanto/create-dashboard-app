---
to: src/packages/utils/custom-headers/index.ts
---

import Hex from 'crypto-js/enc-hex'
import hmacSHA256 from 'crypto-js/hmac-sha256'
import dayjs from 'dayjs'
import { v4 as uuidv4 } from 'uuid'

const dateUnix = dayjs().unix()

interface MetadataProps {
  clientName: string
  secret: string
  platform?: string
}

export const customHeaders = (metadata: MetadataProps) => {
  const signature = Hex.stringify(
    hmacSHA256(`${metadata.clientName}${dateUnix}`, metadata.secret as string),
  )
  return {
    'Content-Type': 'application/json',
    'X-Ktbs-Api-Version': '1.0.0',
    'X-Ktbs-Client-Version': '1.0.0',
    'X-Ktbs-Platform-Name': metadata.platform ? metadata.platform : 'pwa',
    'X-Ktbs-Client-Name': metadata.clientName,
    'X-Ktbs-Request-ID': uuidv4(),
    'X-Ktbs-Signature': signature,
    'X-Ktbs-Time': dateUnix,
  }
}
