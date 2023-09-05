import { Module} from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User,raw } from './user.entity';
import { AppController,RawController } from './app.controller';
import { AppService,RawService } from './app.service';


@Module({

imports:[TypeOrmModule.forFeature([User,raw])],//TypeOrmModule.forFeature([User])
//exports:[TypeOrmModule],
controllers:[AppController,RawController],
providers:[AppService,RawService]

})
export class UsersModule {}