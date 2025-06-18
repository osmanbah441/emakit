import { ProductSearchResultsSchema } from "../schema/schema";
import {z} from 'genkit'
import { ai } from "../genkit.config";

export const productSearchTool = ai.defineTool(
  {
    name: 'productSearchTool',
    description: 'Searches the product catalog for items matching specific keywords. Returns a list of products.',
    inputSchema: z.object({
      keywords: z.string().describe('The keywords or terms to use for searching products (e.g., "gaming laptop", "wireless mouse").'),
    }),
    outputSchema: ProductSearchResultsSchema, // Expects an array of products
  },
  async (input) => {
 
    // Simulated product data for demonstration
    const mockProducts: z.infer<typeof ProductSearchResultsSchema> = [
      {
        id: 'P001',
        name: 'Super Gaming Laptop Xtreme',
        description: 'A high-performance gaming laptop with RTX 4080 and 32GB RAM.',
        specifications: { processor: 'Intel i9', gpu: 'RTX 4080', ram: '32GB', storage: '1TB SSD' },
        variations: [
          { id: 'V001-B', attributes: { color: 'Black', storage: '1TB' }, imageUrls: ['url_laptop_black_1', 'url_laptop_black_2'], price: 2199.99, stockQuantity: 5 },
          { id: 'V001-W', attributes: { color: 'White', storage: '1TB' }, imageUrls: ['url_laptop_white_1'], price: 2249.99, stockQuantity: 2 },
        ],
        mainCategory: 'Electronics',
        storeName: 'TechGadgets Pro'
      },
      {
        id: 'P002',
        name: 'Ergonomic Wireless Mouse Pro',
        description: 'Advanced wireless mouse designed for comfort and precision, with customizable buttons.',
        specifications: { connectivity: '2.4GHz Wireless', dpi_range: '800-16000', battery_life: '70 hours' },
        variations: [
          { id: 'V002-A', attributes: { color: 'Black' }, imageUrls: ['url_mouse_black'], price: 79.95, stockQuantity: 150 },
          { id: 'V002-B', attributes: { color: 'White' }, imageUrls: ['url_mouse_white'], price: 79.95, stockQuantity: 80 },
        ],
        mainCategory: 'Peripherals',
        storeName: 'Office Ergonomics'
      },
    ];

    const lowerKeywords = input.keywords.toLowerCase();
    const filteredProducts = mockProducts.filter(p =>
      p.name.toLowerCase().includes(lowerKeywords) ||
      p.description.toLowerCase().includes(lowerKeywords) ||
      p.mainCategory.toLowerCase().includes(lowerKeywords) ||
      Object.values(p.specifications).some(spec => String(spec).toLowerCase().includes(lowerKeywords))
    );

    // Simulate network or database query delay
    await new Promise(resolve => setTimeout(resolve, 300));

    return filteredProducts; // Returns the array of matching products
  }
);