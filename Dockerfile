# Базовый образ (уже загружен, как требует методичка)
FROM python:3.12-slim

# Создаем непривилегированного пользователя
RUN useradd --system --no-create-home app

# Задаем рабочую директорию
WORKDIR /app

# Копируем зависимости и устанавливаем их
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Копируем код приложения
COPY app.py .

# Переключаемся на непривилегированного пользователя
USER app

# Открываем порт варианта
EXPOSE 8001

# Запускаем приложение в exec-форме на порту 8001
CMD ["gunicorn", "--bind", "0.0.0.0:8001", "--access-logfile", "-", "app:app"]