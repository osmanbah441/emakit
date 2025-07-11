import { z } from "genkit";
import { ai } from "../genkit.config";
import { ProductImageInputSchema, ProductExtractionListingSchema } from "../schemas/multimodal_input_schema";



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

