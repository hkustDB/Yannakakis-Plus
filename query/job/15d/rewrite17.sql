create or replace view aggView4548634318802913821 as select movie_id as v40, title as v3 from aka_title as aka_t group by movie_id,title;
create or replace view aggJoin2932184558872597949 as (
with aggView5901096589414712334 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView5901096589414712334 where mc.company_id=aggView5901096589414712334.v13);
create or replace view aggJoin7140490618784449229 as (
with aggView2562223902571694459 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, note as v36 from movie_info as mi, aggView2562223902571694459 where mi.info_type_id=aggView2562223902571694459.v22 and note LIKE '%internet%');
create or replace view aggJoin683503071723945610 as (
with aggView9044103360384350977 as (select v40 from aggJoin7140490618784449229 group by v40)
select v40, v20 from aggJoin2932184558872597949 join aggView9044103360384350977 using(v40));
create or replace view aggJoin7774160837766879472 as (
with aggView4084198675504510691 as (select id as v20 from company_type as ct)
select v40 from aggJoin683503071723945610 join aggView4084198675504510691 using(v20));
create or replace view aggJoin4132502299906208126 as (
with aggView2183804574924090845 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView2183804574924090845 where mk.keyword_id=aggView2183804574924090845.v24);
create or replace view aggJoin4848274466032275052 as (
with aggView7096514901312373971 as (select v40 from aggJoin4132502299906208126 group by v40)
select v40 from aggJoin7774160837766879472 join aggView7096514901312373971 using(v40));
create or replace view aggJoin2217062338666962556 as (
with aggView7509673004057814571 as (select v40 from aggJoin4848274466032275052 group by v40)
select id as v40, title as v41, production_year as v44 from title as t, aggView7509673004057814571 where t.id=aggView7509673004057814571.v40 and production_year>1990);
create or replace view aggView1158944048636673109 as select v40, v41 from aggJoin2217062338666962556 group by v40,v41;
create or replace view aggJoin1860071154222294652 as (
with aggView4137105373017643687 as (select v40, MIN(v41) as v53 from aggView1158944048636673109 group by v40)
select v3, v53 from aggView4548634318802913821 join aggView4137105373017643687 using(v40));
select MIN(v3) as v52,MIN(v53) as v53 from aggJoin1860071154222294652;
