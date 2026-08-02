import os
import logging

from celery import Celery

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "gowobo_py.settings")

app = Celery("gowobo_py")
# Pull CELERY_* settings from Django settings.py (namespace="CELERY")
app.config_from_object("django.conf:settings", namespace="CELERY")
app.autodiscover_tasks()

# Let Django's logging configuration format and handle logs (send to stdout as JSON).
# Prevent Celery from hijacking the root logger and redirecting stdouts so we keep
# consistent structured logs in docker logs / kubectl logs.
app.conf.update(worker_hijack_root_logger=False, worker_redirect_stdouts=False)

logger = logging.getLogger(__name__)


@app.task(bind=True)
def debug_task(self):
    logger.debug("Debug task request: %r", self.request)
