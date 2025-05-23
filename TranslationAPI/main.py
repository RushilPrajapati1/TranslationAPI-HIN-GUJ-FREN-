from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from models.translation_model_loader import get_translation_pipeline

app = FastAPI()


class TranslationRequest(BaseModel):
    text: str
    target_lang: str


@app.post("/translate")
def translate(request: TranslationRequest):
    pipeline = get_translation_pipeline(request.target_lang)
    if not pipeline:
        raise HTTPException(status_code=400, detail="Unsupported target language.")

    result = pipeline(request.text)
    return {"translated_text": result[0]['translation_text']}
