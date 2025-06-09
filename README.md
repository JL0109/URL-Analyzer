# SMS URL Analyzer

A Streamlit-based tool for analyzing shortened URLs from SMS messages, resolving their destinations, and archiving them in the Wayback Machine. This application is particularly useful for investigating spam, scam, or marketing campaigns that use shortened URLs.

## Features

- **URL Resolution**: Follows redirect chains to find final destinations of shortened URLs
- **Wayback Machine Integration**: Automatically archives resolved URLs for preservation
- **Spreadsheet Processing**: Handles CSV and Excel files with bulk URL processing
- **Rate Limiting**: Configurable delays to respect service limits
- **Retry Mechanism**: Automatic retry for failed requests
- **Export Results**: Download processed data with all analysis results

## Supported URL Shorteners

- bit.ly, tinyurl.com
- t.co (Twitter/X)
- goo.gl, short.link
- ow.ly, buff.ly, adf.ly
- cutt.ly, rebrand.ly
- linktr.ee, tiny.cc, is.gd
- youtu.be, amzn.to, fb.me
- And many more!

## Installation & Setup

### Prerequisites

- Python 3.7 or higher
- Internet connection for URL resolution and archiving

### Quick Start (Windows)

1. **Download/Clone** this repository to your local machine
2. **Navigate** to the project folder in Command Prompt or PowerShell
3. **Run the setup script**:
   ```cmd
   setup_and_run.bat
   ```
4. **Open your browser** and go to: `http://localhost:8501`

### Manual Setup (All Platforms)

#### Windows
```cmd
# Create project directory
mkdir sms-url-analyzer
cd sms-url-analyzer

# Create virtual environment
python -m venv venv
venv\Scripts\activate

# Install dependencies
pip install streamlit>=1.45.1 pandas>=2.2.3 requests>=2.32.3 openpyxl>=3.1.5

# Create Streamlit config directory
mkdir .streamlit
```

#### macOS/Linux
```bash
# Create project directory
mkdir sms-url-analyzer
cd sms-url-analyzer

# Create virtual environment
python3 -m venv venv
source venv/bin/activate

# Install dependencies
pip install streamlit>=1.45.1 pandas>=2.2.3 requests>=2.32.3 openpyxl>=3.1.5

# Create Streamlit config directory
mkdir .streamlit
```

### Configuration File

Create `.streamlit/config.toml`:
```toml
[server]
headless = true
address = "localhost"
port = 8501

[theme]
base = "light"
```

### Required Files

Ensure these Python files are in your project directory:
- `app.py` - Main application interface
- `url_resolver.py` - URL resolution logic
- `wayback_archiver.py` - Wayback Machine integration
- `spreadsheet_processor.py` - File handling and processing

## Usage

### Starting the Application

#### Option 1: Using Setup Script (Windows)
```cmd
setup_and_run.bat
```

#### Option 2: Manual Start
```bash
# Activate virtual environment first
# Windows:
venv\Scripts\activate
# macOS/Linux:
source venv/bin/activate

# Run the application
streamlit run app.py
```

### Using the Interface

1. **Upload Spreadsheet**: 
   - Supported formats: CSV, Excel (.xlsx, .xls)
   - Must contain a column with shortened URLs

2. **Configure Settings** (Sidebar):
   - **URL Column Name**: Name of column containing URLs (default: "url")
   - **Delay Between Requests**: Rate limiting (0.1-5.0 seconds)
   - **Maximum Retries**: Retry attempts for failed requests (0-5)

3. **Process URLs**:
   - Click "Start Processing URLs" to begin analysis
   - Monitor progress with real-time metrics
   - View results as processing completes

4. **Download Results**:
   - Export processed spreadsheet with additional columns:
     - `resolved_url`: Final destination URL
     - `redirect_chain`: Complete redirect path
     - `wayback_url`: Wayback Machine archive link
     - `status`: Processing result (Success/Failed/Error)
     - `error_message`: Error details if applicable

### Input File Format

Your spreadsheet should contain a column with shortened URLs. Example:

| id | url | description |
|----|-----|-------------|
| 1 | https://bit.ly/example1 | Marketing link |
| 2 | https://tinyurl.com/test2 | Survey link |
| 3 | https://t.co/shortlink | Social media |

## Troubleshooting

### Common Issues

**Application won't start:**
- Ensure all Python files are in the project directory
- Check that virtual environment is activated
- Verify all dependencies are installed

**Can't access http://localhost:8501:**
- Try `http://127.0.0.1:8501` instead
- Check if port 8501 is available
- Restart the application

**URL resolution fails:**
- Check internet connection
- Some URLs may be blocked or expired
- Increase retry attempts in settings
- Reduce request frequency with higher delay

**Wayback Machine archiving slow:**
- This is normal - archiving can take 10-30 seconds per URL
- The service has rate limits that we respect
- Recent archives (within 24 hours) are reused when available

### Performance Tips

- **Large datasets**: Process in smaller batches (100-500 URLs)
- **Rate limiting**: Use 1-2 second delays for best results
- **Retries**: 2-3 retries handle most temporary failures
- **Monitoring**: Watch the progress metrics during processing

## Technical Details

### Dependencies

- **Streamlit**: Web application framework
- **Pandas**: Data manipulation and analysis
- **Requests**: HTTP library for URL resolution
- **OpenPyXL**: Excel file handling

### Architecture

- `app.py`: Main Streamlit interface and workflow orchestration
- `url_resolver.py`: Handles HTTP redirects and URL resolution
- `wayback_archiver.py`: Interfaces with Internet Archive's Wayback Machine
- `spreadsheet_processor.py`: File I/O and data processing utilities

### Rate Limiting

The application implements respectful rate limiting:
- Configurable delays between requests (default: 1 second)
- Retry mechanism with exponential backoff
- Checks for recent Wayback archives to avoid duplicate submissions

## License

This tool is intended for educational and research purposes. Please respect the terms of service of the URLs you analyze and the Wayback Machine service.

## Support

For issues or questions:
1. Check the troubleshooting section above
2. Verify all files are correctly placed
3. Ensure internet connectivity for external services
4. Check that all dependencies are properly installed

## Project Structure

```
sms-url-analyzer/
├── README.md
├── requirements.txt
├── setup_and_run.bat (Windows)
├── setup_and_run.sh (macOS/Linux)
├── .streamlit/
│   └── config.toml
├── app.py
├── url_resolver.py
├── wayback_archiver.py
└── spreadsheet_processor.py
```
