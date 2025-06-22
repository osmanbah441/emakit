import { ai } from "../genkit.config";

export const semanticSearchTool = ai.defineTool({
name: "SemanticSearchTool",
description: "Semantic search tool find products",

}, async (input) => {
    console.log(input);
});