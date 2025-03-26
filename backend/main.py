import os
from fastapi import FastAPI
from supabase import create_client, Client

app = FastAPI()

SUPABASE_URL = "https://alkwerscybtruiqkstus.supabase.co"
SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFsa3dlcnNjeWJ0cnVpcWtzdHVzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDE0NDM1NTksImV4cCI6MjA1NzAxOTU1OX0.754bIGxpqHI9k3QFWWSlXAIGLi9SVDcJePEqZT5Rnu8"

supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)

@app.get("/")
def read_root():
    return {"message": "FastAPI + Supabase is connected!"}
