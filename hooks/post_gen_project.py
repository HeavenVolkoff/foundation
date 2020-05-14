# Internal
from pathlib import Path

LICENSE_FILE = Path("./LICENSE")
if LICENSE_FILE.exists() and LICENSE_FILE.stat().st_size == 0:
    LICENSE_FILE.unlink()

PROJECT = Path("{{ cookiecutter.project_slug }}")
if not PROJECT.is_dir():
    raise FileNotFoundError(f"{PROJECT} directory doesn't exists")
NAMESPACE = Path(".", *"{{ cookiecutter.project_slug }}".split("."))
if NAMESPACE != PROJECT:
    NAMESPACE.mkdir(parents=True)
    PROJECT.rename(NAMESPACE)
