import { getCalibrationValue, isNumber } from "../../day01";

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

describe("getCalibrationValue", () => {
  it("should return the correct calibration value", () => {
    const input = ["a", "2", "3", "1"];
    const result = getCalibrationValue(input);
    expect(result).toBe(21);
  });

  it("should handle empty input correctly", () => {
    const input: string[] = [];
    const result = getCalibrationValue(input);
    expect(result).toBe(0);
  });

  it("should handle input with only one number correctly", () => {
    const input: string[] = ["a", "1", "b"];
    const result = getCalibrationValue(input);
    expect(result).toBe(11);
  });
});
