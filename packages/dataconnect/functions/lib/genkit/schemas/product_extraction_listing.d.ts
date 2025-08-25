import { z } from "genkit";
export declare const ProductExtractionListingSchema: z.ZodObject<{
    status: z.ZodEnum<["success", "error"]>;
    message: z.ZodString;
    data: z.ZodOptional<z.ZodUnion<[z.ZodObject<{
        productName: z.ZodString;
        productDescription: z.ZodString;
        categorySpecificationFields: z.ZodRecord<z.ZodString, z.ZodString>;
        variationAttributes: z.ZodRecord<z.ZodString, z.ZodArray<z.ZodString, "many">>;
        selectedChildCategoryId: z.ZodString;
    }, "strip", z.ZodTypeAny, {
        productName: string;
        productDescription: string;
        categorySpecificationFields: Record<string, string>;
        variationAttributes: Record<string, string[]>;
        selectedChildCategoryId: string;
    }, {
        productName: string;
        productDescription: string;
        categorySpecificationFields: Record<string, string>;
        variationAttributes: Record<string, string[]>;
        selectedChildCategoryId: string;
    }>, z.ZodNull]>>;
}, "strip", z.ZodTypeAny, {
    message: string;
    status: "success" | "error";
    data?: {
        productName: string;
        productDescription: string;
        categorySpecificationFields: Record<string, string>;
        variationAttributes: Record<string, string[]>;
        selectedChildCategoryId: string;
    } | null | undefined;
}, {
    message: string;
    status: "success" | "error";
    data?: {
        productName: string;
        productDescription: string;
        categorySpecificationFields: Record<string, string>;
        variationAttributes: Record<string, string[]>;
        selectedChildCategoryId: string;
    } | null | undefined;
}>;
export declare const ProductImageInputSchema: z.ZodObject<{
    media: z.ZodObject<{
        url: z.ZodString;
        mimeType: z.ZodString;
    }, "strip", z.ZodTypeAny, {
        url: string;
        mimeType: string;
    }, {
        url: string;
        mimeType: string;
    }>;
}, "strip", z.ZodTypeAny, {
    media: {
        url: string;
        mimeType: string;
    };
}, {
    media: {
        url: string;
        mimeType: string;
    };
}>;
