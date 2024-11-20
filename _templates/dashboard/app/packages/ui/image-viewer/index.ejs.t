---
to: src/packages/ui/image-viewer/index.tsx
---

import React, { useEffect, useRef, useState } from 'react'

interface Props {
  imageSource: string
  onClose: () => void
}

const CanvasComponent: React.FC<Props> = ({ imageSource, onClose }) => {
  const canvasRef = useRef<HTMLCanvasElement | null>(null)
  const [zoom, setZoom] = useState<number>(1)
  const [rotationAngle, setRotationAngle] = useState<number>(0)
  const [isDragging, setIsDragging] = useState<boolean>(false)
  const [imageX, setImageX] = useState<number>(0)
  const [imageY, setImageY] = useState<number>(0)

  useEffect(() => {
    const canvas = canvasRef.current
    const canvasWidth = 1000
    const canvasHeight = 1000

    if (canvas) {
      canvas.width = canvasWidth
      canvas.height = canvasHeight

      const context = canvas.getContext('2d')

      if (context) {
        const preview = new Image()
        preview.onload = function () {
          context.save()
          context.translate(canvasWidth / 2, canvasHeight / 2)
          context.rotate((rotationAngle * Math.PI) / 180)
          context.translate(imageX, imageY)
          context.drawImage(
            preview,
            (-preview.width * zoom) / 2,
            (-preview.height * zoom) / 2,
            preview.width * zoom,
            preview.height * zoom,
          )
          context.restore()
        }
        preview.src = imageSource
        context.fillStyle = 'rgba(128, 128, 128, 0)'
        context.fillRect(0, 0, canvasWidth, canvasHeight)
      } else {
        console.error('Failed to get 2D rendering context')
      }
    }
  }, [imageSource, zoom, rotationAngle, imageX, imageY])

  const rotateLeft = () => {
    setRotationAngle(rotationAngle - 90)
  }

  const rotateRight = () => {
    setRotationAngle(rotationAngle + 90)
  }

  const zoomIn = () => {
    setZoom(zoom + 0.2)
  }

  const zoomOut = () => {
    setZoom(zoom - 0.2)
  }

  const handleMouseDown = (
    e: React.MouseEvent<HTMLCanvasElement, MouseEvent>,
  ) => {
    const canvas = canvasRef.current
    if (canvas) {
      const rect = canvas.getBoundingClientRect()
      const scaleX = canvas.width / rect.width
      const scaleY = canvas.height / rect.height
      setIsDragging(true)
      setImageX((e.clientX - rect.left) * scaleX - canvas.width / 2)
      setImageY((e.clientY - rect.top) * scaleY - canvas.height / 2)
    }
  }

  const handleMouseMove = (
    e: React.MouseEvent<HTMLCanvasElement, MouseEvent>,
  ) => {
    const canvas = canvasRef.current
    if (canvas && isDragging) {
      const rect = canvas.getBoundingClientRect()
      const scaleX = canvas.width / rect.width
      const scaleY = canvas.height / rect.height
      setImageX((e.clientX - rect.left) * scaleX - canvas.width / 2)
      setImageY((e.clientY - rect.top) * scaleY - canvas.height / 2)
    }
  }

  const handleMouseUp = () => {
    setIsDragging(false)
  }

  const resetTransformation = () => {
    setZoom(1)
    setRotationAngle(0)
    setImageX(0)
    setImageY(0)
  }

  return (
    <div className="relative">
      <div className="fixed top-0 z-50 h-screen w-full bg-black/50">
        <canvas
          ref={canvasRef}
          className="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 cursor-pointer"
          onMouseDown={handleMouseDown}
          onMouseMove={handleMouseMove}
          onMouseUp={handleMouseUp}
        ></canvas>
        <div className="absolute bottom-5 left-1/2 mx-auto inline-flex w-full -translate-x-1/2 items-center justify-center gap-5">
          <button onClick={zoomIn}>
            <svg
              width="56"
              height="56"
              viewBox="0 0 56 56"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <rect width="56" height="56" rx="28" fill="white" />
              <path
                d="M25.6059 16C23.706 16 21.8488 16.5634 20.2692 17.6189C18.6895 18.6744 17.4583 20.1746 16.7312 21.9299C16.0042 23.6851 15.8139 25.6166 16.1846 27.4799C16.5552 29.3433 17.4701 31.0549 18.8135 32.3983C20.1569 33.7417 21.8685 34.6566 23.7319 35.0272C25.5952 35.3979 27.5267 35.2076 29.2819 34.4806C31.0372 33.7536 32.5374 32.5223 33.5929 30.9427C34.6484 29.363 35.2118 27.5058 35.2118 25.6059C35.2089 23.0591 34.196 20.6175 32.3951 18.8167C30.5943 17.0158 28.1527 16.0029 25.6059 16ZM25.6059 32.8103C24.181 32.8103 22.7881 32.3878 21.6033 31.5962C20.4186 30.8045 19.4952 29.6794 18.9499 28.3629C18.4046 27.0465 18.2619 25.5979 18.5399 24.2004C18.8179 22.8029 19.504 21.5192 20.5116 20.5116C21.5192 19.504 22.8029 18.8179 24.2004 18.5399C25.5979 18.2619 27.0465 18.4046 28.3629 18.9499C29.6794 19.4952 30.8045 20.4186 31.5962 21.6033C32.3878 22.7881 32.8103 24.181 32.8103 25.6059C32.8084 27.516 32.0488 29.3474 30.6981 30.6981C29.3474 32.0488 27.5161 32.8084 25.6059 32.8103Z"
                fill="#111928"
              />
              <path
                d="M39.6629 37.9651L34.86 33.1621C34.6335 32.9434 34.3302 32.8224 34.0154 32.8251C33.7006 32.8279 33.3994 32.9541 33.1768 33.1768C32.9541 33.3994 32.8279 33.7006 32.8251 34.0154C32.8224 34.3302 32.9434 34.6335 33.1621 34.86L37.9651 39.6629C38.1916 39.8817 38.4949 40.0027 38.8097 40C39.1245 39.9972 39.4257 39.8709 39.6483 39.6483C39.8709 39.4257 39.9972 39.1245 40 38.8097C40.0027 38.4949 39.8817 38.1916 39.6629 37.9651Z"
                fill="#111928"
              />
              <path
                d="M29.2081 24.4052H26.8066V22.0037C26.8066 21.6852 26.6801 21.3798 26.455 21.1546C26.2298 20.9295 25.9244 20.803 25.6059 20.803C25.2874 20.803 24.982 20.9295 24.7569 21.1546C24.5317 21.3798 24.4052 21.6852 24.4052 22.0037V24.4052H22.0037C21.6852 24.4052 21.3798 24.5317 21.1546 24.7569C20.9295 24.982 20.803 25.2874 20.803 25.6059C20.803 25.9244 20.9295 26.2298 21.1546 26.455C21.3798 26.6801 21.6852 26.8066 22.0037 26.8066H24.4052V29.2081C24.4052 29.5266 24.5317 29.832 24.7569 30.0572C24.982 30.2823 25.2874 30.4089 25.6059 30.4089C25.9244 30.4089 26.2298 30.2823 26.455 30.0572C26.6801 29.832 26.8066 29.5266 26.8066 29.2081V26.8066H29.2081C29.5266 26.8066 29.832 26.6801 30.0572 26.455C30.2823 26.2298 30.4089 25.9244 30.4089 25.6059C30.4089 25.2874 30.2823 24.982 30.0572 24.7569C29.832 24.5317 29.5266 24.4052 29.2081 24.4052Z"
                fill="#111928"
              />
            </svg>
          </button>
          <button onClick={zoomOut}>
            <svg
              width="56"
              height="56"
              viewBox="0 0 56 56"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <rect width="56" height="56" rx="28" fill="white" />
              <path
                d="M25.6059 16C23.706 16 21.8488 16.5634 20.2692 17.6189C18.6895 18.6744 17.4583 20.1746 16.7312 21.9299C16.0042 23.6851 15.8139 25.6166 16.1846 27.4799C16.5552 29.3433 17.4701 31.0549 18.8135 32.3983C20.1569 33.7417 21.8685 34.6566 23.7319 35.0272C25.5952 35.3979 27.5267 35.2076 29.2819 34.4806C31.0372 33.7536 32.5374 32.5223 33.5929 30.9427C34.6484 29.363 35.2118 27.5058 35.2118 25.6059C35.2089 23.0591 34.196 20.6175 32.3951 18.8167C30.5943 17.0158 28.1527 16.0029 25.6059 16ZM25.6059 32.8103C24.181 32.8103 22.7881 32.3878 21.6033 31.5962C20.4186 30.8045 19.4952 29.6794 18.9499 28.3629C18.4046 27.0465 18.2619 25.5979 18.5399 24.2004C18.8179 22.8029 19.504 21.5192 20.5116 20.5116C21.5192 19.504 22.8029 18.8179 24.2004 18.5399C25.5979 18.2619 27.0465 18.4046 28.3629 18.9499C29.6794 19.4952 30.8045 20.4186 31.5962 21.6033C32.3878 22.7881 32.8103 24.181 32.8103 25.6059C32.8084 27.516 32.0488 29.3474 30.6981 30.6981C29.3474 32.0488 27.5161 32.8084 25.6059 32.8103Z"
                fill="#111928"
              />
              <path
                d="M39.6629 37.9651L34.86 33.1621C34.6335 32.9434 34.3302 32.8224 34.0154 32.8251C33.7006 32.8279 33.3994 32.9541 33.1768 33.1768C32.9541 33.3994 32.8279 33.7006 32.8251 34.0154C32.8224 34.3302 32.9434 34.6335 33.1621 34.86L37.9651 39.6629C38.1916 39.8817 38.4949 40.0027 38.8097 40C39.1245 39.9972 39.4257 39.8709 39.6483 39.6483C39.8709 39.4257 39.9972 39.1245 40 38.8097C40.0027 38.4949 39.8817 38.1916 39.6629 37.9651Z"
                fill="#111928"
              />
              <path
                d="M29.2081 24.4052H22.0037C21.6852 24.4052 21.3798 24.5317 21.1546 24.7569C20.9295 24.982 20.803 25.2874 20.803 25.6059C20.803 25.9244 20.9295 26.2298 21.1546 26.455C21.3798 26.6801 21.6852 26.8066 22.0037 26.8066H29.2081C29.5266 26.8066 29.832 26.6801 30.0572 26.455C30.2823 26.2298 30.4089 25.9244 30.4089 25.6059C30.4089 25.2874 30.2823 24.982 30.0572 24.7569C29.832 24.5317 29.5266 24.4052 29.2081 24.4052Z"
                fill="#111928"
              />
            </svg>
          </button>
          <button onClick={rotateLeft}>
            <svg
              width="56"
              height="56"
              viewBox="0 0 56 56"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <rect width="56" height="56" rx="28" fill="white" />
              <path
                d="M23.1103 24.53L21.7003 23.11C20.8003 24.27 20.2403 25.61 20.0703 27H22.0903C22.2303 26.13 22.5803 25.28 23.1103 24.53ZM22.0903 29H20.0703C20.2403 30.39 20.7903 31.73 21.6903 32.89L23.1003 31.47C22.5803 30.72 22.2303 29.88 22.0903 29ZM23.1003 34.32C24.2603 35.22 25.6103 35.76 27.0003 35.93V33.9C26.1303 33.75 25.2903 33.41 24.5403 32.87L23.1003 34.32ZM29.0003 20.07V17L24.4503 21.55L29.0003 26V22.09C31.8403 22.57 34.0003 25.03 34.0003 28C34.0003 30.97 31.8403 33.43 29.0003 33.91V35.93C32.9503 35.44 36.0003 32.08 36.0003 28C36.0003 23.92 32.9503 20.56 29.0003 20.07Z"
                fill="#111928"
              />
            </svg>
          </button>
          <button onClick={rotateRight}>
            <svg
              width="56"
              height="56"
              viewBox="0 0 56 56"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <rect width="56" height="56" rx="28" fill="white" />
              <path
                d="M31.55 21.55L27 17V20.07C23.06 20.56 20 23.92 20 28C20 32.08 23.05 35.44 27 35.93V33.91C24.16 33.43 22 30.97 22 28C22 25.03 24.16 22.57 27 22.09V26L31.55 21.55ZM35.93 27C35.76 25.61 35.21 24.27 34.31 23.11L32.89 24.53C33.43 25.28 33.77 26.13 33.91 27H35.93ZM29 33.9V35.92C30.39 35.75 31.74 35.21 32.9 34.31L31.46 32.87C30.71 33.41 29.87 33.76 29 33.9ZM32.89 31.48L34.31 32.89C35.21 31.73 35.76 30.39 35.93 29H33.91C33.77 29.87 33.43 30.72 32.89 31.48Z"
                fill="#111928"
              />
            </svg>
          </button>
          <button onClick={resetTransformation}>
            <svg
              width="56"
              height="56"
              viewBox="0 0 56 56"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <rect width="56" height="56" rx="28" fill="white" />
              <path
                d="M28 22V25L32 21L28 17V20C23.58 20 20 23.58 20 28C20 29.57 20.46 31.03 21.24 32.26L22.7 30.8C22.25 29.97 22 29.01 22 28C22 24.69 24.69 22 28 22ZM34.76 23.74L33.3 25.2C33.74 26.04 34 26.99 34 28C34 31.31 31.31 34 28 34V31L24 35L28 39V36C32.42 36 36 32.42 36 28C36 26.43 35.54 24.97 34.76 23.74Z"
                fill="#111928"
              />
            </svg>
          </button>
        </div>
        <button
          className="absolute right-[15%] top-[15%] size-[50px] rounded-full text-lg font-bold text-white"
          onClick={onClose}
        >
          X
        </button>
      </div>
    </div>
  )
}

export default CanvasComponent
