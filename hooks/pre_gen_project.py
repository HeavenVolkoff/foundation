# Internal
import re

if (
    re.match(
        r"^3\.(0|[1-9][0-9]*)$",
        "{{ cookiecutter.minimum_python_version }}",
    )
    is None
):
    raise ValueError("Given minimum python version is not valid, must be >= 3.0")
