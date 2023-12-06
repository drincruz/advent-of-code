import { isPossibleGame, parseCubeSubsets, parseGameInput } from "../../day02";

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
