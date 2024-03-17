create or replace view aggView1114625064829106297 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1987286299693390234 as select movie_id as v12 from movie_keyword as mk, aggView1114625064829106297 where mk.keyword_id=aggView1114625064829106297.v1;
create or replace view aggView8454380922051604706 as select v12 from aggJoin1987286299693390234 group by v12;
create or replace view aggJoin7499986067134728029 as select id as v12, title as v13 from title as t, aggView8454380922051604706 where t.id=aggView8454380922051604706.v12 and production_year>2005;
create or replace view aggView5515805708429169390 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin2807749953842789107 as select v13 from aggJoin7499986067134728029 join aggView5515805708429169390 using(v12);
create or replace view res as select MIN(v13) as v24 from aggJoin2807749953842789107;
select sum(v24) from res;