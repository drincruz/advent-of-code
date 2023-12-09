import { getBeginningOfNumber, getNumberFromArraySlice } from '../../day03';

describe('getBeginningOfNumber', () => {
  it('traverses an array backwards until it finds the beginning of a number', () => {
    const input = ['.', '.', '.', '.', '.', '1', '1', '1', '1'];
    const expected = 5;
    const actual = getBeginningOfNumber(input, 7);

    expect(actual).toEqual(expected);
  });
});

describe ('getNumberFromArraySlice', () => {
  it('converts an array of strings to a number', () => {
    const input = ['1', '2', '3'];
    const expected = 123;
    const actual = getNumberFromArraySlice(input);

    expect(actual).toEqual(expected);
  });

  it('accepts an array slice', () => {
    const input = ['1', '2', '3'];
    const expected = 23;
    const actual = getNumberFromArraySlice(input.slice(1));

    expect(actual).toEqual(expected);
  })
});
