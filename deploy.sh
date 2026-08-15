#!/usr/bin/env bash
#
# Deploy "Deep Dive — The Whales of the Ocean" to production.
#
#   ./deploy.sh            build and deploy
#   ./deploy.sh --dry-run  show exactly what would change, transfer nothing
#
# The site is a static Vite build: `npm run build` produces dist/, and dist/ is
# rsynced into the nginx document root on the server. Nothing runs server-side.
#
# Safety: every run first tars the current document root into BACKUP_DIR on the
# server, so a bad deploy can be rolled back (see "Rollback" at the bottom).

set -euo pipefail

# --- configuration ----------------------------------------------------------
SSH_HOST="root@46.36.216.4"
DOMAIN="whales-info.life"
REMOTE_ROOT="/var/www/whales_info__usr/data/www/${DOMAIN}"
REMOTE_OWNER="whales_info__usr:whales_info__usr"
BACKUP_DIR="/root/whales-backups"
# ----------------------------------------------------------------------------

# Derived locally so they expand before the remote shell sees them.
REMOTE_PARENT="$(dirname "$REMOTE_ROOT")"
REMOTE_BASE="$(basename "$REMOTE_ROOT")"
STAMP="$(date +%Y%m%d-%H%M%S)"

cd "$(dirname "$0")"

DRY_RUN=""
if [[ "${1:-}" == "--dry-run" ]]; then
  DRY_RUN="--dry-run"
  echo "▸ DRY RUN — no files will be changed"
fi

echo "▸ Building…"
npm run build

if [[ ! -f dist/index.html ]]; then
  echo "✗ Build produced no dist/index.html — aborting." >&2
  exit 1
fi

echo "▸ Checking connection to ${SSH_HOST}…"
ssh -o BatchMode=yes -o ConnectTimeout=10 "$SSH_HOST" "test -d '${REMOTE_ROOT}'" \
  || { echo "✗ Cannot reach ${SSH_HOST} or ${REMOTE_ROOT} is missing." >&2; exit 1; }

if [[ -z "$DRY_RUN" ]]; then
  echo "▸ Backing up the current document root…"
  ssh "$SSH_HOST" "
    set -e
    mkdir -p '${BACKUP_DIR}'
    tar -czf '${BACKUP_DIR}/${DOMAIN}-${STAMP}.tar.gz' \
        -C '${REMOTE_PARENT}' '${REMOTE_BASE}'
    # keep only the 10 most recent backups
    ls -1t '${BACKUP_DIR}'/${DOMAIN}-*.tar.gz | tail -n +11 | xargs -r rm --
  "
  echo "  backup: ${BACKUP_DIR}/${DOMAIN}-${STAMP}.tar.gz"
fi

echo "▸ Syncing dist/ → ${SSH_HOST}:${REMOTE_ROOT}…"
# --delete removes anything in the docroot that is not part of the build.
# Excludes protect files that live on the server but are not in the repo.
rsync -avz --checksum --delete $DRY_RUN \
  --exclude '.well-known/' \
  --exclude '.htaccess' \
  -e "ssh -o BatchMode=yes" \
  dist/ "${SSH_HOST}:${REMOTE_ROOT}/"

if [[ -z "$DRY_RUN" ]]; then
  echo "▸ Fixing ownership and permissions…"
  ssh "$SSH_HOST" "
    set -e
    chown -R ${REMOTE_OWNER} '${REMOTE_ROOT}'
    find '${REMOTE_ROOT}' -type d -exec chmod 755 {} +
    find '${REMOTE_ROOT}' -type f -exec chmod 644 {} +
    nginx -t && systemctl reload nginx
  "

  echo "▸ Verifying…"
  code=$(curl -s -o /dev/null -w '%{http_code}' "https://${DOMAIN}/")
  echo "  https://${DOMAIN}/ → HTTP ${code}"
  [[ "$code" == "200" ]] || { echo "✗ Site did not return 200." >&2; exit 1; }
fi

echo "✓ Done — https://${DOMAIN}/"
echo
echo "Rollback:  ssh ${SSH_HOST} \"ls -1t ${BACKUP_DIR}/*.tar.gz | head\""
echo "           ssh ${SSH_HOST} \"tar -xzf <backup>.tar.gz -C ${REMOTE_PARENT}\""
