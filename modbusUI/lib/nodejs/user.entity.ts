import { table } from 'console';
import { Entity, Column, PrimaryGeneratedColumn, Double, Int32 } from 'typeorm';

@Entity('tag_list')
export class User {
    
    @PrimaryGeneratedColumn()
    idx: number;

    @Column({type:'varchar'})
    설비:string;

    @Column({type:'varchar'})
    태그:string;

    @Column({type:'varchar'})
    addr:string;
    
    @Column({type:'varchar'})
    comment:string;

    @Column({type:'double'})
    value:Double;

    @Column({type:'datetime'})
    datatime:string;

    @Column({type:'double'})
    vmin:Double;

    @Column({type:'double'})
    vmax:Double;

    @Column({type:'double'})
    vsum:Double;

    @Column({type:'int'})
    vcnt:Int32;

    @Column({type:'double'})
    vavg:Double;

    @Column({type:'double'})
    scale:Double;

    @Column({type:'double'})
    offset:Double;

    @Column({type:'double'})
    alarm_hh:Double;

    @Column({type:'double'})
    alarm_h:Double;

    @Column({type:'double'})
    alarm_l:Double;

    @Column({type:'double'})
    alarm_ll:Double;

    @Column({type:'varchar'})
    alarm_result:string;

    @Column({type:'varchar'})
    설명:string;

    @Column({type:'varchar'})
    단위:string;

    @Column({type:'int'})
    UnitID:Int32;

    @Column({type:'varchar'})
    Host:string;

    @Column({type:'varchar'})
    Port:string;

    @Column({type:'varchar'})
    CommSetting:string;

    @Column({type:'int'})
    CommTimeOutSec:Int32;

    @Column({type:'varchar'})
    SaveMode:string;

    @Column({type:'int'})
    SaveInterval:Int32;

}
@Entity('raw')
export class raw {
    @PrimaryGeneratedColumn()
    idx: number;

    @Column({type:'varchar'})
    eq:string;

    @Column({type:'varchar'})
    tag:string;

    @Column({type:'datetime'})
    datatime:string;

    @Column({type:'double'})
    value:string;

    @Column({type:'varchar'})
    ext:string;

    @Column({type:'int'})
    kind:string;

}
