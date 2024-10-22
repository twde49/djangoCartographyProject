import os
import sys

activate_this = "/app/.venv/bin/activate_this.py"
with open(activate_this) as file_:
    exec(file_.read(), dict(__file__=activate_this))

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "DjangoCartography.settings")

sys.path.append("/app/DjangoCartography")

from django.core.wsgi import get_wsgi_application

application = get_wsgi_application()
