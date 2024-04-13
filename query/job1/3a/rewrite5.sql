create or replace view aggView5895020478559797962 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin801566739020021986 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView5895020478559797962 where mi.movie_id=aggView5895020478559797962.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView2609393999143267550 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5298375632059180384 as select movie_id as v12 from movie_keyword as mk, aggView2609393999143267550 where mk.keyword_id=aggView2609393999143267550.v1;
create or replace view aggView1603588709573100579 as select v12 from aggJoin5298375632059180384 group by v12;
create or replace view aggJoin7952293256986137191 as select v24 as v24 from aggJoin801566739020021986 join aggView1603588709573100579 using(v12);
select MIN(v24) as v24 from aggJoin7952293256986137191;
