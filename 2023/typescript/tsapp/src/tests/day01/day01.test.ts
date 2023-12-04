import { getCalibrationValue, getNumberIndices, isNumber } from "../../day01";

describe("isNumber", () => {
  it("should return true for valid numbers", () => {
    expect(isNumber("123")).toBe(true);
    expect(isNumber("-456")).toBe(true);
    expect(isNumber("0")).toBe(true);
  });

  it("should return false for invalid numbers", () => {
    expect(isNumber("abc")).toBe(false);
    expect(isNumber("12a3")).toBe(false);
  });
});

describe.only("getCalibrationValue", () => {
  it("should return the correct calibration value", () => {
    const input: string = "a231";
    const result = getCalibrationValue(input);
    expect(result).toBe(21);
  });

  it("should handle empty input correctly", () => {
    const input: string = "";
    const result = getCalibrationValue(input);
    expect(result).toBe(0);
  });

  it("should handle input with only one number correctly", () => {
    const input: string = "a1b";
    const result = getCalibrationValue(input);
    expect(result).toBe(11);
  });

  it("should handle number words correctly", () => {
    const input: string = "two1nine";
    const result = getCalibrationValue(input);
    expect(result).toBe(29);
  });

  it("provides the correct answer: from puzzle input", () => {
    const input: string = "5cfprzgxtf3465five";
    const result = getCalibrationValue(input);
    expect(result).toBe(55);
  });
});

describe("getNumberIndices", () => {
  it("should return the indices of numbers in the input array", () => {
    const input = "a2b3c1";
    const result = getNumberIndices(input);
    expect(result).toEqual([1, 3, 5]);
  });

  it("should handle empty input correctly", () => {
    const input: string = "";
    const result = getNumberIndices(input);
    expect(result).toEqual([]);
  });

  it("should handle input with no numbers correctly", () => {
    const input: string = "abc";
    const result = getNumberIndices(input);
    expect(result).toEqual([]);
  });
});
