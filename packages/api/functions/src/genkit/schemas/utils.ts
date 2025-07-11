import { z } from "genkit";


export const unifiedLLMResponseZodSchema = <T extends z.ZodTypeAny>(schema: T) => {
  return z.object({
    status: z.enum(['success', 'error']).describe("Indicates if the category recommendation was successful or an error occurred."),
    message: z.string().describe("A human-readable message describing the outcome."),
    data: z.union([schema, z.null()]).optional(), 
  });
};

