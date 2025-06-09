@echo off
echo Setting up SMS URL Analyzer...

REM Create virtual environment if it doesn't exist
if not exist "venv" (
    echo Creating virtual environment...
    python -m venv venv
)

REM Activate virtual environment
echo Activating virtual environment...
call venv\Scripts\activate

REM Install dependencies
echo Installing dependencies...
pip install streamlit>=1.45.1 pandas>=2.2.3 requests>=2.32.3 openpyxl>=3.1.5

REM Create .streamlit directory if it doesn't exist
if not exist ".streamlit" (
    mkdir .streamlit
)

REM Create config file if it doesn't exist
if not exist ".streamlit\config.toml" (
    echo Creating Streamlit config...
    echo [server] > .streamlit\config.toml
    echo headless = true >> .streamlit\config.toml
    echo address = "0.0.0.0" >> .streamlit\config.toml
    echo port = 8501 >> .streamlit\config.toml
    echo. >> .streamlit\config.toml
    echo [theme] >> .streamlit\config.toml
    echo base = "light" >> .streamlit\config.toml
)

echo.
echo Setup complete! Starting the application...
echo The app will be available at: http://localhost:8501
echo Press Ctrl+C to stop the application
echo.

REM Run the application
streamlit run app.py

pause