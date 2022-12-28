# create working directory
FROM python:3.9-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# copy service package/directory into wrkdir and name it service.
COPY service/ ./service/

# create a non-root user
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia
EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]
