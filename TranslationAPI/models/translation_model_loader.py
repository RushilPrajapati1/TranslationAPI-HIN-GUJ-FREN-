from transformers import pipeline

# Pre-load pipelines for multiple languages
translation_pipelines = {
    "en-hi": pipeline("translation_en_to_hi", model="Helsinki-NLP/opus-mt-en-hi"),
    "en-gu": pipeline("translation", model="Helsinki-NLP/opus-mt-en-mul"),
    "en-fr": pipeline("translation_en_to_fr", model="Helsinki-NLP/opus-mt-en-fr"),
}

def get_translation_pipeline(target_lang):
    lang_map = {
        "hindi": "en-hi",
        "gujarati": "en-gu",
        "french": "en-fr",
    }
    return translation_pipelines.get(lang_map.get(target_lang.lower()))
