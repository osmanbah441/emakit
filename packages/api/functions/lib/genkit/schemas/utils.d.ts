import { z } from "genkit";
export declare const unifiedLLMResponseZodSchema: <T extends z.ZodTypeAny>(schema: T) => z.ZodObject<{
    status: z.ZodEnum<["success", "error"]>;
    message: z.ZodString;
    data: z.ZodOptional<z.ZodUnion<[T, z.ZodNull]>>;
}, "strip", z.ZodTypeAny, z.objectUtil.addQuestionMarks<z.baseObjectOutputType<{
    status: z.ZodEnum<["success", "error"]>;
    message: z.ZodString;
    data: z.ZodOptional<z.ZodUnion<[T, z.ZodNull]>>;
}>, any> extends infer T_1 ? { [k in keyof T_1]: z.objectUtil.addQuestionMarks<z.baseObjectOutputType<{
    status: z.ZodEnum<["success", "error"]>;
    message: z.ZodString;
    data: z.ZodOptional<z.ZodUnion<[T, z.ZodNull]>>;
}>, any>[k]; } : never, z.baseObjectInputType<{
    status: z.ZodEnum<["success", "error"]>;
    message: z.ZodString;
    data: z.ZodOptional<z.ZodUnion<[T, z.ZodNull]>>;
}> extends infer T_2 ? { [k_1 in keyof T_2]: z.baseObjectInputType<{
    status: z.ZodEnum<["success", "error"]>;
    message: z.ZodString;
    data: z.ZodOptional<z.ZodUnion<[T, z.ZodNull]>>;
}>[k_1]; } : never>;
