# Internal
import re

if (
    re.match(
        r"^([1-9][0-9]*!)?(0|[1-9][0-9]*)(\.(0|[1-9][0-9]*))*((a|b|rc)(0|[1-9][0-9]*))?(\.post(0|[1-9][0-9]*))?(\.dev(0|[1-9][0-9]*))?$",
        "{{ cookiecutter.minimum_python_version }}",
    )
    is None
):
    raise ValueError("Given minimum python version is not valid")
