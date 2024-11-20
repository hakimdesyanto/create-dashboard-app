#!/usr/bin/env node

const { execSync } = require("child_process");
const inquirer = require("inquirer");
const path = require("path");
const fs = require("fs");

async function getValidProjectName() {
  const isValidProjectName = (name) =>
    /^[a-z](?:[a-z0-9]*-?[a-z0-9]+)*$/.test(name); // Regex untuk lowercase dan kebab-case

  while (true) {
    const { projectName } = await inquirer.prompt([
      {
        type: "input",
        name: "projectName",
        message: "Nama project:",
      },
    ]);

    if (isValidProjectName(projectName)) {
      return projectName; // Nama valid, keluar dari loop
    } else {
      console.error(
        `\x1b[31mNama project tidak valid! Harus dalam format lowercase atau kebab-case (contoh: my-app, project123).\x1b[0m\n`
      );
    }
  }
}

async function main() {
  // const { projectName } = await inquirer.prompt([
  //   {
  //     type: "input",
  //     name: "projectName",
  //     message: "Nama project:",
  //   },
  // ]);
  const projectName = await getValidProjectName();

  const targetDirectory = path.join(process.cwd(), projectName);

  const assetSource = path.join(__dirname, "_assets/app"); // folder asli asset
  const templateCreateAppContentSource = path.join(
    __dirname,
    "_assets/template"
  ); // folder asli asset

  try {
    if (!fs.existsSync(targetDirectory)) {
      fs.mkdirSync(targetDirectory);
      console.log(`Folder "${projectName}" berhasil dibuat!`);
    } else {
      console.log(`Folder "${projectName}" sudah ada.`);
    }

    console.log("Menjalankan Hygen untuk membuat folder dan file...");

    const rootDirectory = path.join(__dirname, "_templates");

    execSync(`npx hygen dashboard app --name ${projectName}`, {
      cwd: path.join(process.cwd(), projectName), // jalankan Hygen di folder proyek
      env: {
        ...process.env,
        HYGEN_TMPLS: rootDirectory,
        APP_NAME: projectName,
      }, // set APP_NAME ke projectName
      stdio: "inherit",
    });

    fs.cpSync(templateCreateAppContentSource, `${targetDirectory}/_templates`, {
      recursive: true,
      force: true,
    }); // menyalin folder dengan recursive dan overwrite
    fs.cpSync(assetSource, targetDirectory, { recursive: true, force: true }); // menyalin folder dengan recursive dan overwrite

    console.log("Proyek berhasil dibuat dengan template tambahan dari Hygen!");
  } catch (error) {
    console.error("Terjadi kesalahan:", error);
  }
}

main();
