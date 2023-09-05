import { Body,Controller,Delete, Get,Param,Patch, Post,Query ,Logger} from '@nestjs/common';
import { AppService,RawService } from './app.service';
import {User,raw} from './user.entity';
import { group } from 'console';
import { groupBy } from 'rxjs';
import { ApiTags } from '@nestjs/swagger';

@Controller('users')
@ApiTags('User')
export class AppController {
  constructor(private readonly appService: AppService) {}
  private readonly logger = new Logger(AppController.name);

  @Get("/user")
  getUsers(@Body("user") user: User): Promise<User[]>{
    return this.appService.getUsers(user);
  }

  @Get("/userOne")
  getUser(@Body("tag") tag: string){
    return this.appService.getUser(tag);
  }

  @Get("/")
  getAll(): Promise<User[]>{
    //this.logger.warn("log---log");    
    return this.appService.getAll();
  }

  @Get("/one")
  getOne(@Query("태그") userTag: string) : Promise<User>{
    return this.appService.getOne(userTag);
  }

  @Delete("/del")
  remove(@Body("user") userTag: string){
    return this.appService.deleteUser(userTag);
  }

  @Post("/create")
  create(@Body() userData: any){
    return this.appService.create(userData);
  }

  @Patch("/update")
  patch(@Param("tag") userTag: string, @Body() updateData: any){
    return this.appService.updateUser(userTag,updateData);
  }  

   @Get("/search")
   search(@Query('태그') tag: string): Promise<User> {
    return this.appService.searchOne(tag);
   }
}


@Controller('raws')
@ApiTags('Raw')
export class RawController {
  constructor(private readonly rawService: RawService) {}
  private readonly logger = new Logger(AppController.name);

  @Get("/")
  getRawAll(): Promise<raw[]>{
      return this.rawService.getRawAll();
  }

  @Get("/One")
  getRawOne(@Query('tag') tag: string): Promise<raw[]>{  
    return this.rawService.getOne(tag);
  }

  // @Get("/Test")
  // getRawTest(@Query('tag') tag: string): Promise<raw[]>{  
  //   return this.rawService.getTest(tag);
  // }
}
