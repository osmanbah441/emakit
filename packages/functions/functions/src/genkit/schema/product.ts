import { z } from "genkit";


export const ProductVariationSchema = z.object({
  id: z.string().describe('Unique identifier for the product variation.'),
  attributes: z.record(z.string(), z.any()).describe('A map of attribute names to their values (e.g., color: "red", size: "M").'),
  imageUrls: z.array(z.string().url()).describe('List of image URLs for this specific variation.'),
  price: z.number().positive().describe('The price of this product variation.'),
  stockQuantity: z.number().int().min(0).describe('The current stock quantity for this variation.'),
});


export const ProductSchema = z.object({
  id: z.string().describe('Unique identifier for the product.'),
  name: z.string().min(1).describe('The name of the product.'),
  description: z.string().describe('A detailed description of the product.'),
  specifications: z.record(z.string(), z.any()).describe('A map of product specifications (e.g., "weight": "1kg", "material": "plastic").'),
  variations: z.array(ProductVariationSchema).describe('A list of available variations for this product.'),
  mainCategory: z.string().describe('The primary category the product belongs to (e.g., "Electronics", "Clothing").'),
  storeName: z.string().default('').describe('Optional: The name of the store selling the product.'),
});

export const ProductSearchResultsSchema = z.array(ProductSchema).describe('An array of found products matching the search criteria.');