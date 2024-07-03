create or replace view aggView6300046275855427433 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin653983324817010842 as select id as v12, title as v13, production_year as v16 from title as t, aggView6300046275855427433 where t.id=aggView6300046275855427433.v12 and production_year>1990;
create or replace view aggView6307951338842744095 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin7755581617601829021 as select movie_id as v12 from movie_keyword as mk, aggView6307951338842744095 where mk.keyword_id=aggView6307951338842744095.v1;
create or replace view aggView3384930955779855930 as select v12, MIN(v13) as v24 from aggJoin653983324817010842 group by v12;
create or replace view aggJoin1090890969851233742 as select v24 from aggJoin7755581617601829021 join aggView3384930955779855930 using(v12);
select MIN(v24) as v24 from aggJoin1090890969851233742;
