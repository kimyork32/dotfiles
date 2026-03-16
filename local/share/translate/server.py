from fastapi import FastAPI
from pydantic import BaseModel
from transformers import AutoTokenizer, AutoModelForSeq2SeqLM
import uvicorn

app = FastAPI()

# ENGLISH -> SPANISH
MODEL_NAME = "Helsinki-NLP/opus-mt-en-es"
PORT = 55000

print(f"loading model {MODEL_NAME}...")
try:
    tokenizer = AutoTokenizer.from_pretrained(MODEL_NAME)
    model = AutoModelForSeq2SeqLM.from_pretrained(MODEL_NAME)
    print("model successfully loaded")
except Exception as e:
    print(f"error loading model: {e}")

class TranslationRequest(BaseModel):
    text: str

@app.post("/translate")
def translate(request: TranslationRequest):
    # tokenize
    inputs = tokenizer(request.text, return_tensors="pt", padding=True)
    # generate
    translated_tokens = model.generate(**inputs)
    # decode
    result_text = tokenizer.decode(translated_tokens[0], skip_special_tokens=True)
    return {
        "original": request.text,
        "translated": result_text
    }

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=PORT)
