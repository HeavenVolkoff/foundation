from pathlib import Path

LICENSE_FILE = Path("./LICENSE")
if LICENSE_FILE.exists() and LICENSE_FILE.stat().st_size == 0:
    LICENSE_FILE.unlink()

# TODO: Add support python namespace package creation