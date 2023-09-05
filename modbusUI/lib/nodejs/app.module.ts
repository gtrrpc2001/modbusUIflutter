import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User,raw } from './user.entity';
import { UsersModule } from './user.module';
import { AppController } from './app.controller';
import { AppService } from './app.service';

@Module({  
  imports:[         
    TypeOrmModule.forRoot({           
    type:'mysql',
    host:'dair.co.kr',
    port:3306,
    username:'dairadmin',
    password:'!eogksehrflqakstp!',
    database:'zt_ms',    
    entities:[User,raw],
    synchronize:false,   
    //autoLoadEntities: true
    //MysqlConnectionCredentialsOptions   
  }      
  )
  
  //TypeOrmModule.forFeature([User] )
  ,UsersModule
],
  controllers: [],
  providers: [],
})
export class AppModule {

}
