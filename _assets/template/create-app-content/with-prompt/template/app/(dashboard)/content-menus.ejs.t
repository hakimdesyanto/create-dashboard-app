---
to: src/app/(dashboard)/content-menus.json
force: true
---
[
<% for(var i=0; i < contentMenus.length; i++) { -%>
  {
    "name": "<%=contentMenus[i].name%>",
    "label": "<%=h.changeCase.titleCase(h.inflection.pluralize(contentMenus[i].name))%>",
<% if(contentMenus[i].submenus) { -%>
    "submenus": [
<% for(var j=0; j < contentMenus[i].submenus.length; j++) { -%>
      {
        "name": "<%=contentMenus[i].submenus[j].name%>",
        "label": "<%=h.changeCase.titleCase(h.inflection.pluralize(contentMenus[i].submenus[j].name))%>",
        "href": "/<%=contentMenus[i].submenus[j].name%>"
<% if(j+1 === contentMenus[i].submenus.length) { -%>
      }
<% } else { -%>
      },
<% } -%>
<% } -%>
    ]
<% } else { -%>
    "href": "/<%=contentMenus[i].name%>"
<% } -%>
<% if(i+1 === contentMenus.length) { -%>
  }
<% } else { -%>
  },
<% } -%>
<% } -%>
]