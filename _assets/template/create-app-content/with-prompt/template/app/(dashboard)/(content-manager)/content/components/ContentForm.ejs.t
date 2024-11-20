---
to: src/app/(dashboard)/(content-manager)/<%=contentName%>/components/ContentForm.tsx
---
'use client'

import {
  CancelButton,
<% if (isUsingDraftMode) { -%>
  SaveAsDraftButton,
<% } -%>
  SubmitButton,
} from '@/src/components/confirm-button'
import { useLayoutContext } from '@/src/context/LayoutContext'
import {
  add<%=h.changeCase.pascalCase(contentName)%>,
<% if (isUsingDraftMode) { -%>
  addDraft<%=h.changeCase.pascalCase(contentName)%>,
<% } -%>
  update<%=h.changeCase.pascalCase(contentName)%>,
<% if (isUsingDraftMode) { -%>
  updateDraft<%=h.changeCase.pascalCase(contentName)%>,
<% } -%>
} from '@/src/services/<%=serviceName%>/<%=contentName%>'
import {
  uploadImage,
  getImageUrl,
  setFormDataImage,
} from '@/src/services/gudang/image'
import Datepicker from '@/src/packages/ui/datepicker'
import FileInput from '@/src/packages/ui/file-input'
import JsonEditor from '@/src/packages/ui/json-editor'
import RichTextEditor from '@/src/packages/ui/rich-text-editor'
import Select from '@/src/packages/ui/select'
import { zodResolver } from '@hookform/resolvers/zod'
import {
  Alert,
  Card,
  HelperText,
  Label,
  Radio,
  TextInput,
  Textarea,
  ToggleSwitch,
} from 'flowbite-react'
import { useRouter } from 'next/navigation'
import { useState, type FC } from 'react'
import { Controller, useForm } from 'react-hook-form'
import * as z from 'zod'

const contentSchema = z.object({
<% contentFields.forEach((field) => { -%>
<% switch (field.type) {
case 'text': -%>
  <%=field.name%>: z.string().min(1, { message: '<%=h.changeCase.titleCase(field.name)%> is required' }),
<% break;
case 'longtext': -%>
  <%=field.name%>: z.string().min(1, { message: '<%=h.changeCase.titleCase(field.name)%> is required' }),
<% break;
case 'richtext': -%>
  <%=field.name%>: z.string().min(1, { message: '<%=h.changeCase.titleCase(field.name)%> is required' }),
<% break;
case 'number': -%>
  <%=field.name%>: z.number().min(1, { message: '<%=h.changeCase.titleCase(field.name)%> is required' }).max(1000000, { message: '<%=h.changeCase.titleCase(field.name)%> cannot be more than 1.000.000' }),
<% break;
case 'enum': -%>
  <%=field.name%>: z.string({ invalid_type_error: '<%=h.changeCase.titleCase(field.name)%> is required' }),
<% break;
case 'date': -%>
  <%=field.name%>: z.date(),
<% break;
case 'boolean': -%>
  <%=field.name%>: z.boolean(),
<% break;
case 'select': -%>
  <%=field.name%>: z.number({ invalid_type_error: '<%=h.changeCase.titleCase(field.name)%> is required' }),
<% break;
case 'image': -%>
  <%=field.name%>: z.string({ required_error: '<%=h.changeCase.titleCase(field.name)%> is required' }),
<% break;
case 'json': -%>
  <%=field.name%>: z.string()
    .min(1, { message: '<%=h.changeCase.titleCase(field.name)%> is required' })
    .refine((val) => {
      if (val) {
        try {
          JSON.parse(val)
          return true
        } catch (_e) {
          return false
        }
      }
      return true
    }, { message: "<%=h.changeCase.titleCase(field.name)%> is not valid JSON" }),
<% break;
default:
break; } -%>
<% }) -%>
})

type ContentSchema = z.infer<typeof contentSchema>

const ContentForm: FC<any> = function ({ <%=h.changeCase.camelCase(contentName)%> }) {
  const mode = <%=h.changeCase.camelCase(contentName)%> ? 'edit' : 'create'
  const router = useRouter()
  const { toast: { setToast } } = useLayoutContext()
<% if (contentFields.some((field) => field.type === 'image')) { -%>
  const [isProcessingUpload, setIsProcessingUpload] = useState({
<% contentFields.filter((field) => field.type === 'image').map((field) => { -%>
    <%=field.name%>: false,
<% }) -%>
  })
<% } -%>
  const {
    register,
    resetField,
    handleSubmit,
    getValues,
    formState: { errors, isSubmitting, isDirty, isValid, dirtyFields },
    control,
  } = useForm<ContentSchema>({
    resolver: zodResolver(contentSchema),
    mode: 'onChange',
    defaultValues: {
<% contentFields.forEach((field) => { -%>
<% switch (field.type) {
case 'select': -%>
      <%=field.name%>: <%=h.changeCase.camelCase(contentName)%>?.<%=field.name%>.id,
<% break;
case 'date': -%>
      <%=field.name%>: <%=h.changeCase.camelCase(contentName)%>?.<%=field.name%>
        ? new Date(<%=h.changeCase.camelCase(contentName)%>.<%=field.name%>)
        : new Date(),
<% break;
case 'boolean': -%>
      <%=field.name%>: <%=h.changeCase.camelCase(contentName)%>?.<%=field.name%> || false,
<% break;
default: -%>
      <%=field.name%>: <%=h.changeCase.camelCase(contentName)%>?.<%=field.name%>,
<% break; } -%>
<% }) -%>
    },
  })

  const fetchAdd<%=h.changeCase.pascalCase(contentName)%> = async (data: any): Promise<any> => {
    try {
      const response = await add<%=h.changeCase.pascalCase(contentName)%>(data)
      if (response.status === 201) {
        router.push('/<%=contentName%>')
        setToast({
          message: '<%=h.changeCase.titleCase(contentName)%> has been added',
          show: true,
        })
      } else {
        setToast({
          message: '<%=h.changeCase.titleCase(contentName)%> failed to add',
          show: true,
        })
      }
    } catch (error: any) {
      throw new Error(error)
    }
  }

  const fetchUpdate<%=h.changeCase.pascalCase(contentName)%> = async (data: any): Promise<any> => {
    try {
      const response = await update<%=h.changeCase.pascalCase(contentName)%>(<%=h.changeCase.camelCase(contentName)%>.id, data)
      if (response.status === 200) {
        router.push('/<%=contentName%>')
        setToast({
          message: '<%=h.changeCase.titleCase(contentName)%> has been updated',
          show: true,
        })
      } else {
        setToast({
          message: '<%=h.changeCase.titleCase(contentName)%> failed to update',
          show: true,
        })
      }
    } catch (error: any) {
      throw new Error(error)
    }
  }

<% if (isUsingDraftMode) { -%>
  const fetchAddDraft<%=h.changeCase.pascalCase(contentName)%> = async (data: any): Promise<any> => {
    try {
      const response = await addDraft<%=h.changeCase.pascalCase(contentName)%>(data)
      if (response.status === 201) {
        router.refresh()
        setToast({
          message: '<%=h.changeCase.titleCase(contentName)%> has been added as draft',
          show: true,
        })
      } else {
        setToast({
          message: '<%=h.changeCase.titleCase(contentName)%> failed to add as draft',
          show: true,
        })
      }
    } catch (error: any) {
      throw new Error(error)
    }
  }

  const fetchUpdateDraft<%=h.changeCase.pascalCase(contentName)%> = async (data: any): Promise<any> => {
    try {
      const response = await updateDraft<%=h.changeCase.pascalCase(contentName)%>(data)
      if (response.status === 200) {
        router.refresh()
        setToast({
          message: '<%=h.changeCase.titleCase(contentName)%> has been updated as draft',
          show: true,
        })
      } else {
        setToast({
          message: '<%=h.changeCase.titleCase(contentName)%> failed to update as draft',
          show: true,
        })
      }
    } catch (error: any) {
      throw new Error(error)
    }
  }

<% } -%>
  const onSubmit = async (data: ContentSchema) => {
    console.log(data)
    if (mode === 'create') {
      await fetchAdd<%=h.changeCase.pascalCase(contentName)%>(data)
    } else {
      await fetchUpdate<%=h.changeCase.pascalCase(contentName)%>(data)
    }
  }

<% if (isUsingDraftMode) { -%>
  const onSaveAsDraft = async () => {
    const data = getValues()
    console.log(data)
    if (mode === 'create') {
      await fetchAddDraft<%=h.changeCase.pascalCase(contentName)%>(data)
    } else {
      await fetchUpdateDraft<%=h.changeCase.pascalCase(contentName)%>(data)
    }
  }

<% } -%>
  return (
    <div className="flex flex-col gap-4">
<% if (isUsingDraftMode) { -%>
      {<%=h.changeCase.camelCase(contentName)%>?.is_draft &&
        <Alert color="warning" rounded>
          <span className="font-medium">Info!</span> Your screen is editing a draft version.
        </Alert>
      }
<% } -%>
      <form id="<%=contentName%>-form" onSubmit={handleSubmit(onSubmit)}>
        <div className="grid grid-cols-1 gap-6 lg:grid-cols-3 items-start">
          <Card className="col-span-3 lg:col-span-2">
            <h3 className="mb-4 text-xl font-bold dark:text-white">Detail</h3>
            <div className="mb-6 grid grid-cols-1 gap-6">
              <div className="col-span-1 grid grid-cols-1 gap-y-4">
<% contentFields.forEach((field) => { -%>
<% switch (field.type) {
case 'text': -%>
                <div className="grid grid-cols-1 gap-y-2">
                  <Label htmlFor="<%=field.name%>"><%=h.changeCase.titleCase(field.name)%></Label>
                  <TextInput
                    {...register('<%=field.name%>')}
                    id="<%=field.name%>"
                    color="primary"
                    helperText={
                      errors.<%=field.name%>?.message && (
                        <span className="text-red-500">
                          {errors.<%=field.name%>?.message}
                        </span>
                      )
                    }
                  />
                </div>
<% break;
case 'longtext': -%>
                <div className="grid grid-cols-1 gap-y-2">
                  <Label htmlFor="<%=field.name%>"><%=h.changeCase.titleCase(field.name)%></Label>
                  <Textarea
                    {...register('<%=field.name%>')}
                    id="<%=field.name%>"
                    color="primary"
                    helperText={
                      errors.<%=field.name%>?.message && (
                        <span className="text-red-500">
                          {errors.<%=field.name%>?.message}
                        </span>
                      )
                    }
                  />
                </div>
<% break;
case 'richtext': -%>
                <div className="grid grid-cols-1 gap-y-2">
                  <Label htmlFor="<%=field.name%>"><%=h.changeCase.titleCase(field.name)%></Label>
                  <Controller
                    control={control}
                    name="<%=field.name%>"
                    render={({ field: { value, onChange } }) => (
                      <RichTextEditor
                        id="<%=field.name%>"
                        value={value}
                        onChange={onChange}
                        helperText={
                          errors.<%=field.name%>?.message && (
                            <span className="text-red-500">
                              {errors.<%=field.name%>?.message}
                            </span>
                          )
                        }
                      />
                    )}
                  />
                </div>
<% break;
case 'number': -%>
                <div className="grid grid-cols-1 gap-y-2">
                  <Label htmlFor="<%=field.name%>"><%=h.changeCase.titleCase(field.name)%></Label>
                  <TextInput
                    {...register('<%=field.name%>', {
                      setValueAs: (value) => Number(value),
                    })}
                    id="<%=field.name%>"
                    color="primary"
                    helperText={
                      errors.<%=field.name%>?.message && (
                        <span className="text-red-500">
                          {errors.<%=field.name%>?.message}
                        </span>
                      )
                    }
                    type="number"
                  />
                </div>
<% break;
case 'enum': -%>
                <div className="grid grid-cols-1 gap-y-2">
                  <Label><%=h.changeCase.titleCase(field.name)%></Label>
                  <div className="flex items-center gap-2">
                    <Radio {...register('<%=field.name%>')} id="<%=field.name%>_1" value="Option 1" />
                    <Label htmlFor="<%=field.name%>_1">Option 1</Label>
                  </div>
                  <div className="flex items-center gap-2">
                    <Radio {...register('<%=field.name%>')} id="<%=field.name%>_2" value="Option 2" />
                    <Label htmlFor="<%=field.name%>_2">Option 2</Label>
                  </div>
                  <div className="flex items-center gap-2">
                    <Radio {...register('<%=field.name%>')} id="<%=field.name%>_3" value="Option 3" />
                    <Label htmlFor="<%=field.name%>_3">Option 3</Label>
                  </div>
                  {errors.<%=field.name%>?.message && (
                    <HelperText className="text-red-500">
                      {errors.<%=field.name%>?.message}
                    </HelperText>
                  )}
                </div>
<% break;
case 'date': -%>
                <div className="grid grid-cols-1 gap-y-2">
                  <Label htmlFor="<%=field.name%>"><%=h.changeCase.titleCase(field.name)%></Label>
                  <Controller
                    control={control}
                    name="<%=field.name%>"
                    render={({ field: { value, onChange } }) => (
                      <Datepicker
                        id="<%=field.name%>"
                        value={value}
                        onChange={onChange}
                        helperText={
                          errors.<%=field.name%>?.message && (
                            <span className="text-red-500">
                              {errors.<%=field.name%>?.message}
                            </span>
                          )
                        }
                      />
                    )}
                  />
                </div>
<% break;
case 'boolean': -%>
                <div className="grid grid-cols-1 gap-y-2">
                  <Label htmlFor="<%=field.name%>"><%=h.changeCase.titleCase(field.name)%></Label>
                  <Controller
                    control={control}
                    name="<%=field.name%>"
                    render={({ field: { value, onChange } }) => (
                      <ToggleSwitch
                        id="<%=field.name%>"
                        className="w-fit"
                        color="primary"
                        checked={value}
                        onChange={onChange}
                      />
                    )}
                  />
                </div>
<% break;
case 'select': -%>
                <div className="grid grid-cols-1 gap-y-2">
                  <Label htmlFor="<%=field.name%>"><%=h.changeCase.titleCase(field.name)%></Label>
                  <Controller
                    control={control}
                    name="<%=field.name%>"
                    render={({ field: { value, onChange } }) => {
                      const options = [
                        { value: 1, label: "Option 1" },
                        { value: 2, label: "Option 2" },
                        { value: 3, label: "Option 3" },
                      ]
                      return (
                        <Select
                          id="<%=field.name%>"
                          value={options.find((option) => option.value === value)}
                          onChange={(option: any) => {
                            onChange(option?.value ?? null)
                          }}
                          placeholder="Choose a <%=h.changeCase.titleCase(field.name)%>"
                          options={options}
                          helperText={
                            errors.<%=field.name%>?.message && (
                              <span className="text-red-500">
                                {errors.<%=field.name%>?.message}
                              </span>
                            )
                          }
                        />
                      )
                    }}
                  />
                </div>
<% break;
case 'image': -%>
                <div className="grid grid-cols-1 gap-y-2">
                  <Label><%=h.changeCase.titleCase(field.name)%></Label>
                  <Controller
                    control={control}
                    name="<%=field.name%>"
                    render={({ field: { onChange, ...field } }) => (
                      <FileInput
                        { ...field }
                        id="<%=field.name%>"
                        accept="image/jpeg, image/png"
                        isProcessingUpload={isProcessingUpload.<%=field.name%>}
                        allowDelete={dirtyFields.<%=field.name%>}
                        onDelete={() => resetField('<%=field.name%>')}
                        onChange={async (e: any) => {
                          if (e.target.files.length > 0) {
                            try {
                              setIsProcessingUpload((prevState) => ({
                                ...prevState,
                                <%=field.name%>: true,
                              }))
                              const data = setFormDataImage(e.target.files[0])
                              const response = await uploadImage(data)
                              if (response.status === 200) {
                                onChange(getImageUrl(response.data.data[0].full_path))
                              } else {
                                setToast({
                                  message: 'Failed to upload <%=h.changeCase.titleCase(field.name)%>',
                                  show: true,
                                })
                              }
                              setIsProcessingUpload((prevState) => ({
                                ...prevState,
                                <%=field.name%>: false,
                              }))
                            } catch (error: any) {
                              throw new Error(error)
                            }
                          }
                        }}
                        helperText={
                          errors.<%=field.name%>?.message && (
                            <span className="text-red-500">
                              {errors.<%=field.name%>?.message}
                            </span>
                          )
                        }
                      />
                    )}
                  />
                </div>
<% break;
case 'json': -%>
                <div className="grid grid-cols-1 gap-y-2">
                  <Label htmlFor="<%=field.name%>"><%=h.changeCase.titleCase(field.name)%></Label>
                  <Controller
                    control={control}
                    name="<%=field.name%>"
                    render={({ field: { value, onChange } }) => (
                      <JsonEditor
                        value={value}
                        onChange={onChange}
                        helperText={
                          errors.<%=field.name%>?.message && (
                            <span className="text-red-500">
                              {errors.<%=field.name%>?.message}
                            </span>
                          )
                        }
                      />
                    )}
                  />
                </div>
<% break;
default:
break; } -%>
<% }) -%>
              </div>
            </div>
            <div className="flex gap-4">
              <CancelButton href="/<%=contentName%>">
                Cancel
              </CancelButton>
<% if (isUsingDraftMode) { -%>
              {(mode === 'create' || <%=h.changeCase.camelCase(contentName)%>?.is_draft) &&
                <SaveAsDraftButton
                  onSaveAsDraft={onSaveAsDraft}
                  disabled={isSubmitting || !isDirty || !isValid}
                >
                  Save as Draft
                </SaveAsDraftButton>
              }
<% } -%>
              <SubmitButton
                form="<%=contentName%>-form"
                disabled={isSubmitting || !isDirty || !isValid}
              >
                Submit
              </SubmitButton>
            </div>
          </Card>
        </div>
      </form>
    </div>
  )
}

export default ContentForm
