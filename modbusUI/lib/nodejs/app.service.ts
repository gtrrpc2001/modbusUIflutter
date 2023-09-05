import { Injectable,NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { MoreThanOrEqual, Repository,getRepository } from 'typeorm';
import { User,raw } from './user.entity';
import * as fs from 'fs';
import { groupBy } from 'rxjs';
import { argv } from 'process';



@Injectable()
export class AppService {  
  users: User[] = [];
  constructor(@InjectRepository(User) private userRepository: Repository<User>){}  
  
  async getUsers(user: User): Promise<User[]>{
    return await this.userRepository.find();
  }

  async getUser(tag: string): Promise<User>{
    console.log(tag);
    const user = await this.userRepository.find(
      {
       select:["설비", "태그", "addr","comment","value","datatime","vmin","vmax",
        "vsum","vcnt","vavg","scale","offset","alarm_hh","alarm_h","alarm_l",
      "alarm_ll","alarm_result","설명","단위","UnitID","Host","Port",
       "CommSetting","CommTimeOutSec","SaveMode","SaveInterval"],
       where: [{"태그": tag}]
      }
    )
    console.log(user.length);
      return user[0];
  }    

  async updateUser(tag: string, updateData: any){
    const user = this.getOne(tag);
    this.deleteUser(tag);
    this.users.push({...user,...updateData});
  }

  async getAll(): Promise<User[]> {
    //return await this.userRepository.find();
    const result = await this.userRepository.find();
    console.log(result);
    /*WriteToJson = JSON.stringify(result);*/
   // this.WriteJsonData(result);
    return result
  } 

  async  All(): Promise<User[]> {
    const result = await this.userRepository.find();   
    return result
  } 

  async getOne(tag: string) : Promise<User>{
    const getAll = await this.All();    
    const user = getAll.find(user => user.태그 == tag);
    console.log(user)
    if (!user) {
      throw new NotFoundException(`user tag ${tag} not found`);
    }
    return user;
  }

  create(userData: any){
    this.users.push({
      ...userData
    });
  }

  async deleteUser(tag: string): Promise<boolean>{    
    this.getOne(tag);
    this.users = this.users.filter(user => user.태그 !== tag)
    return true;
  }

  async searchOne(tag: string): Promise<User> {
    const userinfo = getRepository(User)
    .createQueryBuilder("tag")
    .where("태그 = :tag", {tag: tag})
    .getOne()
    return userinfo;
  }
  
  WriteJsonData(result: any){      
    /*const fs =  require('fs')*/
    const tag_listJson = JSON.stringify(result)
    console.log(fs)
    fs.writeFileSync('C:/flutterProject/modbusUI/assets/jsonFile/tag_list-json.json',tag_listJson);
    
  }

  

}
@Injectable()
export class RawService { 
  private raws: raw[] = [];
  constructor(@InjectRepository(raw) private rawRepository: Repository<raw>){}  

  async getRawAll(): Promise<raw[]> {
    //return await this.userRepository.find();
    const result = await this.rawRepository.find();
    console.log(result);
    /*WriteToJson = JSON.stringify(result);*/
   //this.WriteJsonData(result);
    return result;
  } 

  // async getOne(tag: string) : Promise<raw[]>{
  //     const today = new Date
  //       const year = today.getFullYear()
  //       const month = today.getMonth()
  //       const day = today.getDay()
  //       const time = today.getHours()
  //       const dday = year + "-" + month + "-" + day  
  //     const rawList = await this.rawRepository.find(
  //     {
  //      select:["idx","eq", "tag", "datatime","value","ext","kind"],
  //      where: [{"tag": tag},{"datatime": MoreThanOrEqual(dday)}],
  //      order:{idx: 'ASC'}
  //     }
  //   )
    
  //   console.log(time)
  //   this.WriteJsonData(rawList);
  //   /*var result : raw[] = await this.rawRepository.createQueryBuilder('raw')
  //   .select('idx,eq, tag, datatime,value,ext,kind,avg(VALUE) as avg_value')
  //   .where(['tag = :tag', {tag : tag},'datatime',{"datatime": MoreThanOrEqual(dday)}])
  //   .groupBy('DATE_FORMAT(datatime,'%H')')
  //   .getRawMany()*/
  //   return rawList;
  // }

  async getOne(tag: string) : Promise<raw[]>{
        const today = new Date
        const year = today.getFullYear()
        const month = today.getMonth() + 1
        var monthStr: string = month.toString()
        if (month < 10){
          monthStr = "0" + month.toString()
        }
        const date = today.getDate()        
        const datatime = year + "-" + monthStr + "-" + date 
        //console.log(datatime)
        const groupby = "DATE_FORMAT(datatime,'%H')"
    var result : raw[] = await this.rawRepository.createQueryBuilder('raw')
    .select('idx,eq, tag, datatime,value,ext,kind,avg(VALUE) as avg_value')
    .where({"tag": tag})
    .where({"datatime": MoreThanOrEqual(datatime)})
    .groupBy(groupby)
    .orderBy('idx',"ASC")
    .getRawMany()
    //console.log(result.length)
    return result;
  }
  

  WriteJsonData(result: any){      
    /*const fs =  require('fs')*/
    const tag_listJson = JSON.stringify(result)    
    fs.writeFileSync('C:/flutterProject/modbusUI/assets/jsonFile/raw-json.json',tag_listJson);
    
  }
}
