import { z } from "genkit";
import { ai } from "../genkit.config";

const inputSchema = z.array(
  z.object({
    media: z.object({
      url: z.string().describe("URL of the image (HTTP/S, GS, or Data URL)."),
      mimeType: z.string().describe("MIME type of the image (e.g., 'image/jpeg', 'image/png')."),
    }).describe('Image definition with URL and MIME type')
  })
).describe('List of image definitions');

export const productImageUnderstandFlow = ai.defineFlow({
  name: "productImageUnderstand",
  inputSchema: inputSchema,
  outputSchema: z.string().describe('The natural language response to the user\'s query (product differences).'),
},
async (input) => {
  const imagePrompts = input.map(item => ({
    media: item.media
  }));

  const prompts = [
    ...imagePrompts, 
    {
      text: "What are the differences between these images? Provide a detailed comparison."
    },
  ];

  const llmResponse = await ai.generate({
    prompt: prompts,
  });

  return llmResponse.text;
});