create or replace view aggJoin5997013492724949258 as (
with aggView7919062064757425593 as (select id as v18 from keyword as k where keyword IN ('nerd','loner','alienation','dignity'))
select movie_id as v36 from movie_keyword as mk, aggView7919062064757425593 where mk.keyword_id=aggView7919062064757425593.v18);
create or replace view aggJoin3748247028342093895 as (
with aggView5244860695136275666 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView5244860695136275666 where mi.info_type_id=aggView5244860695136275666.v16 and info LIKE 'USA:% 200%' and note LIKE '%internet%');
create or replace view aggJoin7838121934183144653 as (
with aggView4670292615472220864 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView4670292615472220864 where mc.company_type_id=aggView4670292615472220864.v14);
create or replace view aggJoin1874739425992789255 as (
with aggView8061874285208957933 as (select v36 from aggJoin5997013492724949258 group by v36)
select v36, v31, v32 from aggJoin3748247028342093895 join aggView8061874285208957933 using(v36));
create or replace view aggJoin9181998299818035446 as (
with aggView4156339857617382868 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView4156339857617382868 where cc.status_id=aggView4156339857617382868.v5);
create or replace view aggJoin6020689357771434680 as (
with aggView7864316516192738798 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin7838121934183144653 join aggView7864316516192738798 using(v7));
create or replace view aggJoin7502222339619882721 as (
with aggView7844725187750292344 as (select v36 from aggJoin6020689357771434680 group by v36)
select v36 from aggJoin9181998299818035446 join aggView7844725187750292344 using(v36));
create or replace view aggJoin7737990967703837666 as (
with aggView8940125317922565576 as (select v36 from aggJoin1874739425992789255 group by v36)
select v36 from aggJoin7502222339619882721 join aggView8940125317922565576 using(v36));
create or replace view aggJoin1714541169793665585 as (
with aggView8459892892172465041 as (select v36 from aggJoin7737990967703837666 group by v36)
select title as v37, kind_id as v21, production_year as v40 from title as t, aggView8459892892172465041 where t.id=aggView8459892892172465041.v36 and production_year>2000);
create or replace view aggView8679409939870185198 as select v37, v21 from aggJoin1714541169793665585 group by v37,v21;
create or replace view aggJoin48950400965040877 as (
with aggView7242742467012766064 as (select v21, MIN(v37) as v49 from aggView8679409939870185198 group by v21)
select kind as v22, v49 from kind_type as kt, aggView7242742467012766064 where kt.id=aggView7242742467012766064.v21 and kind= 'movie');
select MIN(v22) as v48,MIN(v49) as v49 from aggJoin48950400965040877;
