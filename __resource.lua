fx_version 'cerulean'
author 'marcinhu#0001'
Description 'HouseRobbery'
game 'gta5'

shared_scripts { 
    "configs/**.lua",
}

server_script { 
    "server/**.lua",
}

client_script {
    "client/**.lua",
}

escrow_ignore {
    "configs/**.lua",
    "README.lua",
}

lua54 'yes'