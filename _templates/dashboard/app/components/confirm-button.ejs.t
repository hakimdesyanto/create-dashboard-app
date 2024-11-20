---
to: src/components/confirm-button.tsx
---
import { Button, Modal } from 'flowbite-react'
import { useState, type FC } from 'react'
import { HiOutlineExclamationCircle } from 'react-icons/hi'

const CancelButton: FC<any> = function ({ href, children }) {
  const [openModal, setOpenModal] = useState(false)

  return (
    <>
      <Button
        color="light"
        type="button"
        onClick={() => setOpenModal(true)}
      >
        {children}
      </Button>
      <Modal show={openModal} size="md" onClose={() => setOpenModal(false)} dismissible popup>
        <Modal.Header />
        <Modal.Body>
          <div className="text-center">
            <HiOutlineExclamationCircle className="mx-auto mb-4 h-14 w-14 text-gray-400 dark:text-gray-200" />
            <h3 className="mb-5 text-lg font-normal text-gray-500 dark:text-gray-400">
              Are you sure you want to discard this changes?
            </h3>
            <div className="flex justify-center gap-4">
              <Button color="primary" href={href}>
                {"Yes, I'm sure"}
              </Button>
              <Button color="gray" onClick={() => setOpenModal(false)}>
                No, cancel
              </Button>
            </div>
          </div>
        </Modal.Body>
      </Modal>
    </>
  )
}

const SubmitButton: FC<any> = function ({ form, disabled, children }) {
  const [openModal, setOpenModal] = useState(false)

  return (
    <>
      <Button
        color="primary"
        type="button"
        onClick={() => setOpenModal(true)}
        disabled={disabled}
      >
        {children}
      </Button>
      <Modal show={openModal} size="md" onClose={() => setOpenModal(false)} dismissible popup>
        <Modal.Header />
        <Modal.Body>
          <div className="text-center">
            <HiOutlineExclamationCircle className="mx-auto mb-4 h-14 w-14 text-gray-400 dark:text-gray-200" />
            <h3 className="mb-5 text-lg font-normal text-gray-500 dark:text-gray-400">
              Are you sure you want to submit this changes?
            </h3>
            <div className="flex justify-center gap-4">
              <Button color="primary" type="submit" form={form} disabled={disabled}>
                {"Yes, I'm sure"}
              </Button>
              <Button color="gray" onClick={() => setOpenModal(false)}>
                No, cancel
              </Button>
            </div>
          </div>
        </Modal.Body>
      </Modal>
    </>
  )
}

const SaveAsDraftButton: FC<any> = function ({ onSaveAsDraft, disabled, children }) {
  const [openModal, setOpenModal] = useState(false)

  return (
    <>
      <Button
        color="dark"
        type="button"
        onClick={() => setOpenModal(true)}
        disabled={disabled}
      >
        {children}
      </Button>
      <Modal
        show={openModal}
        size="md"
        onClose={() => setOpenModal(false)}
        dismissible
        popup
      >
        <Modal.Header />
        <Modal.Body>
          <div className="text-center">
            <HiOutlineExclamationCircle className="mx-auto mb-4 h-14 w-14 text-gray-400 dark:text-gray-200" />
            <h3 className="mb-5 text-lg font-normal text-gray-500 dark:text-gray-400">
              Are you sure you want to save as draft this changes?
            </h3>
            <div className="flex justify-center gap-4">
              <Button
                color="primary"
                type="button"
                disabled={disabled}
                onClick={() => {
                  setOpenModal(false)
                  onSaveAsDraft()
                }}
              >
                {"Yes, I'm sure"}
              </Button>
              <Button color="gray" onClick={() => setOpenModal(false)}>
                No, cancel
              </Button>
            </div>
          </div>
        </Modal.Body>
      </Modal>
    </>
  )
}

export { CancelButton, SubmitButton, SaveAsDraftButton }
