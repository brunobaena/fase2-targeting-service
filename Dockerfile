FROM python:3.14.6-slim AS builder

RUN python3 -m venv /venv
ENV PATH=/venv/bin:$PATH

WORKDIR /app

COPY requirements.txt .

RUN pip install -r requirements.txt


FROM python:3.14.6-slim

COPY --from=builder /venv /venv
ENV PATH=/venv/bin:$PATH

WORKDIR /app

COPY app.py .

EXPOSE 8003

CMD ["gunicorn", "--bind", "0.0.0.0:8003", "app:app"]
