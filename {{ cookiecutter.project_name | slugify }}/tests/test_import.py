# Internal
import unittest

class TestImport(unittest.TestCase):
    def test_import(self) -> None:
        import {{ cookiecutter.project_slug }}

if __name__ == "__main__":
    unittest.main()