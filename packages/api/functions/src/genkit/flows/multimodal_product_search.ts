import { z } from "genkit";
import { ai } from "../genkit.config";
import { SearchProductsInputSchema, SearchProductsOutputSchema } from "../schemas/product_schema";

export const MultimodalProductSearchFlow = ai.defineFlow({
  name: 'MultimodalProductSearchFlow',
  inputSchema: SearchProductsInputSchema,
  outputSchema: SearchProductsOutputSchema,
}, async (input) => {
  const categorize = ai.prompt<
    typeof SearchProductsInputSchema,
    typeof SearchProductsOutputSchema
  >('multimodal_product_search')
  const { output } = await categorize({ media: input.media, })
  return output as z.infer<typeof SearchProductsOutputSchema>
});

