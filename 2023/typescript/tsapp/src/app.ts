import { readFileToArray } from "./lib";

function main() {
  try {
    const filePath = "/Users/drin/src/tmp/pants.txt";
    const array = readFileToArray(filePath);
    console.log(array);
  } catch (error) {
    console.error("An error occurred:", error);
  }
}

main();
