---
to: src/app/(dashboard)/(home)/page.tsx
---
import Image from 'next/image'

export default async function HomePage() {
  return (
    <div className="mx-auto flex flex-col items-center justify-center px-6 xl:px-0 dark:bg-gray-900">
      <div className="block md:max-w-lg">
        <Image
          alt="page not found"
          src="/images/illustrations/greeting.svg"
          className="w-auto h-auto"
          height={400}
          width={400}
          priority
        />
      </div>
      <div className="text-center xl:max-w-4xl">
        <h1 className="mb-3 text-2xl font-bold leading-tight text-gray-900 sm:text-4xl lg:text-5xl dark:text-white">
          Hello #OrangBaik
        </h1>
        <p className="mb-5 text-base font-normal text-gray-500 md:text-lg dark:text-gray-400">
          Welcome to our kindness support platform
          <br/>
          <span className='text-xs'>Have a nice day :)</span>
        </p>
      </div>
    </div>
  )
}
