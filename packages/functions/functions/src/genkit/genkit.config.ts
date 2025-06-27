import {genkit} from "genkit";
import {googleAI} from "@genkit-ai/googleai";

// import { dataConnectTools } from "@genkit-ai/firebase/beta/data-connect";

// import { initializeApp } from "firebase/app";

// const firebaseConfig = {
//   // Your Firebase configuration object go to console.firebase.google.com and copy the config object
// };

// Initialize Firebase
// const app = initializeApp(firebaseConfig);

export const ai = genkit({

  // promptDir: './src/genkit/prompts',
  model: googleAI.model('gemini-2.5-flash'),
  plugins: [
    googleAI(),
    // dataConnectTools({
    //   name: 'dbTools',
    //   configFile: 'tools.json',
    //   firebaseApp: app,
    // })
  ],
});