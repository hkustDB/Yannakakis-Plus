create or replace view aggView3351786648421144584 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin8606082919184687521 as select id as v12, title as v13, production_year as v16 from title as t, aggView3351786648421144584 where t.id=aggView3351786648421144584.v12 and production_year>2010;
create or replace view aggView8939077820854283740 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8083220894618594344 as select movie_id as v12 from movie_keyword as mk, aggView8939077820854283740 where mk.keyword_id=aggView8939077820854283740.v1;
create or replace view aggView2838588575582635886 as select v12, MIN(v13) as v24 from aggJoin8606082919184687521 group by v12;
create or replace view aggJoin470716599732359330 as select v24 from aggJoin8083220894618594344 join aggView2838588575582635886 using(v12);
select MIN(v24) as v24 from aggJoin470716599732359330;
