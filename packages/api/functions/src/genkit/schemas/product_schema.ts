import { z } from 'zod';
import { unifiedLLMResponseZodSchema } from "./utils";
import { ai } from '../genkit.config';

const ProductVariationSchema = z.object({
  variationId: z.string().describe("The unique identifier for the product variation."),
  price: z.number().describe("The price of the product variation."),
  availableStock: z.number().int().describe("The number of units available for this product variation."),
  attributes: z.object({}).passthrough().describe("A JSON data structure containing specific attributes for this product variation (e.g., color, size)."),
}).describe("Schema for a single product variation.");

const ProductSchema = z.object({
  productId: z.string().describe("The unique identifier of the product."),
  name: z.string().describe("The name of the product."),
  description: z.string().describe("A detailed description of the product."),
  specs: z.object({}).passthrough().describe("A JSON data structure containing key-value pairs for product specifications (e.g., material, dimensions)."),
  imageUrl: z.string().url().describe("The URL of the product's main image."),
  variations: z.array(ProductVariationSchema).describe("An array of available product variations."),
}).describe("Schema for a single product listing.");

export const SearchProductsInputSchema = ai.defineSchema(
  'SearchProductsInputSchema',
  z.object({
    text: z.string().optional().describe('Optional: The user\'s search query as text. This is used if no media is provided.'),
    media: z.object({
      url: z.string().describe('The URL of the media data (e.g., HTTP/S, GS, or Data URL). This is used for multimodal inputs like images or audio.'),
      mimeType: z.string().describe('The MIME type of the media data (e.g., "image/jpeg", "audio/mpeg"). Required if media URL is present.'),
    }).optional().describe('Optional: A media file URL and its MIME type for multimodal input.'),
  }).refine(data => data.text != null || data.media != null, {
    message: "Either 'text' or 'media' must be provided for a search query.",
    path: ["text", "media"],
  })
).describe("Input schema for the product search flow, supporting text or multimodal media.");

export const SearchProductsOutputSchema = ai.defineSchema(
  'SearchProductsOutputSchema',
  unifiedLLMResponseZodSchema(z.object({
    results: z.array(ProductSchema).describe("An array of products that confidently match the user's search query."),
  })).describe("Output schema for the product search flow, including status, message, and search results."),
).describe("Output schema for the product search flow.");

