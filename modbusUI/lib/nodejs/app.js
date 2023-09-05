import { AppController } from './app.controller';

const tag = require('tag')
const tag_list = AppController.getAll()
const tag_listJson = JSON.stringify(tag_list)
tag.writeFileSync('tag_list-json.json',tag_listJson)
