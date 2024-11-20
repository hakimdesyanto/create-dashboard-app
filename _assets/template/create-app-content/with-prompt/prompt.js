// see types of prompts:
// https://github.com/enquirer/enquirer/tree/master/examples
//
const path = require("path");
const fs = require("fs/promises");

const showError = (error) => {
  console.error(`\x1b[31m${error}\x1b[0m\n`);
};

const getContentMenus = () => {
  const menus = require(path.resolve("src/app/(dashboard)/content-menus.json"));
  return menus;
};

const getUpdatedContentMenus = (contentName, contentParentMenu) => {
  let menus = getContentMenus();
  if (contentParentMenu === "main-menu") {
    menus.push({
      name: contentName,
    });
  } else {
    const contentIndex = menus.findIndex(
      (menu) => menu.name === contentParentMenu
    );
    if (contentIndex >= 0) {
      if (menus[contentIndex].submenus) {
        menus[contentIndex].submenus.push({
          name: contentName,
        });
      } else {
        menus[contentIndex] = {
          name: menus[contentIndex].name,
          label: menus[contentIndex].label,
          submenus: [
            menus[contentIndex],
            {
              name: contentName,
            },
          ],
        };
      }
    } else {
      menus.push({
        name: contentParentMenu,
        submenus: [
          {
            name: contentName,
          },
        ],
      });
    }
  }
  return menus;
};

const addContentPrompt = (prompter) => {
  return prompter
    .prompt({
      type: "input",
      name: "contentName",
      message: `What's your content name? (in singular, ex: campaign, campaign-donation)`,
    })
    .then(async ({ contentName }) => {
      if (!/^[a-z](?:[a-z0-9]*-?[a-z0-9]+)*$/.test(contentName)) {
        showError("Invalid content name! value must be lowercase or kebabcase");
        return addContentPrompt(prompter);
      }
      const services = await fs.readdir("src/services");
      return prompter
        .prompt({
          type: "select",
          name: "serviceName",
          message: `What's a backend service name for your content?`,
          initial: 0,
          choices: ["add-new", ...services],
        })
        .then(({ serviceName }) => {
          if (serviceName === "add-new") {
            return addServiceNamePrompt(prompter, {
              contentName,
            });
          } else {
            return toggleDraftModePrompt(prompter, {
              contentName,
              serviceName,
            });
          }
        });
    });
};

const addServiceNamePrompt = (prompter, { contentName }) => {
  return prompter
    .prompt({
      type: "input",
      name: "serviceName",
      message: "Type the name of backend service! (ex: kampanye, core-api)",
    })
    .then(({ serviceName }) => {
      if (!/^[a-z](?:[a-z0-9]*-?[a-z0-9]+)*$/.test(serviceName)) {
        showError(
          "Invalid add new service name! value must be lowercase or kebabcase"
        );
        return addServiceNamePrompt(prompter, {
          contentName,
        });
      }
      return toggleDraftModePrompt(prompter, {
        contentName,
        serviceName,
      });
    });
};

const toggleDraftModePrompt = (prompter, { contentName, serviceName }) => {
  return prompter
    .prompt({
      type: "confirm",
      name: "isUsingDraftMode",
      message: "This content is enable draft mode?",
      initial: false,
    })
    .then(({ isUsingDraftMode }) => {
      return prompter
        .prompt({
          type: "select",
          name: "contentParentMenu",
          message: `What's a parent menu for your content?`,
          initial: 0,
          choices: ["add-new", "main-menu", ...getContentMenus()],
        })
        .then(({ contentParentMenu }) => {
          if (contentParentMenu === "add-new") {
            return addContentParentMenuPrompt(prompter, {
              contentName,
              serviceName,
              isUsingDraftMode,
            });
          } else {
            const contentMenus = getUpdatedContentMenus(
              contentName,
              contentParentMenu
            );
            const contentFields = [];
            return addContentFieldPrompt(prompter, {
              contentName,
              serviceName,
              isUsingDraftMode,
              contentMenus,
              contentFields,
            });
          }
        });
    });
};

const addContentParentMenuPrompt = (
  prompter,
  { contentName, serviceName, isUsingDraftMode }
) => {
  return prompter
    .prompt({
      type: "input",
      name: "contentParentMenu",
      message:
        "Type the name of parent menu! (in singular, ex: claim, claim-internal)",
    })
    .then(({ contentParentMenu }) => {
      if (!/^[a-z](?:[a-z0-9]*-?[a-z0-9]+)*$/.test(contentParentMenu)) {
        showError(
          "Invalid add new parent menu name! value must be lowercase or kebabcase"
        );
        return addContentParentMenuPrompt(prompter, {
          contentName,
          serviceName,
          isUsingDraftMode,
        });
      }
      const contentMenus = getUpdatedContentMenus(
        contentName,
        contentParentMenu
      );
      const contentFields = [];
      return addContentFieldPrompt(prompter, {
        contentName,
        serviceName,
        isUsingDraftMode,
        contentMenus,
        contentFields,
      });
    });
};

const addContentFieldPrompt = (
  prompter,
  { contentName, serviceName, isUsingDraftMode, contentMenus, contentFields }
) => {
  return prompter
    .prompt({
      type: "input",
      name: "fieldName",
      message: `What's your field name? (ex: title, background_image)`,
    })
    .then(({ fieldName }) => {
      if (!/^[a-z](?:[a-z0-9]*_?[a-z0-9]+)*$/.test(fieldName)) {
        showError("Invalid field name! value must be lowercase or snakecase");
        return addContentFieldPrompt(prompter, {
          contentName,
          serviceName,
          isUsingDraftMode,
          contentMenus,
          contentFields,
        });
      }
      return prompter
        .prompt({
          type: "select",
          name: "fieldType",
          message: `What's your type for field ${fieldName}`,
          initial: 0,
          choices: [
            "text",
            "number",
            "date",
            "longtext",
            "richtext",
            "select",
            "enum",
            "boolean",
            "image",
            "json",
          ],
        })
        .then(({ fieldType }) => {
          return prompter
            .prompt({
              type: "confirm",
              name: "addAnotherField",
              message: "Do you want to add another field?",
              initial: true,
            })
            .then(({ addAnotherField }) => {
              contentFields.push({
                name: fieldName,
                type: fieldType,
              });
              if (addAnotherField) {
                return addContentFieldPrompt(prompter, {
                  contentName,
                  serviceName,
                  isUsingDraftMode,
                  contentMenus,
                  contentFields,
                });
              } else {
                return Promise.resolve({
                  contentName,
                  serviceName,
                  isUsingDraftMode,
                  contentMenus,
                  contentFields,
                });
              }
            });
        });
    });
};

module.exports = {
  prompt: ({ prompter }) => {
    return addContentPrompt(prompter);
  },
};
