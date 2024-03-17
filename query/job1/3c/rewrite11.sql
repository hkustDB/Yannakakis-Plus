create or replace view aggView4132110603104874207 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin5166251435050777692 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView4132110603104874207 where mk.movie_id=aggView4132110603104874207.v12;
create or replace view aggView5540679031413452413 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin3910108958975045421 as select v1, v24 as v24 from aggJoin5166251435050777692 join aggView5540679031413452413 using(v12);
create or replace view aggView408369350225692745 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3851036366957902671 as select v24 from aggJoin3910108958975045421 join aggView408369350225692745 using(v1);
create or replace view res as select MIN(v24) as v24 from aggJoin3851036366957902671;
select sum(v24) from res;