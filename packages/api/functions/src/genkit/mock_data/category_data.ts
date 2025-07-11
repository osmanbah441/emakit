const categoryList: any[] = [
  {
    name: "Electronics",
    description: "Devices and accessories characterized by their functional importance, technological nature, and electrical operation, providing solutions for communication, entertainment, productivity, and home utility.",
    id: "48a60d2689854c3a8ce16c3b7aa84176",
    imageUrl: "https://picsum.photos/seed/electronics/800/600",
    // Added for parent categories:
    parentCategoryId: null,
    specificationAttributes: null,
    variationAttributes: null
  },
  {
    description: "Handheld smart devices and portable computing tablets.",
    id: "2c68835f1007433189e5af19a170d6aa",
    imageUrl: "https://picsum.photos/seed/mobile-phones/800/600",
    name: "Mobile Phones & Tablets",
    parentCategoryId: "48a60d2689854c3a8ce16c3b7aa84176",
    specificationAttributes: [
      "Brand",
      "Model",
      "Operating System (OS)",
      "Screen Size",
      "Battery Capacity (mAh)",
      "RAM",
      "Camera Resolution (MP)",
      "SIM Slots",
      "Network Support (2G, 3G, 4G, 5G)"
    ],
    variationAttributes: {
      Color: [
        "Black",
        "White",
        "Blue",
        "Red",
        "Green",
        "Gold",
        "Silver"
      ],
      StorageCapacityGB: [
        "32",
        "64",
        "128",
        "256",
        "512",
        "1024"
      ]
    }
  },
  {
    description: "Portable and desktop computing devices, including accessories.",
    id: "0a2192d4af9e40a897484362b51c49bd",
    imageUrl: "https://picsum.photos/seed/laptops/800/600",
    name: "Laptops & Computers",
    parentCategoryId: "48a60d2689854c3a8ce16c3b7aa84176",
    specificationAttributes: [
      "Brand",
      "Model",
      "OS",
      "Screen Size",
      "Processor (e.g., Intel i5, AMD Ryzen)",
      "RAM (GB)",
      "Storage Type (SSD, HDD)",
      "Graphics Card",
      "Ports (USB, HDMI)"
    ],
    variationAttributes: {
      Color: [
        "Black",
        "Silver",
        "Grey",
        "White"
      ],
      RAMSize: [
        "4GB",
        "8GB",
        "16GB",
        "32GB"
      ],
      StorageCapacity: [
        "128GB SSD",
        "256GB SSD",
        "512GB SSD",
        "1TB SSD",
        "1TB HDD",
        "2TB HDD"
      ]
    }
  },
  {
    description: "Visual display units for entertainment and viewing.",
    id: "aafab93998c542c19556cd310d3660ff",
    imageUrl: "https://picsum.photos/seed/televisions/800/600",
    name: "Televisions & Displays",
    parentCategoryId: "48a60d2689854c3a8ce16c3b7aa84176",
    specificationAttributes: [
      "Brand",
      "Model",
      "Screen Size (inches)",
      "Display Type (LED, OLED)",
      "Resolution (HD, Full HD, 4K)",
      "Smart TV Features",
      "Connectivity (HDMI, USB, Wi-Fi)"
    ],
    variationAttributes: {
      ScreenSize: [
        "32 inches",
        "43 inches",
        "55 inches",
        "65 inches",
        "75 inches"
      ]
    }
  },
  {
    description: "Personal and home audio systems for sound reproduction.",
    id: "19545c76c6ba4a9c8eee4fec95daec84",
    imageUrl: "https://picsum.photos/seed/audio-devices/800/600",
    name: "Audio Devices",
    parentCategoryId: "48a60d2689854c3a8ce16c3b7aa84176",
    specificationAttributes: [
      "Brand",
      "Form Factor (Headphones, Earbuds, Speaker, Soundbar)",
      "Connectivity (Bluetooth, Wired)",
      "Noise Cancellation",
      "Microphone",
      "Power Output (Watts)",
      "Battery Life"
    ],
    variationAttributes: {
      Color: [
        "Black",
        "White",
        "Silver",
        "Red"
      ],
      PowerSource: [
        "Rechargeable Battery",
        "AC Powered",
        "USB"
      ]
    }
  },
  {
    description: "Devices for capturing images, videos, and aerial footage.",
    id: "0c25742bcd6d43e0a8388b12768e9f27",
    imageUrl: "https://picsum.photos/seed/cameras-drones/800/600",
    name: "Cameras & Drones",
    parentCategoryId: "48a60d2689854c3a8ce16c3b7aa84176",
    specificationAttributes: [
      "Brand",
      "Model",
      "Sensor Type",
      "Megapixels (MP)",
      "Optical Zoom",
      "Video Resolution",
      "Features (e.g., Image Stabilization, Panorama)"
    ],
    variationAttributes: {
      Color: [
        "Black",
        "Silver",
        "White"
      ],
      KitOptions: [
        "Body Only",
        "Kit Lens",
        "Dual Lens Kit"
      ]
    }
  },
  {
    description: "Smart devices worn on the body for health, fitness, and notifications.",
    id: "1d3075815048448d9d6d8bea4a5112ce",
    imageUrl: "https://picsum.photos/seed/wearables/800/600",
    name: "Wearable Technology",
    parentCategoryId: "48a60d2689854c3a8ce16c3b7aa84176",
    specificationAttributes: [
      "Device Type (Smartwatch, Fitness Tracker)",
      "Brand",
      "Screen Type",
      "Compatibility (Android, iOS)",
      "Battery Life",
      "Health Sensors (Heart Rate, SpO2)"
    ],
    variationAttributes: {
      Size: [
        "Small",
        "Medium",
        "Large"
      ],
      StrapColor: [
        "Black",
        "Blue",
        "Pink",
        "Green",
        "White"
      ]
    }
  },
  {
    description: "Compact electrical appliances for various household tasks.",
    id: "a696491d2c8142b88922acd1cf8ae4bc",
    imageUrl: "https://picsum.photos/seed/home-appliances/800/600",
    name: "Home & Kitchen Appliances",
    parentCategoryId: "48a60d2689854c3a8ce16c3b7aa84176",
    specificationAttributes: [
      "Type (Blender, Kettle, Fan, Iron, Toaster)",
      "Brand",
      "Power (Watts)",
      "Voltage",
      "Capacity",
      "Safety Features"
    ],
    variationAttributes: {
      Capacity: [
        "1.7L",
        "2L",
        "500ml",
        "1.5L"
      ],
      Color: [
        "Black",
        "White",
        "Silver",
        "Red"
      ]
    }
  },
  {
    description: "Complementary items for electronic devices.",
    id: "8f4ab648654f41c686986333adffe2f9",
    imageUrl: "https://picsum.photos/seed/electronics-accessories/800/600",
    name: "Electronics Accessories",
    parentCategoryId: "48a60d268986333adffe2f9",
    specificationAttributes: [
      "Accessory Type (Charger, Cable, Case, Power Bank, Adapter)",
      "Brand",
      "Compatibility",
      "Capacity"
    ],
    variationAttributes: {
      CableLength: [
        "1m",
        "2m",
        "0.5m"
      ],
      Color: [
        "Black",
        "White",
        "Grey"
      ],
      Size: [
        "Small",
        "Medium",
        "Large"
      ]
    }
  },
  {
    name: "Fashion",
    description: "Apparel, footwear, and accessories designed for personal adornment, style, and utility across all genders and age groups.",
    id: "2876895422d449c6bad53f57e82e7617",
    imageUrl: "https://picsum.photos/seed/fashion/800/600",
    // Added for parent categories:
    parentCategoryId: null,
    specificationAttributes: null,
    variationAttributes: null
  },
  {
    description: "Clothing specifically designed for women.",
    id: "b3c54a271e3d485aa25430abb437c835",
    imageUrl: "https://picsum.photos/seed/womens-apparel/800/600",
    name: "Women's Apparel",
    parentCategoryId: "2876895422d449c6bad53f57e82e7617",
    specificationAttributes: [
      "Apparel Type (e.g., Dress, Top, Skirt, Jeans)",
      "Fabric",
      "Fit",
      "Neckline",
      "Sleeve Length",
      "Brand"
    ],
    variationAttributes: {
      Color: [
        "Black",
        "White",
        "Blue",
        "Red",
        "Green",
        "Yellow",
        "Pink",
        "Purple",
        "Brown",
        "Grey"
      ],
      Pattern: [
        "Solid",
        "Striped",
        "Floral",
        "Geometric",
        "Polka Dot"
      ],
      Size: [
        "XS",
        "S",
        "M",
        "L",
        "XL",
        "XXL"
      ],
      Style: [
        "Casual",
        "Formal",
        "Sporty",
        "Boho",
        "Vintage"
      ]
    }
  },
  {
    description: "Clothing specifically designed for men.",
    id: "83a6fb22b66c4ca387ccfabf0547bd19",
    imageUrl: "https://picsum.photos/seed/mens-apparel/800/600",
    name: "Men's Apparel",
    parentCategoryId: "2876895422d449c6bad53f57e82e7617",
    specificationAttributes: [
      "Apparel Type (e.g., Shirt, Trousers, Jacket, Shorts)",
      "Fabric",
      "Fit Type",
      "Collar Type",
      "Brand"
    ],
    variationAttributes: {
      Color: [
        "Black",
        "White",
        "Blue",
        "Grey",
        "Navy",
        "Green",
        "Brown"
      ],
      Pattern: [
        "Solid",
        "Striped",
        "Checkered",
        "Geometric"
      ],
      Size: [
        "S",
        "M",
        "L",
        "XL",
        "XXL"
      ],
      Style: [
        "Casual",
        "Formal",
        "Sporty",
        "Business Casual"
      ]
    }
  },
  {
    description: "Clothing for infants, toddlers, and older children.",
    id: "d98eeb69abf84bbe9f04275b342c9645",
    imageUrl: "https://picsum.photos/seed/childrens-apparel/800/600",
    name: "Children's Apparel",
    parentCategoryId: "2876895422d449c6bad53f57e82e7617",
    specificationAttributes: [
      "Gender (Unisex, Boy, Girl)",
      "Age Group (e.g., 0-12 months, 2-4 years)",
      "Apparel Type",
      "Fabric",
      "Brand"
    ],
    variationAttributes: {
      Color: [
        "Blue",
        "Pink",
        "Yellow",
        "Green",
        "White",
        "Multi-color"
      ],
      Pattern: [
        "Cartoon",
        "Animal",
        "Striped",
        "Solid"
      ],
      SizeAge: [
        "0-3 Months",
        "3-6 Months",
        "6-12 Months",
        "1-2 Years",
        "2-3 Years",
        "4-5 Years",
        "6-8 Years",
        "9-12 Years"
      ]
    }
  },
  {
    description: "Items worn on the feet for protection and style.",
    id: "34e2e435dceb4dd59a4b9eb58d579d17",
    imageUrl: "https://picsum.photos/seed/footwear/800/600",
    name: "Footwear",
    parentCategoryId: "2876895422d449c6bad53f57e82e7617",
    specificationAttributes: [
      "Gender",
      "Footwear Type (e.g., Sneakers, Sandals, Boots, Heels)",
      "Material (e.g., Leather, Canvas, Synthetic)",
      "Closure Type (Lace-up, Slip-on)",
      "Brand"
    ],
    variationAttributes: {
      Color: [
        "Black",
        "White",
        "Brown",
        "Blue",
        "Red",
        "Grey"
      ],
      Size: [
        "EU 36",
        "EU 37",
        "EU 38",
        "EU 39",
        "EU 40",
        "EU 41",
        "EU 42",
        "EU 43",
        "EU 44",
        "EU 45"
      ],
      Width: [
        "Standard",
        "Wide"
      ]
    }
  },
  {
    description: "Items for carrying personal belongings or travel essentials.",
    id: "344de28019794ee09558ac3662efbfc1",
    imageUrl: "https://picsum.photos/seed/bags-luggage/800/600",
    name: "Bags & Luggage",
    parentCategoryId: "2876895422d449c6bad53f57e82e7617",
    specificationAttributes: [
      "Bag Type (e.g., Handbag, Backpack, Wallet, Travel Bag)",
      "Material",
      "Dimensions",
      "Brand"
    ],
    variationAttributes: {
      Capacity: [
        "Small",
        "Medium",
        "Large"
      ],
      Color: [
        "Black",
        "Brown",
        "Tan",
        "Blue",
        "Red",
        "Grey"
      ]
    }
  },
  {
    description: "Ornamental items and timepieces, primarily for aesthetic value.",
    id: "ba77d81c0b884e3797440461c2d20750",
    imageUrl: "https://picsum.photos/seed/jewelry-watches/800/600",
    name: "Jewelry & Watches",
    parentCategoryId: "2876895422d449c6bad53f57e82e7617",
    specificationAttributes: [
      "Item Type (e.g., Necklace, Ring, Earrings, Bracelet, Watch)",
      "Material (e.g., Gold, Silver, Beads, Leather)",
      "Style",
      "Brand"
    ],
    variationAttributes: {
      Color: [
        "Gold",
        "Silver",
        "Rose Gold",
        "Multi-color"
      ],
      Finish: [
        "Polished",
        "Matte",
        "Brushed"
      ],
      Size: [
        "Adjustable",
        "Small",
        "Medium",
        "Large"
      ]
    }
  },
  {
    description: "Complementary items to enhance an outfit or serve a supplementary purpose.",
    id: "a8c3d744d96349da95a52d8642754240",
    imageUrl: "https://picsum.photos/seed/fashion-accessories/800/600",
    name: "Fashion Accessories",
    parentCategoryId: "2876895422d449c6bad53f57e82e7617",
    specificationAttributes: [
      "Accessory Type (e.g., Belt, Scarf, Hat, Sunglasses)",
      "Material",
      "Dimensions",
      "Brand"
    ],
    variationAttributes: {
      Color: [
        "Black",
        "White",
        "Brown",
        "Blue",
        "Red",
        "Multi-color"
      ],
      Size: [
        "One Size",
        "S",
        "M",
        "L"
      ]
    }
  },
  {
    name: "Health & Beauty",
    description: "Products emphasizing personal care, wellness, hygiene, and aesthetic enhancement, with a strong focus on safety, formulation, and well-being.",
    id: "8c2907db994a4c25a28acca68741d18b",
    imageUrl: "https://picsum.photos/seed/health-beauty/800/600",
    // Added for parent categories:
    parentCategoryId: null,
    specificationAttributes: null,
    variationAttributes: null
  },
  {
    description: "Products formulated to cleanse, treat, protect, and enhance the health and appearance of facial and body skin.",
    id: "80e90208f5434f52aabddf4d20bc9971",
    imageUrl: "https://picsum.photos/seed/skincare/800/600",
    name: "Skincare",
    parentCategoryId: "8c2907db994a4c25a28acca68741d18b",
    specificationAttributes: [
      "Product Type (e.g., Cleanser, Moisturizer, Serum, Sunscreen, Mask)",
      "Skin Type (e.g., Oily, Dry, Sensitive)",
      "Key Ingredients",
      "Primary Concern (e.g., Anti-Aging, Acne)",
      "Brand"
    ],
    variationAttributes: {
      FragranceScent: [
        "Unscented",
        "Floral",
        "Fruity",
        "Fresh",
        "Musky"
      ],
      Size: [
        "30ml",
        "50ml",
        "100ml",
        "200ml"
      ]
    }
  },
  {
    description: "Products for cleansing, conditioning, styling, and treating hair and scalp.",
    id: "cfb72d48dd254021a38da0d4d96af9d8",
    imageUrl: "https://picsum.photos/seed/haircare/800/600",
    name: "Hair Care",
    parentCategoryId: "8c2907db994a4c25a28acca68741d18b",
    specificationAttributes: [
      "Product Type (e.g., Shampoo, Conditioner, Treatment, Styling Gel)",
      "Hair Type (e.g., Oily, Dry, Curly)",
      "Key Ingredients",
      "Brand"
    ],
    variationAttributes: {
      Scent: [
        "Floral",
        "Fruity",
        "Fresh",
        "Herbal"
      ],
      Size: [
        "150ml",
        "250ml",
        "500ml",
        "750ml"
      ]
    }
  },
  {
    description: "Decorative products for facial and body enhancement.",
    id: "197c5f9d9d1d46878cce973c980807c2",
    imageUrl: "https://picsum.photos/seed/makeup-cosmetics/800/600",
    name: "Makeup & Cosmetics",
    parentCategoryId: "8c2907db994a4c25a28acca68741d18b",
    specificationAttributes: [
      "Product Type (e.g., Foundation, Lipstick, Mascara, Eyeshadow)",
      "Skin Tone",
      "Finish (e.g., Matte, Radiant)",
      "Brand"
    ],
    variationAttributes: {
      ShadeColor: [
        "Fair",
        "Light",
        "Medium",
        "Deep",
        "Red",
        "Pink",
        "Nude"
      ],
      Size: [
        "Full Size",
        "Travel Size"
      ]
    }
  },
  {
    description: "Products for dental and mouth hygiene.",
    id: "9c00da41e425458e837520557bd714f9",
    imageUrl: "https://picsum.photos/seed/oral-care/800/600",
    name: "Oral Care",
    parentCategoryId: "8c2907db994a4c25a28acca68741d18b",
    specificationAttributes: [
      "Product Type (e.g., Toothpaste, Mouthwash, Toothbrush, Floss)",
      "Brand",
      "Benefit (e.g., Whitening, Sensitivity)",
      "Flavor",
      "Active Ingredient"
    ],
    variationAttributes: {
      BristleType: [
        "Soft",
        "Medium",
        "Hard"
      ],
      Size: [
        "50g",
        "100g",
        "200ml",
        "500ml"
      ]
    }
  },
  {
    description: "Everyday essentials for bodily cleanliness, freshness, and basic grooming.",
    id: "2c6bc153c98f49f9bf9cb2b26186d3b6",
    imageUrl: "https://picsum.photos/seed/personal-hygiene/800/600",
    name: "Personal Hygiene",
    parentCategoryId: "8c2907db994a4c25a28acca68741d18b",
    specificationAttributes: [
      "Product Type (e.g., Deodorant, Soap, Body Wash, Hand Sanitizer, Sanitary Pads, Razor, Wet Wipes)",
      "Brand",
      "Skin Sensitivity",
      "Application Area"
    ],
    variationAttributes: {
      PackCount: [
        "1",
        "3",
        "6",
        "12"
      ],
      Scent: [
        "Unscented",
        "Fresh",
        "Floral",
        "Sport"
      ],
      Size: [
        "50ml",
        "100ml",
        "250ml",
        "Bar"
      ]
    }
  },
  {
    description: "Scented products for personal use.",
    id: "78c82c174ca14542aed322831f502dc1",
    imageUrl: "https://picsum.photos/seed/fragrances/800/600",
    name: "Fragrances",
    parentCategoryId: "8c2907db994a4c25a28acca68741d18b",
    specificationAttributes: [
      "Type (e.g., Eau de Parfum, Eau de Toilette, Body Mist)",
      "Brand",
      "Scent Profile (e.g., Floral, Woody, Citrus, Spicy)"
    ],
    variationAttributes: {
      FragranceType: [
        "Day",
        "Night",
        "Unisex"
      ],
      Size: [
        "30ml",
        "50ml",
        "100ml"
      ]
    }
  },
  {
    name: "Groceries",
    description: "Consumable items, encompassing all food products, beverages, and essential household consumables, structured by dietary needs, preparation, and packaging.",
    id: "2be791932d354e51bfc9143b22e17d09",
    imageUrl: "https://picsum.photos/seed/groceries/800/600",
    // Added for parent categories:
    parentCategoryId: null,
    specificationAttributes: null,
    variationAttributes: null
  },
  {
    description: "Unprocessed fruits, vegetables, and herbs.",
    id: "61a0f144e7064590a303ad1c93809aea",
    imageUrl: "https://picsum.photos/seed/fresh-produce/800/600",
    name: "Fresh Produce",
    parentCategoryId: "2be791932d354e51bfc9143b22e17d09",
    specificationAttributes: [
      "Type (e.g., Apple, Tomato, Lettuce)",
      "Variety",
      "Farming Method",
      "Origin"
    ],
    variationAttributes: {
      PackSize: [
        "Single",
        "Bag",
        "Bunch"
      ],
      Weight: [
        "500g",
        "1kg",
        "2kg"
      ]
    }
  },
  {
    description: "Essential dry goods and non-perishable foods for everyday cooking and storage.",
    id: "463bf3ca17634c8f89a683f23ed83c2e",
    imageUrl: "https://picsum.photos/seed/pantry-staples/800/600",
    name: "Pantry Staples",
    parentCategoryId: "2be791932d354e51bfc9143b22e17d09",
    specificationAttributes: [
      "Product Type (e.g., Rice, Flour, Sugar, Pasta, Canned Beans)",
      "Brand",
      "Dietary Features (e.g., Gluten-Free, Organic, Vegan)",
      "Packaging Type"
    ],
    variationAttributes: {
      PackSize: [
        "Single",
        "Multipack"
      ],
      SizeWeight: [
        "500g",
        "1kg",
        "2kg",
        "5kg",
        "1L"
      ]
    }
  },
  {
    description: "Liquid consumables for drinking.",
    id: "d573b7cb60504995b7f934452c01a4b0",
    imageUrl: "https://picsum.photos/seed/beverages/800/600",
    name: "Beverages",
    parentCategoryId: "2be791932d354e51bfc9143b22e17d09",
    specificationAttributes: [
      "Type (e.g., Juice, Soda, Water, Tea, Coffee, Milk)",
      "Brand",
      "Dietary Feature (e.g., Sugar-Free, Caffeinated, Dairy-Free)"
    ],
    variationAttributes: {
      PackSize: [
        "Single",
        "6-Pack",
        "12-Pack"
      ],
      Volume: [
        "250ml",
        "500ml",
        "1L",
        "1.5L",
        "2L"
      ]
    }
  },
  {
    description: "Ready-to-eat light foods, chips, biscuits, chocolates, and sweets.",
    id: "fb6b6775b27f46a6b08cead5bac04521",
    imageUrl: "https://picsum.photos/seed/snacks-confectionery/800/600",
    name: "Snacks & Confectionery",
    parentCategoryId: "2be791932d354e51bfc9143b22e17d09",
    specificationAttributes: [
      "Type (e.g., Chips, Biscuits, Candy, Nuts)",
      "Flavor",
      "Allergen Information",
      "Brand"
    ],
    variationAttributes: {
      PackType: [
        "Single Bag",
        "Multipack",
        "Box"
      ],
      Size: [
        "Small",
        "Medium",
        "Large"
      ]
    }
  },
  {
    description: "Fresh or frozen animal protein products.",
    id: "db8f206245c342ee95acde8a889f8056",
    imageUrl: "https://picsum.photos/seed/meat-poultry-seafood/800/600",
    name: "Meat, Poultry & Seafood",
    parentCategoryId: "2be791932d354e51bfc9143b22e17d09",
    specificationAttributes: [
      "Type (e.g., Beef, Chicken, Fish, Pork)",
      "Cut",
      "Preparation (Fresh, Frozen, Smoked)",
      "Brand",
      "Origin"
    ],
    variationAttributes: {
      PackSize: [
        "Single Pack",
        "Family Pack"
      ],
      Weight: [
        "250g",
        "500g",
        "1kg"
      ]
    }
  },
  {
    description: "Milk, cheese, yogurt, and plant-based substitutes.",
    id: "575a6e4114ba46cbb8ce1e57a42fa8fe",
    imageUrl: "https://picsum.photos/seed/dairy-alternatives/800/600",
    name: "Dairy & Alternatives",
    parentCategoryId: "2be791932d354e51bfc9143b22e17d09",
    specificationAttributes: [
      "Product Type (e.g., Milk, Cheese, Yogurt, Soy Milk)",
      "Brand",
      "Fat Content",
      "Dietary Features (e.g., Lactose-Free, Vegan)"
    ],
    variationAttributes: {
      PackType: [
        "Single",
        "Multipack"
      ],
      Size: [
        "200ml",
        "500ml",
        "1L",
        "2L"
      ]
    }
  },
  {
    description: "Perishable items requiring freezing, or ready-to-eat meals.",
    id: "dc75c0348fe74ebd994932c559f4f541",
    imageUrl: "https://picsum.photos/seed/frozen-prepared-foods/800/600",
    name: "Frozen & Prepared Foods",
    parentCategoryId: "2be791932d354e51bfc9143b22e17d09",
    specificationAttributes: [
      "Type (e.g., Frozen Vegetables, Ice Cream, Ready Meals, Pizza)",
      "Brand",
      "Preservation Method",
      "Dietary Features"
    ],
    variationAttributes: {
      PackSize: [
        "Single",
        "Family Pack"
      ],
      Weight: [
        "300g",
        "500g",
        "1kg"
      ]
    }
  },
  {
    description: "Oils, spices, condiments, sauces, and baking essentials.",
    id: "f6d7f4f7bb3b4d17b529df70e4843eff",
    imageUrl: "https://picsum.photos/seed/baking-cooking-ingredients/800/600",
    name: "Baking & Cooking Ingredients",
    parentCategoryId: "2be791932d354e51bfc9143b22e17d09",
    specificationAttributes: [
      "Product Type (e.g., Cooking Oil, Salt, Ketchup, Baking Powder)",
      "Brand",
      "Flavor",
      "Certifications (e.g., Organic, Non-GMO)",
      "Package Type"
    ],
    variationAttributes: {
      PackageType: [
        "Bottle",
        "Jar",
        "Bag",
        "Box"
      ],
      Size: [
        "250g",
        "500g",
        "1kg",
        "500ml",
        "1L"
      ]
    }
  },
  {
    description: "Specialized food and formula for infants and toddlers.",
    id: "f50c70f52f5445f098c3eb63224a2240",
    imageUrl: "https://picsum.photos/seed/baby-food-formula/800/600",
    name: "Baby Food & Formula",
    parentCategoryId: "2be791932d354e51bfc9143b22e17d09",
    specificationAttributes: [
      "Product Type",
      "Age Range",
      "Ingredients",
      "Brand"
    ],
    variationAttributes: {
      Flavor: [
        "Apple",
        "Banana",
        "Rice",
        "Mixed Vegetables"
      ],
      PackType: [
        "Jar",
        "Pouch",
        "Can"
      ],
      Size: [
        "120g",
        "200g",
        "400g",
        "900g"
      ]
    }
  },
  {
    description: "Non-food items for cleaning, laundry, and general home maintenance.",
    id: "d76f442ad0cf42ed8b706a7531760a78",
    imageUrl: "https://picsum.photos/seed/household-essentials/800/600",
    name: "Household Essentials",
    parentCategoryId: "2be791932d354e51bfc9143b22e17d09",
    specificationAttributes: [
      "Product Type (e.g., Detergent, Cleaner, Toilet Paper, Tissues)",
      "Brand",
      "Application Area",
      "Scent"
    ],
    variationAttributes: {
      PackCount: [
        "1",
        "4",
        "6",
        "12"
      ],
      Scent: [
        "Lemon",
        "Floral",
        "Unscented",
        "Pine"
      ],
      Size: [
        "500ml",
        "1L",
        "2L",
        "Roll",
        "Box"
      ]
    }
  }
];


export function getParentCategories() {
  return categoryList.filter(category => category.parentCategoryId === null);
}


export function getSubcategories(parentCategoryId: string) {
  if (!parentCategoryId) {
    console.error("A parent category ID must be provided to get subcategories.");
    return [];
  }
  return categoryList.filter(category => category.parentCategoryId === parentCategoryId);
}