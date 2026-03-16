import sys
import requests
from PyQt6.QtWidgets import QApplication, QWidget, QVBoxLayout, QLabel, QFrame, QTextEdit
from PyQt6.QtGui import QClipboard
from PyQt6.QtCore import Qt, QEvent

COLOR_BG = "#000000"
COLOR_FG = "#afb1db"
COLOR_CRIT = "#e71c5b"
COLOR_BLACK = "#353c52"

class TranslatorPopup(QWidget):
    def __init__(self):
        super().__init__()
        self.init_ui()
        self.load_translation()

    def init_ui(self):
        self.setWindowFlags(Qt.WindowType.FramelessWindowHint | Qt.WindowType.Tool | Qt.WindowType.WindowStaysOnTopHint)
        self.setAttribute(Qt.WidgetAttribute.WA_TranslucentBackground)
        self.resize(500, 200)
        layout = QVBoxLayout()
        layout.setContentsMargins(0, 0, 0, 0)
        self.setLayout(layout)

        self.container = QFrame()
        self.container.setStyleSheet(f"""
            QFrame {{
                background-color: {COLOR_BG};
                border: 1px solid {COLOR_BLACK};
                border-radius: 0px;
                color: {COLOR_BLACK};
                font-family: "JetBrains Mono", "Fira Code", monospace;
            }}
        """)
        
        container_layout = QVBoxLayout()
        container_layout.setContentsMargins(15, 15, 15, 15)
        container_layout.setSpacing(8)
        self.container.setLayout(container_layout)
        layout.addWidget(self.container)

        self.lbl_source = QLabel("reading clipboard...")
        self.lbl_source.setStyleSheet(f"color: {COLOR_FG}; font-size: 12px; font-style: italic; border: none; background: transparent;")
        self.lbl_source.setWordWrap(True)
        self.lbl_source.setMaximumHeight(60) 
        container_layout.addWidget(self.lbl_source)

        line = QFrame()
        line.setFrameShape(QFrame.Shape.HLine)
        line.setStyleSheet(f"background-color: {COLOR_BLACK}; border: none; max-height: 1px; opacity: 0.2;")
        container_layout.addWidget(line)

        self.txt_target = QTextEdit()
        self.txt_target.setReadOnly(True)
        self.txt_target.setFrameStyle(QFrame.Shape.NoFrame)
        
        self.txt_target.setStyleSheet(f"""
            QTextEdit {{
                background-color: transparent;
                color: {COLOR_FG}; 
                font-size: 14px;
                font-weight: bold;
                border: none;
            }}
            QScrollBar:vertical {{
                border: none;
                background: {COLOR_BG};
                width: 4px;
                margin: 0px;
            }}
            QScrollBar::handle:vertical {{
                background: {COLOR_BLACK}; 
                min-height: 20px;
                border-radius: 0px; /* Scrollbar también cuadrada */
            }}
            QScrollBar::add-line:vertical, QScrollBar::sub-line:vertical {{
                height: 0px;
            }}
        """)
        container_layout.addWidget(self.txt_target)

        self.center_on_screen()

    def center_on_screen(self):
        screen = QApplication.primaryScreen().geometry()
        x = (screen.width() - self.width()) // 2
        y = (screen.height() - self.height()) // 2
        self.move(x, y)

    def load_translation(self):
        clipboard = QApplication.clipboard()
        text = clipboard.text(QClipboard.Mode.Selection)
        
        if not text:
            text = clipboard.text(QClipboard.Mode.Clipboard)

        if not text or not text.strip():
            self.lbl_source.setText("// nothing selected")
            self.txt_target.setText("select text first")
            return

        if len(text) > 105:
            display_text = f"{text[:50]}...{text[-50:]}"
        else:
            display_text = text
        display_text = display_text.replace('\n', ' ')

        self.lbl_source.setText(f"{display_text}")
        self.txt_target.setText("translating...")
        QApplication.processEvents()

        try:
            response = requests.post("http://localhost:55000/translate", json={"text": text}, timeout=10)
            if response.status_code == 200:
                translation = response.json().get("translated", "Error")
                self.txt_target.setText(translation)
                self.restore_style()
            else:
                self.txt_target.setText("api error")
                self.set_error_style()
        except Exception:
            self.txt_target.setText("server starting... try again in 3s")
            self.set_error_style()


    def set_error_style(self):
        self.txt_target.setStyleSheet(self.txt_target.styleSheet().replace(COLOR_FG, COLOR_CRIT))

    def restore_style(self):
        self.txt_target.setStyleSheet(self.txt_target.styleSheet().replace(COLOR_CRIT, COLOR_FG))

    def keyPressEvent(self, event):
        if event.key() == Qt.Key.Key_Escape or event.key() == Qt.Key.Key_Q:
            self.close()

    def focusOutEvent(self, event):
        self.close()

if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = TranslatorPopup()
    window.show()
    window.activateWindow()
    window.raise_()
    sys.exit(app.exec())
