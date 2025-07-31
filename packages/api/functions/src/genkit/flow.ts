import { z } from "genkit";
import { ai } from "./genkit.config.js";
import { ProductExtractionListingSchema, ProductImageInputSchema, SearchProductsInputSchema, SearchProductsOutputSchema } from "./schema.js";

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


export const ProductExtractionListingFlow = ai.defineFlow({
    name: 'ProductExtractionListingFlow',
    inputSchema: ProductImageInputSchema,
    outputSchema: ProductExtractionListingSchema,
}, async (input) => {
    const categorize = ai.prompt<
        typeof ProductImageInputSchema,
        typeof ProductExtractionListingSchema
    >('product_image_categorization')
    const { output } = await categorize({ media: input.media, })
    return output as z.infer<typeof ProductExtractionListingSchema>
});

