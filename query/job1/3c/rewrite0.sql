create or replace view aggView5554117088518065641 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin2322598018896551045 as select movie_id as v12 from movie_keyword as mk, aggView5554117088518065641 where mk.keyword_id=aggView5554117088518065641.v1;
create or replace view aggView8205219144189960512 as select v12 from aggJoin2322598018896551045 group by v12;
create or replace view aggJoin4810950618828084148 as select movie_id as v12, info as v7 from movie_info as mi, aggView8205219144189960512 where mi.movie_id=aggView8205219144189960512.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView7193602326780616749 as select v12 from aggJoin4810950618828084148 group by v12;
create or replace view aggJoin4569955093851710330 as select title as v13, production_year as v16 from title as t, aggView7193602326780616749 where t.id=aggView7193602326780616749.v12 and production_year>1990;
create or replace view aggView3764341470392905900 as select v13 from aggJoin4569955093851710330 group by v13;
select min(v13) as v24 from aggView3764341470392905900;
