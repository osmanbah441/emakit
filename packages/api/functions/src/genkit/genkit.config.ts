import {genkit,} from "genkit";
import {googleAI} from "@genkit-ai/googleai";

import { dataConnectTools } from "@genkit-ai/firebase/beta/data-connect";
import { initializeApp } from "firebase/app";

const firebaseConfig = {
  // TODO: 
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);

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