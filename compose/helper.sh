#!/bin/sh
sudo chown -R user:usergroup /pal/Package/Pal/Saved
exec /bin/sh /pal/Package/PalServer.sh "$@"
