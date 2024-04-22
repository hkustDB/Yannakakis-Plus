create or replace view aggJoin6546912713535797545 as (
with aggView7326047373726114449 as (select id as v28, name as v51 from name as n where gender= 'm')
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView7326047373726114449 where ci.person_id=aggView7326047373726114449.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin8103213295575417543 as (
with aggView5883920647789615795 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView5883920647789615795 where mi.info_type_id=aggView5883920647789615795.v8 and info= 'Horror');
create or replace view aggJoin2630226823511023491 as (
with aggView7695421383089623387 as (select v37, MIN(v51) as v51 from aggJoin6546912713535797545 group by v37,v51)
select id as v37, title as v38, production_year as v41, v51 from title as t, aggView7695421383089623387 where t.id=aggView7695421383089623387.v37 and production_year>2010 and title LIKE 'Vampire%');
create or replace view aggJoin1810097571940099036 as (
with aggView9209942230645832070 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select movie_id as v37 from movie_keyword as mk, aggView9209942230645832070 where mk.keyword_id=aggView9209942230645832070.v12);
create or replace view aggJoin6344683702823269491 as (
with aggView2353271047834627252 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView2353271047834627252 where mi_idx.info_type_id=aggView2353271047834627252.v10);
create or replace view aggJoin231389235174868506 as (
with aggView3634384633844427610 as (select v37, MIN(v23) as v50 from aggJoin6344683702823269491 group by v37)
select v37, v38, v41, v51 as v51, v50 from aggJoin2630226823511023491 join aggView3634384633844427610 using(v37));
create or replace view aggJoin2460547741724211628 as (
with aggView4922519643625870632 as (select v37, MIN(v51) as v51, MIN(v50) as v50, MIN(v38) as v52 from aggJoin231389235174868506 group by v37,v50,v51)
select v37, v18, v51, v50, v52 from aggJoin8103213295575417543 join aggView4922519643625870632 using(v37));
create or replace view aggJoin1858711534036024715 as (
with aggView4620866008862209639 as (select v37, MIN(v51) as v51, MIN(v50) as v50, MIN(v52) as v52, MIN(v18) as v49 from aggJoin2460547741724211628 group by v37,v50,v52,v51)
select v51, v50, v52, v49 from aggJoin1810097571940099036 join aggView4620866008862209639 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin1858711534036024715;
