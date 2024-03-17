create or replace view aggView8579030019939925318 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8544204501620749387 as select movie_id as v12 from movie_keyword as mk, aggView8579030019939925318 where mk.keyword_id=aggView8579030019939925318.v1;
create or replace view aggView2453894466285661226 as select v12 from aggJoin8544204501620749387 group by v12;
create or replace view aggJoin5415687564096875817 as select id as v12, title as v13 from title as t, aggView2453894466285661226 where t.id=aggView2453894466285661226.v12 and production_year>1990;
create or replace view aggView2627555177771983493 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin6043611842276949719 as select v13 from aggJoin5415687564096875817 join aggView2627555177771983493 using(v12);
select MIN(v13) as v24 from aggJoin6043611842276949719;
