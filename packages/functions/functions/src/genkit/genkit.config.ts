import {genkit} from "genkit";
import {googleAI} from "@genkit-ai/googleai";

import {gemini20Flash} from "@genkit-ai/googleai";

export const ai = genkit({
  model: gemini20Flash,
  promptDir: './src/genkit/prompts',
  plugins: [
    googleAI(),
  ],
});