import { readFileToArray } from "../lib";

const NUMBER_WORDS: Array<string> = [
  "zero",
  "one",
  "two",
  "three",
  "four",
  "five",
  "six",
  "seven",
  "eight",
  "nine",
];

const NUMBER_WORD_VALUES = {
  zero: 0,
  one: 1,
  two: 2,
  three: 3,
  four: 4,
  five: 5,
  six: 6,
  seven: 7,
  eight: 8,
  nine: 9,
};

type NumberWordIndex = {
  word: string;
  index: number;
};

export function isNumber(num: string): boolean {
  return !isNaN(Number(num));
}

/**
 * Find all the indices of numbers in the input string.
 * Return the indices as an array of numbers.
 *
 * @param input
 * @returns number[]
 */
export function getNumberIndices(input: string): number[] {
  return input.split("").reduce((acc: number[], cur: string, index: number) => {
    if (isNumber(cur)) {
      acc.push(index);
    }
    return acc;
  }, []);
}

export function getNumberWordIndices(
  input: string
): Map<string, Array<number>> {
  const inputSplit = input.split("");
  let numberWordIndices: Map<string, Array<number>> = new Map<
    string,
    Array<number>
  >();
  for (let i = 0; i < inputSplit.length; i++) {
    NUMBER_WORDS.forEach((word: string) => {
      const substring: string = input.slice(i, input.length);
      if (substring.startsWith(word)) {
        if (numberWordIndices.has(word)) {
          numberWordIndices.get(word).push(i);
        } else {
          numberWordIndices.set(word, [i]);
        }
      }
    });
  }
  return numberWordIndices;
}

export function getIndexMin(numberWordIndices: Map<string, Array<number>>) {
  let minIndex: number = Infinity;
  let minNumWord: string = "";
  numberWordIndices.forEach((value: Array<number>, key: string) => {
    if (value[0] < minIndex) {
      minIndex = value[0];
      minNumWord = key;
    }
  });
  return { index: minIndex, word: minNumWord };
}

export function getIndexMax(numberWordIndices: Map<string, Array<number>>) {
  let maxIndex: number = -1;
  let maxNumWord: string = "";
  numberWordIndices.forEach((value: Array<number>, key: string) => {
    if (value[value.length - 1] > maxIndex) {
      maxIndex = value[value.length - 1];
      maxNumWord = key;
    }
  });
  return { index: maxIndex, word: maxNumWord };
}

export function getCalibrationValue(input: string): number {
  const numberIndices: number[] = getNumberIndices(input);
  const numberWordIndices: Map<string, Array<number>> = getNumberWordIndices(
    input
  );
  if (numberWordIndices.size === 0 && numberIndices.length === 0) {
    return 0;
  }
  const numberWordMin: NumberWordIndex = getIndexMin(numberWordIndices);
  const numberWordMax: NumberWordIndex = getIndexMax(numberWordIndices);
  const numberIndicesMin: number = Math.min(...numberIndices);
  const numberIndicesMax: number = Math.max(...numberIndices);

  let firstWord: string =
    numberIndicesMin < numberWordMin.index
      ? input[numberIndicesMin]
      : NUMBER_WORD_VALUES[numberWordMin.word];
  let secondWord: string =
    numberIndicesMax > numberWordMax.index
      ? input[numberIndicesMax]
      : NUMBER_WORD_VALUES[numberWordMax.word];

  return Number(`${firstWord}${secondWord}`);
}

export function getSumOfCalibrationValues(data: string[]) {
  const calibrationValues: number[] = data.map(getCalibrationValue);
  return calibrationValues.reduce((acc, cur) => acc + cur, 0);
}

function main() {
  const data: string[] = readFileToArray(`${__dirname}/input.txt`);
  console.log(getSumOfCalibrationValues(data));
}

main();
