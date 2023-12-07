import { readFileToArray } from "../lib";

type CubeSubset = {
  blue?: number;
  green?: number;
  red?: number;
};

type GameRecord = {
  game: number;
  colours: CubeSubset[];
};

/**
 * Parses a semi-colon separated string of cube subsets into an Array of cube subsets
 *
 * @param {string} input
 * @returns {CubeSubset[]}
 */
export function parseCubeSubsets(input: string): CubeSubset[] {
  if (!input) return [];
  return input.split(";").map((subset) => {
    return subset.split(",").reduce((acc, colour) => {
      const [count, colourName] = colour.trim().split(" ");
      acc[colourName] = parseInt(count);
      return acc;
    }, {} as CubeSubset);
  });
}

/**
 * Parses a colon separated string of game number and cube subsets into a GameRecord
 *
 * @param {string} input
 * @returns {GameRecord}
 */
export function parseGameInput(input: string): GameRecord {
  const [gameNumber, cubeSubsets] = input.split(":");
  return {
    game: parseInt(gameNumber.split(" ")[1]),
    colours: parseCubeSubsets(cubeSubsets),
  };
}

/**
 * Check if a game is possible given the colour totals and constraints.
 *
 * @param {CubeSubset} colourTotals
 * @param {CubeSubset} constraints
 * @returns {boolean}
 */
export function isPossibleGame(
  colourTotals: CubeSubset,
  constraints: CubeSubset
): boolean {
  return Object.keys(colourTotals).every((colour) => {
    return colourTotals[colour] <= constraints[colour];
  });
}

/**
 * Get the maximum values for each colour in an Array of cube subsets.
 * This will give us the _minimum_ number of cubes of each colour that we need.
 *
 * @param {CubeSubset} subsets
 * @returns {CubeSubset}
 */
export function getColourMaximums(subsets: CubeSubset[]): CubeSubset {
  return subsets.reduce((acc, subset) => {
    Object.keys(subset).forEach((colour) => {
      if (!acc[colour] || subset[colour] > acc[colour]) {
        acc[colour] = subset[colour];
      }
    });
    return acc;
  }, {} as CubeSubset);
}

/**
 * Get the power of a cube subset.
 * We are multiplying the cube subset values together to get the power.
 *
 * @param {CubeSubset} subset
 * @returns {number}
 */
export function getCubeSubsetPower(subset: CubeSubset): number {
  return Object.values(subset).reduce((acc, value) => {
    return acc * value;
  }, 1);
}

/**
 * Given an Array of cube subsets, get the sum of the power of each subset.
 *
 * @param {CubeSubset} subsets
 * @returns {number}
 */
export function getSumOfCubeSubsetPowers(subsets: CubeSubset[]): number {
  return subsets.reduce((acc, subset) => {
    return acc + getCubeSubsetPower(subset);
  }, 0);
}

function main() {
  const input = readFileToArray(`${__dirname}/input.txt`);
  const constraints: CubeSubset = { blue: 14, green: 13, red: 12 };
  const games: GameRecord[] = input.map(parseGameInput);

  const possibleGames: GameRecord[] = games.filter((game) => {
    return (
      !isNaN(Number(game.game)) &&
      game.colours.every((subset) => isPossibleGame(subset, constraints))
    );
  });

  const possibleGamesIdTotal: number = possibleGames.reduce((acc, game) => {
    return acc + game.game;
  }, 0);

  console.log(possibleGamesIdTotal);

  // Part 2
  const gameColourMaximums: CubeSubset[] = games
    .filter((game) => {
      return !isNaN(Number(game.game));
    })
    .map((game) => game.colours)
    .map(getColourMaximums);
  const powerValues: number[] = gameColourMaximums.map(getCubeSubsetPower);
  const cubeValuesTotal: number = powerValues.reduce((acc, value) => {
    return acc + value;
  }, 0);

  console.log(cubeValuesTotal);
}

main();
