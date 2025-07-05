// The Firebase telemetry plugin exports a combination of metrics, traces, and logs to Google Cloud
// Observability. See https://firebase.google.com/docs/genkit/observability/telemetry-collection.
import {enableFirebaseTelemetry} from "@genkit-ai/firebase";
import { onCallGenkit } from "firebase-functions/https";
enableFirebaseTelemetry();


import { defineSecret } from "firebase-functions/params";
const apiKey = defineSecret("GOOGLE_GENAI_API_KEY");

import {productImageUnderstandFlow, productSearchFlow} from "./flows/flow";



export const productSearch = onCallGenkit({
  secrets: [apiKey]
}, productSearchFlow);


export const productImageUnderstand = onCallGenkit({

  secrets: [apiKey],
}, productImageUnderstandFlow);
