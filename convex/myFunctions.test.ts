import { convexTest } from "convex-test";
import { describe, it, expect } from "vitest";
import { api } from "./_generated/api";
import schema from "./schema";
import { modules } from "./test.setup";

describe("myFunctions", () => {

  describe("addNumber mutation", () => {
    it("should insert a number into the database", async () => {
      const t = convexTest(schema, modules);
      // Add a number
      await t.mutation(api.myFunctions.addNumber, { value: 42 });

      // Verify it was inserted by querying the database directly
      const numbers = await t.run(async (ctx) => {
        return await ctx.db.query("numbers").collect();
      });

      expect(numbers).toHaveLength(1);
      expect(numbers[0].value).toBe(42);
    });

    it("should insert multiple numbers", async () => {
      const t = convexTest(schema, modules);
      // Add multiple numbers
      await t.mutation(api.myFunctions.addNumber, { value: 1 });
      await t.mutation(api.myFunctions.addNumber, { value: 2 });
      await t.mutation(api.myFunctions.addNumber, { value: 3 });

      // Verify all were inserted
      const numbers = await t.run(async (ctx) => {
        return await ctx.db.query("numbers").collect();
      });

      expect(numbers).toHaveLength(3);
      expect(numbers.map((n) => n.value)).toEqual([1, 2, 3]);
    });
  });

  describe("listNumbers query", () => {
    it("should return empty array when no numbers exist", async () => {
      const t = convexTest(schema, modules);
      const result = await t.query(api.myFunctions.listNumbers, { count: 10 });

      expect(result.numbers).toEqual([]);
      expect(result.viewer).toBeNull();
    });

    it("should return numbers in correct order (oldest first)", async () => {
      const t = convexTest(schema, modules);
      // Add numbers in sequence
      await t.mutation(api.myFunctions.addNumber, { value: 10 });
      await t.mutation(api.myFunctions.addNumber, { value: 20 });
      await t.mutation(api.myFunctions.addNumber, { value: 30 });

      // Query all numbers
      const result = await t.query(api.myFunctions.listNumbers, { count: 10 });

      // Should return in order they were inserted (reversed from desc query)
      expect(result.numbers).toEqual([10, 20, 30]);
    });

    it("should respect the count limit", async () => {
      const t = convexTest(schema, modules);
      // Add 5 numbers
      await t.mutation(api.myFunctions.addNumber, { value: 1 });
      await t.mutation(api.myFunctions.addNumber, { value: 2 });
      await t.mutation(api.myFunctions.addNumber, { value: 3 });
      await t.mutation(api.myFunctions.addNumber, { value: 4 });
      await t.mutation(api.myFunctions.addNumber, { value: 5 });

      // Query only 3 most recent
      const result = await t.query(api.myFunctions.listNumbers, { count: 3 });

      // Should return last 3 numbers (3, 4, 5)
      expect(result.numbers).toHaveLength(3);
      expect(result.numbers).toEqual([3, 4, 5]);
    });

    it("should handle count of 0", async () => {
      const t = convexTest(schema, modules);
      await t.mutation(api.myFunctions.addNumber, { value: 100 });

      const result = await t.query(api.myFunctions.listNumbers, { count: 0 });

      expect(result.numbers).toEqual([]);
    });
  });

  describe("myAction action", () => {
    it("should query numbers and add a new number", async () => {
      const t = convexTest(schema, modules);
      // Add initial numbers
      await t.mutation(api.myFunctions.addNumber, { value: 5 });
      await t.mutation(api.myFunctions.addNumber, { value: 10 });

      // Run the action
      await t.action(api.myFunctions.myAction, {
        first: 15,
        second: "test string",
      });

      // Verify the action added the new number
      const numbers = await t.run(async (ctx) => {
        return await ctx.db.query("numbers").collect();
      });

      expect(numbers).toHaveLength(3);
      expect(numbers.map((n) => n.value)).toEqual([5, 10, 15]);
    });

    it("should work with empty database", async () => {
      const t = convexTest(schema, modules);
      // Run action on empty database
      await t.action(api.myFunctions.myAction, {
        first: 99,
        second: "empty db test",
      });

      // Verify the number was added
      const numbers = await t.run(async (ctx) => {
        return await ctx.db.query("numbers").collect();
      });

      expect(numbers).toHaveLength(1);
      expect(numbers[0].value).toBe(99);
    });
  });

  describe("integration tests", () => {
    it("should handle a complete workflow", async () => {
      const t = convexTest(schema, modules);
      // Add some numbers
      await t.mutation(api.myFunctions.addNumber, { value: 1 });
      await t.mutation(api.myFunctions.addNumber, { value: 2 });
      await t.mutation(api.myFunctions.addNumber, { value: 3 });

      // Query them
      let result = await t.query(api.myFunctions.listNumbers, { count: 10 });
      expect(result.numbers).toEqual([1, 2, 3]);

      // Use action to add another
      await t.action(api.myFunctions.myAction, {
        first: 4,
        second: "integration test",
      });

      // Query again to verify
      result = await t.query(api.myFunctions.listNumbers, { count: 10 });
      expect(result.numbers).toEqual([1, 2, 3, 4]);
    });
  });
});
