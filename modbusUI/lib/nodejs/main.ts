import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ValidationPipe } from '@nestjs/common';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  
  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
      transform: true,
      forbidNonWhitelisted: true,
      transformOptions: {
        enableImplicitConversion: true
      }      
    }),
  );

  const config = new DocumentBuilder()
  .setTitle('example')
  .setDescription('API description')
  .setVersion('1.0')
  //.addTag('user')
  .build()

  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('api',app,document);
  app.enableCors(); /* 외부에서 연동하기 위해서 필요함 */
  await app.listen(3000);
}
bootstrap();
