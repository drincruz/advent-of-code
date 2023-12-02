import { readFileToArray } from "../lib";

export function isNumber(num: string): boolean {
  return !isNaN(Number(num));
}

export function getCalibrationValue(input: string[]): number {
  const numbers: string[] = input.filter(isNumber);
  if (numbers.length === 0) {
    return 0;
  }
  // If there is only one number, return the number twice since it's _technically_ the first and last number
  if (numbers.length === 1) {
    return Number(`${numbers[0]}${numbers[0]}`);
  }
  const first: string = numbers.shift();
  const last: string = numbers?.pop();
  return Number(`${first}${last}`);
}

export function getSumOfCalibrationValues(data: string[]) {
  const splitData: Array<string[]> = data.map((line) => line.split(""));
  const calibrationValues: number[] = splitData.map(getCalibrationValue);
  return calibrationValues.reduce((acc, cur) => acc + cur, 0);
}

function main() {
  const data: string[] = readFileToArray(`${__dirname}/input.txt`);
  console.log(getSumOfCalibrationValues(data));
}

main();
