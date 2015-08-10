from fabric.api import local,lcd,cd,put,sudo

DEP_DIR='/opt/keter/incoming'

def build():
    local('stack exec -- yesod keter')

def deploy():
    with cd('/opt/keter'):
        put('KarlPersonal.keter','incoming')

def refresh_KarlPersonal():
    build()
    deploy()
