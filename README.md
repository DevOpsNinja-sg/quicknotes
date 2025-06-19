# QuickNotes

QuickNotes is a simple and efficient note-taking application designed to help you capture ideas, tasks, and reminders quickly.

## Features

- Create, edit, and delete notes
- Organize notes by categories or tags
- Responsive and user-friendly interface

## Installation

You can run QuickNotes either locally with Python or using Docker.

### Option 1: Local Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/DevOpsNinja-sg/quicknotes
    ```
2. Navigate to the project directory:
    ```bash
    cd quicknotes
    ```
3. Install the required dependencies:
    ```bash
    pip install -r requirements.txt
    ```
4. Start the application:
    ```bash
    python app.py
    ```

### Option 2: Using Docker

1. Build the Docker image:
    ```bash
    docker build -t quicknotes .
    ```
2. Run the Docker container:
    ```bash
    docker run -p 8000:8000 quicknotes
    ```

## Usage

- Add new notes using the "Add Note" button.
- Edit or delete notes as needed.
- Use the search bar to quickly find notes.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.

## License

This project is licensed under the MIT License.