import { z } from 'zod';


const ProductVariationSchema = z.object({
  variationId: z.string().describe("product variation id"),
  price: z.number().describe("product price"),
  availableStock: z.number().int().describe("product available stock"),
  attributes: z.object({}).describe("product attributes json data structure "),
});

export const ProductSchema = z.object({
  productId: z.string(),
  name: z.string(),
  description: z.string(),
  specs: z.object({}).describe("product specs json data structure "),
  imageUrl: z.string(),
  variations: z.array(ProductVariationSchema).describe("product variations array"),
});

export const SearchProductsInputSchema = z.object({
  text: z.string().optional().describe('Optional: User query as text (used if media not provided).'),
  media: z.object({
    url: z.string().describe('Base64 encoded media data this can be audio or image data.'),
    mimeType: z.string().describe('MIME type of the media data (e.g., "media/mpeg", "media/wav"). Required if base64Encoded is present.'),
  }).optional().describe('base64 encode media file and it mime type')
});

export const SearchProductsOutputSchema = z.object({
  status: z.string().describe("status of product form search"),
  message: z.string().describe("message of product form search"),
  results: z.array(ProductSchema).describe("result of product form search")
});

// For the tools
export const SearchProductsQueryInputSchema = z.object({
  query: z.string().describe('A precise search query for products, e.g., "red t-shirt size large"'),
});

export const SearchProductsQueryOutputSchema = z.array(ProductSchema).max(20);
