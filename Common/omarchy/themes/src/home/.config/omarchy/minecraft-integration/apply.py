# Compatibility entry point; all theme integrations now share one implementation.
from pathlib import Path
import runpy
runpy.run_path(str(Path(__file__).resolve().parent.parent/'theme-integration/apply.py'),run_name='__main__')
