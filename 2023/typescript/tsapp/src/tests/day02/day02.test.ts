import {
  getColourMaximums,
  getCubeSubsetPower,
  getSumOfCubeSubsetPowers,
  isPossibleGame,
  parseCubeSubsets,
  parseGameInput,
  type GameRecord,
} from "../../day02";

describe("parseGameInput", () => {
  it("parses the string into an Object with game number and colours", () => {
    const input = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green";
    const expected = {
      game: 1,
      colours: [
        { blue: 3, red: 4 },
        { red: 1, green: 2, blue: 6 },
        { green: 2 },
      ],
    };

    expect(parseGameInput(input)).toEqual(expected);
  });
});

describe("parseCubeSubsets", () => {
  it("parses the string into an Array of separate cube subsets", () => {
    const input = "3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green";
    const expected = [
      { red: 4, blue: 3 },
      { red: 1, green: 2, blue: 6 },
      { green: 2 },
    ];

    expect(parseCubeSubsets(input)).toEqual(expected);
  });
});

describe("isPossibleGame", () => {
  it("returns true if the colour totals are less than the values in the constraints", () => {
    const input = { red: 5, blue: 9, green: 4 };
    const constraints = { red: 5, blue: 10, green: 5 };

    expect(isPossibleGame(input, constraints)).toEqual(true);
  });

  it("returns false if the colour totals are greater than the values in the constraints", () => {
    const input = { red: 5, blue: 9, green: 4 };
    const constraints = { red: 5, blue: 8, green: 5 };

    expect(isPossibleGame(input, constraints)).toEqual(false);
  });

  it("returns false if the colours in the totals are not in the constraints", () => {
    const input = { red: 5, blue: 9, green: 4 };
    const constraints = { red: 5, blue: 10, yellow: 5 };

    expect(isPossibleGame(input, constraints)).toEqual(false);
  });
});

describe("getColourMaximums", () => {
  it("returns the maximum number of cubes of each colour", () => {
    const input = [
      { red: 4, blue: 3 },
      { red: 1, green: 2, blue: 6 },
      { green: 2 },
    ];
    const expected = { red: 4, blue: 6, green: 2 };

    expect(getColourMaximums(input)).toEqual(expected);
  });
});

describe("getCubeSubsetPower", () => {
  it("returns the product of the values in the subset", () => {
    const input = { red: 4, blue: 3 };
    const expected = 12;

    expect(getCubeSubsetPower(input)).toEqual(expected);
  });
});

describe("getSumOfCubeSubsetPowers", () => {
  it("returns the sum of the powers of each subset", () => {
    const input = [
      { red: 4, blue: 3 },
      { red: 1, green: 2, blue: 6 },
      { green: 2 },
    ];
    const expected = 12 + 12 + 2;

    expect(getSumOfCubeSubsetPowers(input)).toEqual(expected);
  });

  it("calculates everything from the given example", () => {
    const input = [
      "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green",
      "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue",
      "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red",
      "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red",
      "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green",
    ];
    const games = input.map(parseGameInput);
    const colourMaximums = games
      .map((game) => game.colours)
      .map(getColourMaximums);
    const powerValues = colourMaximums.map(getCubeSubsetPower);
    const total = powerValues.reduce((acc, value) => {
      return acc + value;
    }, 0);
    expect(total).toEqual(2286);
  });
});
