import { describe, expect, it } from "vitest";

import { publicEnvironmentSchema } from "@/config/environment";

describe("environment validation", () => {
  it("accepts valid public Supabase configuration", () => {
    const result = publicEnvironmentSchema.safeParse({
      NEXT_PUBLIC_SUPABASE_URL: "https://example.supabase.co",
      NEXT_PUBLIC_SUPABASE_ANON_KEY: "anonymous-key",
    });

    expect(result.success).toBe(true);
  });

  it("rejects missing public Supabase configuration", () => {
    const result = publicEnvironmentSchema.safeParse({});

    expect(result.success).toBe(false);
  });
});
