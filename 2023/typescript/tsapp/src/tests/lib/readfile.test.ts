import { readFileToArray } from "../../lib";

describe("readFileToArray", () => {
  it("should read file and return an array of lines", async () => {
    const filePath = `${__dirname}/testfile.txt`;
    const expectedArray = [
      "apple banana cat dog elephant",
      "flower garden house igloo jump",
      "kite lion monkey nest orange",
    ];
    const result = readFileToArray(filePath);

    expect(result).toEqual(expectedArray);
  });

  it("should handle file not found and throw an error", async () => {
    const filePath = "path/to/nonexistent-file.txt";

    expect(() => {
      readFileToArray(filePath);
    }).toThrow(new Error("File not found"));
  });
});
