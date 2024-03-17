create or replace view aggView3608610170445506779 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin8181188312693259108 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView3608610170445506779 where mi.movie_id=aggView3608610170445506779.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView318133616532501615 as select v12, MIN(v24) as v24 from aggJoin8181188312693259108 group by v12;
create or replace view aggJoin2748241751214121038 as select keyword_id as v1, v24 from movie_keyword as mk, aggView318133616532501615 where mk.movie_id=aggView318133616532501615.v12;
create or replace view aggView5504063222509963504 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8664533874672704404 as select v24 from aggJoin2748241751214121038 join aggView5504063222509963504 using(v1);
select MIN(v24) as v24 from aggJoin8664533874672704404;
