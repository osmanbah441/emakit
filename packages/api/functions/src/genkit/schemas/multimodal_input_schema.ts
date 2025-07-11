import { z } from "genkit";
import { ai } from "../genkit.config";
import { unifiedLLMResponseZodSchema } from "./utils";


export const ProductExtractionListingSchema = ai.defineSchema(
  'ProductExtractionListingSchema',
  unifiedLLMResponseZodSchema(z.object({
    productName: z.string().describe("The generated name for the product."),
    productDescription: z.string().describe("A detailed description of the product."),
    categorySpecificationFields: z.record(z.string()).describe("An object containing category-specific fields and their inferred values. Fields that cannot be inferred from the image should be an empty string."),
    variationAttributes: z.record(z.array(z.string())).describe("An object where keys are variation attribute names (e.g., 'color', 'size') and values are arrays of possible attribute values. This should be returned as is."),
    selectedChildCategoryId: z.string().describe("The unique identifier of the selected child category for the product."),
  }))
);


export const ProductImageInputSchema = ai.defineSchema(
  'ProductImageInputSchema',
   z.object({
  media: z.object({
    url: z.string().describe("URL of the image (HTTP/S, GS, or Data URL)."),
    mimeType: z.string().describe("MIME type of the image (e.g., 'image/jpeg', 'image/png')."),
  }).describe('Image definition with URL and MIME type')
})
);

