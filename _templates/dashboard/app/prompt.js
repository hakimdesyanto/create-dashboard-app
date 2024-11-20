const { appVars } = require("./vars");

const showError = (error) => {
  console.error(`\x1b[31m${error}\x1b[0m\n`);
};

const addAppPrompt = (prompter) => {
  const envAppName = process.env.APP_NAME; // Ambil appName dari env
  if (envAppName) {
    console.log(
      `\x1b[32mUsing app name from environment: ${envAppName}\x1b[0m`
    );
    return Promise.resolve({ appName: envAppName });
  }

  return prompter
    .prompt({
      type: "input",
      name: "appName",
      message: `What's your app name? (ex: pawon, pawon-temple)`,
    })
    .then(({ appName }) => {
      if (!/^[a-z](?:[a-z0-9]*-?[a-z0-9]+)*$/.test(appName)) {
        showError("Invalid app name! value must be lowercase or kebabcase");
        return addAppPrompt(prompter);
      }
      return { appName };
    });
};

module.exports = {
  prompt: ({ prompter }) => {
    return addAppPrompt(prompter).then(({ appName }) => {
      return prompter
        .prompt({
          type: "select",
          name: "appPrimaryColor",
          message: `What's your app primary color?`,
          initial: 0,
          choices: [
            "blue",
            "green",
            "red",
            "cyan",
            "orange",
            "purple",
            "indigo",
            "yellow",
            "pink",
          ],
        })
        .then(({ appPrimaryColor }) => {
          return prompter
            .prompt({
              type: "select",
              name: "appBusinessUnit",
              message: `What's your app business unit?`,
              initial: 0,
              choices: Object.keys(appVars),
            })
            .then(({ appBusinessUnit }) => {
              return prompter
                .prompt({
                  type: "select",
                  name: "appDeploy",
                  message: "Where your app will be deployed?",
                  initial: 0,
                  choices: appVars[appBusinessUnit]["deployment"],
                })
                .then(({ appDeploy }) => {
                  return Promise.resolve({
                    appName,
                    appPrimaryColor,
                    appBusinessUnit,
                    appDeploy,
                    appConfig: appVars[appBusinessUnit]["config"],
                  });
                });
            });
        });
    });
  },
};
