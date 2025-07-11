import { ai } from '../genkit.config';
import {SearchProductsQueryOutputSchema, SearchProductsQueryInputSchema} from "../schemas/product_schema"

const sampleProducts = [
  {
    productId: 'NKRS001',
    name: 'Nike Air Zoom Pegasus 40',
    description: 'Responsive cushioning for everyday runs. Men\'s.',
    specs: { brand: 'Nike', type: 'Running', gender: 'Men' },
    imageUrl: 'https://example.com/nike_pegasus.jpg',
    variations: [
      { variationId: 'V1-NKRS001', price: 120.00, availableStock: 50, attributes: { color: 'Black', size: '9' } },
      { variationId: 'V2-NKRS001', price: 120.00, availableStock: 75, attributes: { color: 'Black', size: '10' } },
      { variationId: 'V3-NKRS001', price: 120.00, availableStock: 30, attributes: { color: 'White', size: '10' } },
      { variationId: 'V4-NKRS001', price: 120.00, availableStock: 20, attributes: { color: 'Red', size: '11' } },
    ],
  },
  {
    productId: 'ADRS002',
    name: 'Adidas Ultraboost Light',
    description: 'Lightest Ultraboost ever. Unisex.',
    specs: { brand: 'Adidas', type: 'Running' },
    imageUrl: 'https://example.com/adidas_ultraboost.jpg',
    variations: [
      { variationId: 'V1-ADRS002', price: 180.00, availableStock: 40, attributes: { color: 'Black', size: '10' } },
      { variationId: 'V2-ADRS002', price: 180.00, availableStock: 60, attributes: { color: 'Blue', size: '9' } },
      { variationId: 'V3-ADRS002', price: 180.00, availableStock: 25, attributes: { color: 'White', size: '11' } },
    ],
  },
  {
    productId: 'NKBS003',
    name: 'Nike Blazer Mid \'77 Vintage',
    description: 'Classic basketball shoe. Unisex.',
    specs: { brand: 'Nike', type: 'Casual', style: 'High-top' },
    imageUrl: 'https://example.com/nike_blazer.jpg',
    variations: [
      { variationId: 'V1-NKBS003', price: 90.00, availableStock: 15, attributes: { color: 'Black', size: '9' } },
      { variationId: 'V2-NKBS003', price: 90.00, availableStock: 20, attributes: { color: 'White', size: '10' } },
      { variationId: 'V3-NKBS003', price: 90.00, availableStock: 10, attributes: { color: 'Red', size: '10' } },
    ],
  },
  {
    productId: 'IPHONE15PM',
    name: 'Apple iPhone 15 Pro Max',
    description: 'Latest flagship iPhone with advanced camera system.',
    specs: { brand: 'Apple', category: 'Smartphone', model: 'iPhone 15 Pro Max' },
    imageUrl: 'https://example.com/iphone15promax.jpg',
    variations: [
      { variationId: 'V1-IP15PM', price: 1199.00, availableStock: 100, attributes: { storage: '128GB', color: 'Black Titanium' } },
      { variationId: 'V2-IP15PM', price: 1299.00, availableStock: 80, attributes: { storage: '256GB', color: 'Black Titanium' } },
      { variationId: 'V3-IP15PM', price: 1499.00, availableStock: 50, attributes: { storage: '512GB', color: 'Natural Titanium' } },
    ],
  },
  {
    productId: 'GALAXYF5',
    name: 'Samsung Galaxy Z Fold5',
    description: 'Foldable smartphone for multitasking.',
    specs: { brand: 'Samsung', category: 'Smartphone', model: 'Galaxy Z Fold5' },
    imageUrl: 'https://example.com/galaxyfold5.jpg',
    variations: [
      { variationId: 'V1-GF5', price: 1799.00, availableStock: 30, attributes: { storage: '256GB', color: 'Phantom Black' } },
      { variationId: 'V2-GF5', price: 1919.00, availableStock: 20, attributes: { storage: '512GB', color: 'Cream' } },
    ],
  },
  {
    productId: 'GRNSWTR001',
    name: 'Merino Wool Sweater',
    description: 'Warm and soft casual sweater.',
    specs: { material: 'Merino Wool', category: 'Apparel' },
    imageUrl: 'https://example.com/merino_sweater.jpg',
    variations: [
      { variationId: 'V1-GRN001', price: 75.00, availableStock: 20, attributes: { color: 'Blue', size: 'S' } },
      { variationId: 'V2-GRN001', price: 75.00, availableStock: 25, attributes: { color: 'Red', size: 'M' } },
    ],
  },
  {
    productId: 'TSHIRT001',
    name: 'Soft Cotton Crewneck T-Shirt',
    description: 'Everyday comfortable tee.',
    specs: { material: 'Cotton', category: 'Apparel', type: 'T-Shirt' },
    imageUrl: 'https://example.com/cotton_tshirt.jpg',
    variations: [
      { variationId: 'V1-T001', price: 15.00, availableStock: 100, attributes: { color: 'Red', size: 'M' } },
      { variationId: 'V2-T001', price: 15.00, availableStock: 80, attributes: { color: 'Red', size: 'L' } },
      { variationId: 'V3-T001', price: 15.00, availableStock: 120, attributes: { color: 'Blue', size: 'M' } },
      { variationId: 'V4-T001', price: 15.00, availableStock: 90, attributes: { color: 'Green', size: 'L' } },
    ],
  },
];


export const SearchProductsTool = ai.defineTool(
  {
    name: 'SearchProductsTool',
    description: 'Searches the Mooemart product catalog for items matching the given query.',
    inputSchema: SearchProductsQueryInputSchema,
    outputSchema: SearchProductsQueryOutputSchema,
  },
  async (input) => {
    console.log(`Tool: SearchProductsTool called with query: "${input.query}"`);
    const lowerCaseQuery = input.query.toLowerCase();

    const results = sampleProducts.filter(product => {
      // Basic matching logic (could be improved with fuzzy matching, NLP, etc.)
      const productMatches = product.name.toLowerCase().includes(lowerCaseQuery) ||
                             product.description.toLowerCase().includes(lowerCaseQuery) ||
                             Object.values(product.specs).some(val => String(val).toLowerCase().includes(lowerCaseQuery));

      if (productMatches) return true;

      // Check if any variation attribute matches the query (now within the 'attributes' object)
      return product.variations.some(variation => {
        // Iterate over values in the 'attributes' object
        if (variation.attributes) { // Ensure attributes object exists
          return Object.values(variation.attributes).some(attrVal =>
            String(attrVal).toLowerCase().includes(lowerCaseQuery)
          );
        }
        return false;
      });
    });

    return results.slice(0, 20);
  }
);

