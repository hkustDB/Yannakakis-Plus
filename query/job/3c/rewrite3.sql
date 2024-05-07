create or replace view aggView3589812719090033659 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin299528523036875035 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView3589812719090033659 where mi.movie_id=aggView3589812719090033659.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView7138326965594883289 as select v12, MIN(v24) as v24 from aggJoin299528523036875035 group by v12;
create or replace view aggJoin5984570877333754369 as select keyword_id as v1, v24 from movie_keyword as mk, aggView7138326965594883289 where mk.movie_id=aggView7138326965594883289.v12;
create or replace view aggView852657670158783418 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4874470101821883059 as select v24 from aggJoin5984570877333754369 join aggView852657670158783418 using(v1);
select MIN(v24) as v24 from aggJoin4874470101821883059;
