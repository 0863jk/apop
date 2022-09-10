use pms;
set global max_connections=500;
desc user;

create table entrancerequest (
 projectid int,
 userid varchar(225),
 state varchar(225),
 foreign key (projectid)
 REFERENCES project(projectid),
 foreign key (userid)
 REFERENCES user(id)
 );
 
 CREATE TABLE `history` (
  `historyId` int PRIMARY KEY AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `id` varchar(255) NOT NULL,
  `pid` int NOT NULL,
  `tid` int default 0,
  `date` date
);
 
 alter table task add column approve int not null default 0;
 
 select * from project where classification = '미분류' and projectName like '%%';
 
 drop table entrancerequest;
 insert into projectmember values('test', 1, 0);
 select * from projectmember;
 select * from entrancerequest order by state desc; 
 update entrancerequest set state = 'requested' where userid = 'rakan';
 insert into entrancerequest(projectid, userid) values(5, 'test');
 insert into entrancerequest values(5, 'test', 'requested');
 select * from entrancerequest = er, user = u where er.userid = u.id and er.projectid=2 and er.state='requested';