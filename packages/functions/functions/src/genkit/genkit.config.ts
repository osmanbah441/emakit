import {genkit} from "genkit";
import {googleAI} from "@genkit-ai/googleai";

import {gemini20Flash} from "@genkit-ai/googleai";

export const ai = genkit({
    model: gemini20Flash,
  plugins: [
    // Load the Google AI plugin. You can optionally specify your API key
    // by passing in a config object; if you don't, the Google AI plugin uses
    // the value from the GOOGLE_GENAI_API_KEY environment variable, which is
    // the recommended practice.
    googleAI(),
  ],
});