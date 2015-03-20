from fabric.api import local,lcd,cd,put,sudo

DEP_DIR='/opt/keter/incoming'

def build_website():
    local('yesod keter')

def deploy_website():
    with cd('/opt/keter'):
        put('KarlPersonal.keter','incoming')

def deploy_KarlPersonal():
    build_website()
    deploy_website()
