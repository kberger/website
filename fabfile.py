from fabric.api import local,lcd,cd,put,sudo

DEP_DIR='/srv/website'

def build_website():
    local('yesod keter')

def deploy_website(build_directory, target_directory):
    with lcd(build_directory), cd(target_directory):
        put('dist/KarlPersonal/KarlPersonal')
        put('static')
        put('config')

def deploy_KarlPersonal():
    local('mkdir '+TMP_DIR)
    sudo('mkdir -p '+DEP_DIR)
    sudo('chown karl '+DEP_DIR)
    build_website(TMP_DIR)
    deploy_website(TMP_DIR+'/website', DEP_DIR)
    local('rm -r '+TMP_DIR)
