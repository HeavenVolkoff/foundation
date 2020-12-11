{% set minor = cookiecutter.minimum_python_version.split('.')[1] | int -%}
{% if minor < 8 -%}
# External
from importlib_metadata import version
{% else -%}
# Internal
from importlib.metadata import version
{% endif -%}


try:
    __version__: str = version(__name__)
except Exception:  # pragma: no cover
    import traceback
    from warnings import warn

    warn(f"Failed to set version due to:\n{traceback.format_exc()}", ImportWarning)
    __version__ = "0.0a0"

__all__ = ("__version__",)
