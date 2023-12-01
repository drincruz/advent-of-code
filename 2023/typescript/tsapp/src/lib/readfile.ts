import * as fs from "fs";

export function readFileToArray(filePath: string): string[] {
  try {
    const fileContent = fs.readFileSync(filePath, "utf-8");
    const lines = fileContent.split("\n");
    return lines;
  } catch (error) {
    throw new Error("File not found");
  }
}
