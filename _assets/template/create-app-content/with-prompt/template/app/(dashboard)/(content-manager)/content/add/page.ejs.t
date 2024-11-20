---
to: src/app/(dashboard)/(content-manager)/<%=contentName%>/add/page.tsx
---
import <%=h.changeCase.pascalCase(contentName)%>Add from '.'

export default async function <%=h.changeCase.pascalCase(contentName)%>AddPage() {
  return <<%=h.changeCase.pascalCase(contentName)%>Add />
}
