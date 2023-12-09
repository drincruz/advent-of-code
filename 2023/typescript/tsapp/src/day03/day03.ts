
type FoundNumber{
  value: number;
  row: number;
  column: number;
}

/**
 * Returns the beginning index of a number in an array of strings
 *
 * @param {string[]} arr
 * @param {number} startIndex
 * @returns {number}
 */
export function getBeginningOfNumber(arr: string[], startIndex: number): number {
  for(let i = startIndex; i >= 0; i--) {
    if(isNaN(Number(arr[i]))) {
      return i + 1;
    }
  }
  return 0;
}

/**
 * Converts an array of strings to a number
 *
 * @param {string[]} arr
 * @returns {number}
 */
export function getNumberFromArraySlice(arr: string[]): number {
  const numberString = arr.join('');
  return Number(numberString);
}
