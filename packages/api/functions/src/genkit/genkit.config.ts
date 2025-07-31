import { genkit, } from "genkit";
import { googleAI } from "@genkit-ai/googleai";

import { dataConnectTools } from "@genkit-ai/firebase/beta/data-connect";
import { app } from "../firebase_config.js";

export const ai = genkit({
  promptDir: './src/genkit/prompts',
  model: googleAI.model('gemini-2.5-flash'),
  plugins: [
    googleAI(),
    dataConnectTools({
      firebaseApp: app,
      name: 'dbTools',
      configFile: 'tools.json',
    })
  ],
});