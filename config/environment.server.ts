import "server-only";

import { z } from "zod";

export const serverEnvironmentSchema = z.object({
  SUPABASE_SERVICE_ROLE_KEY: z.string().min(1).optional(),
  AI_PROVIDER_API_KEY: z.string().min(1).optional(),
});

export type ServerEnvironment = z.infer<typeof serverEnvironmentSchema>;

export function getServerEnvironment(): ServerEnvironment {
  return serverEnvironmentSchema.parse({
    SUPABASE_SERVICE_ROLE_KEY: process.env.SUPABASE_SERVICE_ROLE_KEY,
    AI_PROVIDER_API_KEY: process.env.AI_PROVIDER_API_KEY,
  });
}
