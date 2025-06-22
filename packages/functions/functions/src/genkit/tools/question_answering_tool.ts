import { ai } from "../genkit.config";

export const questionAnsweringTool = ai.defineTool({
name: "questionAnsweringTool",
description: "This tool help you answer questions about Mooemart frequently asked questions.",

}, async (input) => {
    console.log(input);

});