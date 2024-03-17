create or replace view aggView2791467305400619093 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin454996078750103598 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView2791467305400619093 where mi.movie_id=aggView2791467305400619093.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView8724689432507232930 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin761952883845761970 as select movie_id as v12 from movie_keyword as mk, aggView8724689432507232930 where mk.keyword_id=aggView8724689432507232930.v1;
create or replace view aggView4882435835402838134 as select v12 from aggJoin761952883845761970 group by v12;
create or replace view aggJoin7234011802107299536 as select v7, v24 as v24 from aggJoin454996078750103598 join aggView4882435835402838134 using(v12);
select MIN(v24) as v24 from aggJoin7234011802107299536;
