import { z } from "genkit";
import { ai } from "../genkit.config";


// Define the comprehensive list of subcategories as a data source
const subcategoryDataSource = [
  // Subcategories for Electronics
  {
    id: "subcat-elec-mobile-tablets",
    description: "Handheld smart devices and portable computing tablets.",
    name: "Mobile Phones & Tablets",
    parentCategoryName: "Electronics",
    specificationAttributes: ["Brand", "Model", "Operating System (OS)", "Screen Size", "Battery Capacity (mAh)", "RAM", "Camera Resolution (MP)", "SIM Slots", "Network Support"],
    variationAttributes: ["Color", "Storage Capacity (GB)"]
  },
  {
    id: "subcat-elec-laptops-computers",
    description: "Personal computing devices, including laptops and desktop systems, crucial for education, business, and administrative tasks in offices and homes.",
    name: "Laptops & Computers",
    parentCategoryName: "Electronics",
    specificationAttributes: ["Brand", "Model", "OS", "Screen Size", "Processor", "RAM (GB)", "Storage Type (SSD, HDD)", "Graphics Card", "Ports"],
    variationAttributes: ["Color", "RAM Size", "Storage Capacity"]
  },
  {
    id: "subcat-elec-audio",
    description: "Sound equipment such as wireless earbuds (e.g., Oraimo FreePods), portable Bluetooth speakers (e.g., JBL), and home audio systems, widely used for music and entertainment.",
    name: "Audio Devices",
    parentCategoryName: "Electronics",
    specificationAttributes: ["Brand", "Form Factor", "Connectivity", "Noise Cancellation", "Microphone", "Power Output (Watts)", "Battery Life"],
    variationAttributes: ["Color", "Power Source"]
  },
  {
    id: "subcat-elec-tvs",
    description: "TV sets and related entertainment systems, including DVD players and decoders, central to family leisure time and news consumption.",
    name: "Televisions & Displays",
    parentCategoryName: "Electronics",
    specificationAttributes: ["Brand", "Model", "Screen Size (inches)", "Display Type", "Resolution", "Smart TV Features", "Connectivity"],
    variationAttributes: ["Screen Size"]
  },
  {
    id: "subcat-elec-cameras-drones",
    description: "Devices for capturing images, videos, and aerial footage.",
    name: "Cameras & Drones",
    parentCategoryName: "Electronics",
    specificationAttributes: ["Brand", "Model", "Sensor Type", "Megapixels (MP)", "Optical Zoom", "Video Resolution", "Features"],
    variationAttributes: ["Color", "Kit Options"]
  },
  {
    id: "subcat-elec-wearables",
    description: "Smart devices worn on the body for health, fitness, and notifications.",
    name: "Wearable Technology",
    parentCategoryName: "Electronics",
    specificationAttributes: ["Device Type", "Brand", "Screen Type", "Compatibility", "Battery Life", "Health Sensors"],
    variationAttributes: ["Strap Color", "Size"]
  },
  {
    id: "subcat-elec-home-kitchen",
    description: "Compact electrical appliances for various household tasks.",
    name: "Home & Kitchen Appliances",
    parentCategoryName: "Electronics",
    specificationAttributes: ["Type", "Brand", "Power (Watts)", "Voltage", "Capacity", "Safety Features"],
    variationAttributes: ["Color", "Capacity"]
  },
  {
    id: "subcat-elec-accessories",
    description: "Complementary items for electronic devices.",
    name: "Electronics Accessories",
    parentCategoryName: "Electronics",
    specificationAttributes: ["Accessory Type", "Brand", "Compatibility", "Capacity"],
    variationAttributes: ["Color", "Cable Length", "Size"]
  },

  // Subcategories for Fashion
  {
    id: "subcat-fashion-women-apparel",
    description: "Clothing specifically designed for women.",
    name: "Women's Apparel",
    parentCategoryName: "Fashion",
    specificationAttributes: ["Apparel Type", "Fabric", "Fit", "Neckline", "Sleeve Length", "Brand"],
    variationAttributes: ["Size", "Color", "Pattern", "Style"]
  },
  {
    id: "subcat-fashion-men-apparel",
    description: "Clothing specifically designed for men.",
    name: "Men's Apparel",
    parentCategoryName: "Fashion",
    specificationAttributes: ["Apparel Type", "Fabric", "Fit Type", "Collar Type", "Brand"],
    variationAttributes: ["Size", "Color", "Pattern", "Style"]
  },
  {
    id: "subcat-fashion-children-apparel",
    description: "Apparel designed for infants, toddlers, and older children, focusing on comfort and durability for active play in the local climate.",
    name: "Children's Apparel",
    parentCategoryName: "Fashion",
    specificationAttributes: ["Gender", "Age Group", "Apparel Type", "Fabric", "Brand"],
    variationAttributes: ["Size (Age)", "Color", "Pattern"]
  },
  {
    id: "subcat-fashion-footwear",
    description: "Items worn on the feet for protection and style.",
    name: "Footwear",
    parentCategoryName: "Fashion",
    specificationAttributes: ["Gender", "Footwear Type", "Material", "Closure Type", "Brand"],
    variationAttributes: ["Size", "Color", "Width"]
  },
  {
    id: "subcat-fashion-bags-luggage",
    description: "Items for carrying personal belongings or travel essentials.",
    name: "Bags & Luggage",
    parentCategoryName: "Fashion",
    specificationAttributes: ["Bag Type", "Material", "Dimensions", "Brand"],
    variationAttributes: ["Color", "Capacity"]
  },
  {
    id: "subcat-fashion-jewelry-watches",
    description: "Ornamental items and timepieces, primarily for aesthetic value.",
    name: "Jewelry & Watches",
    parentCategoryName: "Fashion",
    specificationAttributes: ["Item Type", "Material", "Style", "Brand"],
    variationAttributes: ["Size", "Color", "Finish"]
  },
  {
    id: "subcat-fashion-accessories",
    description: "Complementary items to enhance an outfit or serve a supplementary purpose.",
    name: "Fashion Accessories",
    parentCategoryName: "Fashion",
    specificationAttributes: ["Accessory Type", "Material", "Dimensions", "Brand"],
    variationAttributes: ["Color", "Size"]
  },

  // Subcategories for Health & Beauty
  {
    id: "subcat-hb-skincare",
    description: "Products formulated to cleanse, treat, protect, and enhance the health and appearance of facial and body skin.",
    name: "Skincare",
    parentCategoryName: "Health and Beauty",
    specificationAttributes: ["Product Type", "Skin Type", "Key Ingredients", "Primary Concern", "Brand"],
    variationAttributes: ["Size", "Fragrance/Scent"]
  },
  {
    id: "subcat-hb-haircare",
    description: "Shampoos, conditioners, hair oils, and relaxer kits (e.g., Dark & Lovely), catering to diverse hair types and styling preferences.",
    name: "Hair Care",
    parentCategoryName: "Health and Beauty",
    specificationAttributes: ["Product Type", "Hair Type", "Key Ingredients", "Brand"],
    variationAttributes: ["Size", "Scent"]
  },
  {
    id: "subcat-hb-makeup-cosmetics",
    description: "Products for enhancing beauty and personal grooming, including foundations, powders, lipsticks, and eye makeup.",
    name: "Makeup & Cosmetics",
    parentCategoryName: "Health and Beauty",
    specificationAttributes: ["Product Type", "Skin Tone", "Finish", "Brand"],
    variationAttributes: ["Shade/Color", "Size"]
  },
  {
    id: "subcat-hb-oralcare",
    description: "Products for dental and mouth hygiene.",
    name: "Oral Care",
    parentCategoryName: "Health and Beauty",
    specificationAttributes: ["Product Type", "Brand", "Benefit", "Flavor", "Active Ingredient"],
    variationAttributes: ["Size", "Bristle Type"]
  },
  {
    id: "subcat-hb-personalhygiene",
    description: "Everyday essentials for bodily cleanliness, freshness, and basic grooming.",
    name: "Personal Hygiene",
    parentCategoryName: "Health and Beauty",
    specificationAttributes: ["Product Type", "Brand", "Skin Sensitivity", "Application Area"],
    variationAttributes: ["Size", "Scent", "Pack Count"]
  },
  {
    id: "subcat-hb-fragrances",
    description: "Scented products for personal use.",
    name: "Fragrances",
    parentCategoryName: "Health and Beauty",
    specificationAttributes: ["Type", "Brand", "Scent Profile"],
    variationAttributes: ["Size", "Fragrance Type"]
  },

  // Subcategories for Groceries
  {
    id: "subcat-groc-freshproduce",
    description: "Unprocessed fruits, vegetables, and herbs.",
    name: "Fresh Produce",
    parentCategoryName: "Groceries",
    specificationAttributes: ["Type", "Variety", "Farming Method", "Origin"],
    variationAttributes: ["Weight", "Pack Size"]
  },
  {
    id: "subcat-groc-pantry-staples",
    description: "Essential dry goods and non-perishable foods for everyday cooking and storage.",
    name: "Pantry Staples",
    parentCategoryName: "Groceries",
    specificationAttributes: ["Product Type", "Brand", "Dietary Features", "Packaging Type"],
    variationAttributes: ["Size/Weight", "Pack Size"]
  },
  {
    id: "subcat-groc-beverages",
    description: "Liquid consumables for drinking.",
    name: "Beverages",
    parentCategoryName: "Groceries",
    specificationAttributes: ["Type", "Brand", "Dietary Feature"],
    variationAttributes: ["Volume", "Pack Size"]
  },
  {
    id: "subcat-groc-snacks-confectionery",
    description: "Ready-to-eat light foods, chips, biscuits, chocolates, and sweets.",
    name: "Snacks & Confectionery",
    parentCategoryName: "Groceries",
    specificationAttributes: ["Type", "Flavor", "Allergen Information", "Brand"],
    variationAttributes: ["Size", "Pack Type"]
  },
  {
    id: "subcat-groc-meat-poultry-seafood",
    description: "Fresh or frozen animal protein products.",
    name: "Meat, Poultry & Seafood",
    parentCategoryName: "Groceries",
    specificationAttributes: ["Type", "Cut", "Preparation", "Brand", "Origin"],
    variationAttributes: ["Weight", "Pack Size"]
  },
  {
    id: "subcat-groc-dairy-alternatives",
    description: "Milk, cheese, yogurt, and plant-based substitutes.",
    name: "Dairy & Alternatives",
    parentCategoryName: "Groceries",
    specificationAttributes: ["Product Type", "Brand", "Fat Content", "Dietary Features"],
    variationAttributes: ["Size", "Pack Type"]
  },
  {
    id: "subcat-groc-frozen-prepared-foods",
    description: "Perishable items requiring freezing, or ready-to-eat meals.",
    name: "Frozen & Prepared Foods",
    parentCategoryName: "Groceries",
    specificationAttributes: ["Type", "Brand", "Preservation Method", "Dietary Features"],
    variationAttributes: ["Weight", "Pack Size"]
  },
  {
    id: "subcat-groc-baking-cooking-ingredients",
    description: "Oils, spices, condiments, sauces, and baking essentials.",
    name: "Baking & Cooking Ingredients",
    parentCategoryName: "Groceries",
    specificationAttributes: ["Product Type", "Brand", "Flavor", "Certifications", "Package Type"],
    variationAttributes: ["Size", "Package Type"]
  },
  {
    id: "subcat-groc-baby-food-formula",
    description: "Specialized food and formula for infants and toddlers.",
    name: "Baby Food & Formula",
    parentCategoryName: "Groceries",
    specificationAttributes: ["Product Type", "Age Range", "Ingredients", "Brand"],
    variationAttributes: ["Size", "Pack Type", "Flavor"]
  },
  {
    id: "subcat-groc-household-essentials",
    description: "Non-food items for cleaning, laundry, and general home maintenance.",
    name: "Household Essentials",
    parentCategoryName: "Groceries",
    specificationAttributes: ["Product Type", "Brand", "Application Area", "Scent"],
    variationAttributes: ["Size", "Pack Count"]
  }
];


 const listSubcategoriesTool  = ai.defineTool({
    name: 'listSubcategories',
    description: 'Retrieves a list of all relevant subcategories and their required specification attributes for a given main product category.',
    inputSchema:  z.object({
      category: z.string().describe('The name of the main product category (e.g., "Electronics", "Fashion").')
    }),
    outputSchema: z.array(z.object({
      id: z.string().describe("The unique ID of the subcategory."),
      description: z.string().describe("A brief description of the subcategory."),
      name: z.string().describe("The name of the subcategory."),
      specificationAttributes: z.array(z.string()).describe("A list of required specification field names for this subcategory."),
    })).describe('A list of subcategory objects, each containing its ID, name, description, and required specification attributes.'),
  },
  async (input) => {

    const filteredSubcategories = subcategoryDataSource
      .filter(sub => sub.parentCategoryName.toLowerCase() === input.category.toLowerCase())
      .map(sub => ({
        id: sub.id,
        description: sub.description,
        name: sub.name,
        specificationAttributes: sub.specificationAttributes,
      }));

    if (filteredSubcategories.length > 0) {
      return filteredSubcategories;
    } else {
      return []; // Return an empty array if no subcategories match
    }
  }
);



const InputSchema = z.array(
  z.object({
    media: z.object({
      url: z.string().describe("URL of the image (HTTP/S, GS, or Data URL)."),
      mimeType: z.string().describe("MIME type of the image (e.g., 'image/jpeg', 'image/png')."),
    }).describe('Image definition with URL and MIME type')
  })
).describe('List of image definitions');



 const OutputSchema = z.object({
  productName: z.string().describe("The name of the product."),
  description: z.string().describe("A detailed description of the product."),
  category: z.string().describe("The specific subcategory return from the tools."),
  categoryId: z.string().describe("A unique identifier for the selected subcategory."),
  specifications: z.object({}).describe("An object containing dynamic key-value pairs representing product specifications. Keys are attribute names and values are their corresponding string representations.")
});

const systemPrompt: string = `
You are an intelligent AI assistant responsible for extracting comprehensive product details 
from images and structuring them into a strict JSON format for an e-commerce catalog. Follow the steps 
below meticulously. Do NOT skip any step. YOU MUST USE THE PROVIDED TOOLS EXACTLY AS INSTRUCTED.

---

### 🔍 Step 1: Analyze Product Visuals
Carefully examine the input image(s) to understand the product's type, use, and key features.

---

### 🗂️ Step 2: Determine Main Category
* Identify the correct **main category** for the product.
* Allowed values are ONLY: "Electronics", "Fashion", "Health and Beauty", "Groceries".
* If the product clearly does not fit into any of these categories, return:
\`\`\`json
{ "error": "Product category not supported. Allowed categories: Electronics, Fashion, Health and Beauty, Groceries." }
\`\`\`
* DO NOT proceed if this error is returned.

---

### 🛠️ Step 3: Fetch and Select Subcategory
* IMMEDIATELY call the \`listSubcategories\` tool using the \`mainCategory\` you selected.
* The tool will return an array of subcategory objects. Each includes:
  - \`id\`
  - \`name\`
  - \`description\`
  - \`specificationAttributes\` (an array of attribute names)
* Carefully read the \`name\` and \`description\` of each subcategory.
* SELECT the **single most relevant** subcategory for the product.

❗️**IMPORTANT**:
- You MUST NOT guess, make up, or hallucinate the subcategory \`id\` or \`name\`.
- You MUST extract both the \`category\` (name) and \`categoryId\` (id) DIRECTLY from the selected subcategory object returned by the tool.
- If the tool fails or no subcategories are returned, return:
\`\`\`json
{ "error": "Subcategory data unavailable or invalid for the selected main category." }
\`\`\`

---

### 🧠 Step 4: Extract Product Details
* \`productName\`: A clear, concise, and unique title for the product.
* \`description\`: An engaging and informative paragraph covering features, benefits, and typical use cases.

---

### 📦 Step 5: Populate Final Output JSON
You must return a valid JSON object with the following structure:

\`\`\`json
{
  "productName": "string",
  "description": "string",
  "mainCategory": "string",
  "category": "string",        // subcategory name from tool
  "categoryId": "string",      // subcategory id from tool
  "specifications": {
    "attributeName1": "value or 'UNKNOWN'",
    "attributeName2": "value or 'UNKNOWN'",
    ...
  }
}
\`\`\`

**Specifications**:
- Keys MUST match the exact \`specificationAttributes\` array from the selected subcategory (no more, no less).
- If an attribute cannot be determined from the image, set its value to \`"UNKNOWN"\`.
- DO NOT invent or guess new specification fields.

---

### ⚠️ Final Rules (MANDATORY)
- 🔧 Tool use is MANDATORY for subcategory selection.
- 🧾 category (name) and categoryId MUST be copied exactly from tool output.
- ❌ NEVER invent or assume specification attributes or category values.
- ✅ Return ONLY the final JSON. No extra explanation, text, or formatting.
`;


const userPrompt = `Please analyze the provided product image(s) and extract all necessary details to populate the product catalog. Format the output strictly as a JSON object.`

export const productImageUnderstandFlow = ai.defineFlow({
  name: "productImageUnderstand",
  inputSchema: InputSchema,
  outputSchema: OutputSchema,
},
async (input) => {
  const imagePrompts = input.map(item => ({
    media: item.media
  }));

  const prompts = [
    ...imagePrompts, 
    {
      text: userPrompt,
    },
  ];

  const llmResponse = await ai.generate({
    config: {
      temperature: 0.1,
    },
    output: {schema: OutputSchema},
    tools: [listSubcategoriesTool],
    system: systemPrompt,
    prompt: prompts,
    
  });

  return llmResponse.output as z.infer<typeof OutputSchema>;
});