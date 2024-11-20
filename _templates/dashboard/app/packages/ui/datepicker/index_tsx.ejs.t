---
to: src/packages/ui/datepicker/index.tsx
---

import Timepicker from '@/src/packages/ui/timepicker'
import {
  DatepickerProps,
  Datepicker as FlowbiteDatepicker,
  HelperText,
} from 'flowbite-react'
import React, { useEffect, useState, type FC } from 'react'

interface Props extends DatepickerProps {
  value?: Date | string | any
  onChange?: (date: Date | any) => void
  helperText?: React.ReactNode
  timepicker?: boolean
}

const Datepicker: FC<Props> = function ({
  value,
  onChange,
  helperText,
  timepicker,
  ...props
}) {
  const [time, setTime] = useState('00:00')
  const [selectedDate, setSelectedDate] = useState<any | null>(
    props.defaultDate,
  )

  useEffect(() => {
    if (!props.defaultDate) return
    const hours =
      (props.defaultDate?.getHours() || 0) < 10
        ? `0${props.defaultDate?.getHours()}`
        : props.defaultDate?.getHours()
    const minutes =
      (props.defaultDate?.getMinutes() || 0) < 10
        ? `0${props.defaultDate?.getMinutes()}`
        : props.defaultDate?.getMinutes()
    setTime(`${hours}:${minutes}`)
  }, [])

  useEffect(() => {
    if (!selectedDate) return

    let timeArr = time.split(':')
    const date = new Date(selectedDate)
    date.setHours(Number(timeArr[0]), Number(timeArr[1]))
    if (onChange) onChange(date)
    setSelectedDate(date)
  }, [time])

  if (!timepicker)
    return (
      <div className="w-full">
        <FlowbiteDatepicker
          defaultDate={value}
          onSelectedDateChanged={onChange}
          value={timepicker ? `${value} ${time}` : value}
          {...props}
        />
        {helperText && (
          <HelperText className="text-red-500">{helperText}</HelperText>
        )}
      </div>
    )

  return (
    <>
      <div className="relative w-full">
        <FlowbiteDatepicker
          defaultDate={value}
          value={/\d{1,2}\s\w+\s\d{4}/.test(value) ? `${value} ${time}` : value}
          {...props}
          onSelectedDateChanged={(date) => {
            setSelectedDate(date)
            if (onChange) onChange(date)
          }}
        />
        <Timepicker
          value={time}
          onChange={setTime}
          showInput={false}
          showHelperText={false}
          disabled={props.disabled}
        />
      </div>
      {helperText && (
        <HelperText className="text-red-500">{helperText}</HelperText>
      )}
    </>
  )
}

export default Datepicker
