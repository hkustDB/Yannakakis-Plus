create or replace view aggView8352852504618556184 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4495677780045165679 as select movie_id as v12 from movie_keyword as mk, aggView8352852504618556184 where mk.keyword_id=aggView8352852504618556184.v1;
create or replace view aggView6926862540189279672 as select v12 from aggJoin4495677780045165679 group by v12;
create or replace view aggJoin6296058595583226347 as select movie_id as v12, info as v7 from movie_info as mi, aggView6926862540189279672 where mi.movie_id=aggView6926862540189279672.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView2547588276588674724 as select v12 from aggJoin6296058595583226347 group by v12;
create or replace view aggJoin4924474084716475154 as select title as v13, production_year as v16 from title as t, aggView2547588276588674724 where t.id=aggView2547588276588674724.v12 and production_year>2005;
create or replace view aggView7022967420400050558 as select v13 from aggJoin4924474084716475154;
select MIN(v13) as v24 from aggView7022967420400050558;
