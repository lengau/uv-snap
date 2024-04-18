#!/bin/bash
# Tests for the uv snap.

set -e -o pipefail

n_pkgs=16
# The snap's XDG_RUNTIME_DIR is normally on a tmpfs, so this makes it faster.
uv_tmpdir=$(echo 'echo $XDG_RUNTIME_DIR' | snap run --shell astral-uv.uv)

test_install(){
    cd $(mktemp --directory --tmpdir=$uv_tmpdir)
    astral-uv.uv venv
    echo -e "::group::\e[32mBASIC\e[0m: Install $@"
    astral-uv.uv pip install --strict $@
    echo -e "::endgroup::"_
    rm -rf $(pwd)
}

test_install cryptography pydantic numpy pendulum pillow pandas
test_install poetry hatch hatchling
test_install craft-cli craft-archives craft-application craft-grammar
test_install craft-application@git+https://github.com/canonical/craft-application.git
test_install bandit@git+https://github.com/PyCQA/bandit \
    flake8-bugbear@git+https://github.com/PyCQA/flake8-bugbear \
    flake8-polyfill@git+https://github.com/PyCQA/flake8-polyfill \
    flake8-json@git+https://github.com/PyCQA/flake8-json \
    flake8-docstrings@git+https://github.com/PyCQA/flake8-docstrings \
    flake8@git+https://github.com/PyCQA/flake8
snap install --classic node || true
test_install jupyterlab@git+https://github.com/jupyterlab/jupyterlab
test_install django django-allauth django-anymail django-appconf django-axes \
    django-celery-beat django-celery-results django-ckeditor django-compressor \
    django-cors-headers django-countries django-crispy-forms django-crontab \
    django-csp django-debug-toolbar django-environ django-extensions django-filter \
    django-formtools django-guardian django-health-check django-import-export \
    django-ipware django-js-asset django-model-utils django-mptt django-nose \
    django-oauth-toolkit django-otp django-phonenumber-field django-picklefield \
    django-polymorphic django-prometheus django-ratelimit django-redis \
    djangorestframework djangorestframework-jwt djangorestframework-simplejwt \
    djangorestframework-stubs django-rest-swagger django-reversion django-rq \
    django-ses django-silk django-storages django-stubs django-stubs-ext django-taggit \
    django-timezone-field django-treebeard django-waffle django-webpack-loader \
    django-widget-tweaks
test_install https://github.com/microsoft/Olive/releases/download/v0.5.2/olive_ai-0.5.2-py3-none-any.whl
test_install lisa@git+https://github.com/microsoft/lisa
test_install yt-dlp@https://github.com/yt-dlp/yt-dlp/archive/refs/tags/2024.04.09.zip
test_install flask@https://github.com/pallets/flask/archive/refs/tags/3.0.3.tar.gz
