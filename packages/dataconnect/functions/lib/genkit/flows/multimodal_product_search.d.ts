import { z } from "genkit";
export declare const MultimodalProductSearchFlow: import("genkit").Action<z.ZodEffects<z.ZodObject<{
    text: z.ZodOptional<z.ZodString>;
    media: z.ZodOptional<z.ZodObject<{
        url: z.ZodString;
        mimeType: z.ZodString;
    }, "strip", z.ZodTypeAny, {
        url: string;
        mimeType: string;
    }, {
        url: string;
        mimeType: string;
    }>>;
}, "strip", z.ZodTypeAny, {
    text?: string | undefined;
    media?: {
        url: string;
        mimeType: string;
    } | undefined;
}, {
    text?: string | undefined;
    media?: {
        url: string;
        mimeType: string;
    } | undefined;
}>, {
    text?: string | undefined;
    media?: {
        url: string;
        mimeType: string;
    } | undefined;
}, {
    text?: string | undefined;
    media?: {
        url: string;
        mimeType: string;
    } | undefined;
}>, z.ZodObject<{
    status: z.ZodEnum<["success", "error"]>;
    message: z.ZodString;
    data: z.ZodOptional<z.ZodUnion<[z.ZodObject<{
        results: z.ZodArray<z.ZodObject<{
            productId: z.ZodString;
            name: z.ZodString;
            description: z.ZodString;
            specs: z.ZodObject<{}, "passthrough", z.ZodTypeAny, z.objectOutputType<{}, z.ZodTypeAny, "passthrough">, z.objectInputType<{}, z.ZodTypeAny, "passthrough">>;
            imageUrl: z.ZodString;
            variations: z.ZodArray<z.ZodObject<{
                variationId: z.ZodString;
                price: z.ZodNumber;
                availableStock: z.ZodNumber;
                attributes: z.ZodObject<{}, "passthrough", z.ZodTypeAny, z.objectOutputType<{}, z.ZodTypeAny, "passthrough">, z.objectInputType<{}, z.ZodTypeAny, "passthrough">>;
            }, "strip", z.ZodTypeAny, {
                variationId: string;
                price: number;
                availableStock: number;
                attributes: {} & {
                    [k: string]: unknown;
                };
            }, {
                variationId: string;
                price: number;
                availableStock: number;
                attributes: {} & {
                    [k: string]: unknown;
                };
            }>, "many">;
        }, "strip", z.ZodTypeAny, {
            productId: string;
            name: string;
            description: string;
            specs: {} & {
                [k: string]: unknown;
            };
            imageUrl: string;
            variations: {
                variationId: string;
                price: number;
                availableStock: number;
                attributes: {} & {
                    [k: string]: unknown;
                };
            }[];
        }, {
            productId: string;
            name: string;
            description: string;
            specs: {} & {
                [k: string]: unknown;
            };
            imageUrl: string;
            variations: {
                variationId: string;
                price: number;
                availableStock: number;
                attributes: {} & {
                    [k: string]: unknown;
                };
            }[];
        }>, "many">;
    }, "strip", z.ZodTypeAny, {
        results: {
            productId: string;
            name: string;
            description: string;
            specs: {} & {
                [k: string]: unknown;
            };
            imageUrl: string;
            variations: {
                variationId: string;
                price: number;
                availableStock: number;
                attributes: {} & {
                    [k: string]: unknown;
                };
            }[];
        }[];
    }, {
        results: {
            productId: string;
            name: string;
            description: string;
            specs: {} & {
                [k: string]: unknown;
            };
            imageUrl: string;
            variations: {
                variationId: string;
                price: number;
                availableStock: number;
                attributes: {} & {
                    [k: string]: unknown;
                };
            }[];
        }[];
    }>, z.ZodNull]>>;
}, "strip", z.ZodTypeAny, {
    message: string;
    status: "success" | "error";
    data?: {
        results: {
            productId: string;
            name: string;
            description: string;
            specs: {} & {
                [k: string]: unknown;
            };
            imageUrl: string;
            variations: {
                variationId: string;
                price: number;
                availableStock: number;
                attributes: {} & {
                    [k: string]: unknown;
                };
            }[];
        }[];
    } | null | undefined;
}, {
    message: string;
    status: "success" | "error";
    data?: {
        results: {
            productId: string;
            name: string;
            description: string;
            specs: {} & {
                [k: string]: unknown;
            };
            imageUrl: string;
            variations: {
                variationId: string;
                price: number;
                availableStock: number;
                attributes: {} & {
                    [k: string]: unknown;
                };
            }[];
        }[];
    } | null | undefined;
}>, z.ZodTypeAny>;
