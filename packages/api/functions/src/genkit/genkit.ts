// The Firebase telemetry plugin exports a combination of metrics, traces, and logs to Google Cloud
// Observability. See https://firebase.google.com/docs/genkit/observability/telemetry-collection.
import {enableFirebaseTelemetry} from "@genkit-ai/firebase";
import { onCallGenkit } from "firebase-functions/https";
enableFirebaseTelemetry();


import { defineSecret } from "firebase-functions/params";
import { MultimodalProductSearchFlow } from "./flows/multimodal_product_search";
import { productImageUnderstandFlow } from "./flows/product_image_understanding_flow";
import { ProductExtractionListingFlow } from "./flows/product_extraction_listing_flow";

const apiKey = defineSecret("GOOGLE_GENAI_API_KEY");

export const ProductExtractionListing = onCallGenkit({
  secrets: [apiKey]
}, ProductExtractionListingFlow);


export const MultimodalProductSearch = onCallGenkit({
  secrets: [apiKey]
}, MultimodalProductSearchFlow);

export const productImageUnderstand = onCallGenkit({
  secrets: [apiKey],
}, productImageUnderstandFlow);
