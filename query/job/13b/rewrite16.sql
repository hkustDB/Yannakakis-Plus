create or replace view aggJoin3341385703485365106 as (
with aggView2325188351514166917 as (select id as v1, name as v43 from company_name as cn where country_code= '[us]')
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView2325188351514166917 where mc.company_id=aggView2325188351514166917.v1);
create or replace view aggJoin6896556227892614508 as (
with aggView5545968599667179905 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin3341385703485365106 join aggView5545968599667179905 using(v8));
create or replace view aggJoin8291991249089183111 as (
with aggView9157132613296202511 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView9157132613296202511 where mi.info_type_id=aggView9157132613296202511.v12);
create or replace view aggJoin8069582862113650302 as (
with aggView651742592460669559 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView651742592460669559 where miidx.info_type_id=aggView651742592460669559.v10);
create or replace view aggJoin4979070264860569589 as (
with aggView2838887245183493460 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView2838887245183493460 where t.kind_id=aggView2838887245183493460.v14 and title<> '' and ((title LIKE '%Champion%') OR (title LIKE '%Loser%')));
create or replace view aggJoin2864247465231952978 as (
with aggView8225787668883789929 as (select v22, MIN(v32) as v45 from aggJoin4979070264860569589 group by v22)
select v22, v29, v45 from aggJoin8069582862113650302 join aggView8225787668883789929 using(v22));
create or replace view aggJoin5438132333996278354 as (
with aggView4728739220582782432 as (select v22, MIN(v45) as v45, MIN(v29) as v44 from aggJoin2864247465231952978 group by v22,v45)
select v22, v43 as v43, v45, v44 from aggJoin6896556227892614508 join aggView4728739220582782432 using(v22));
create or replace view aggJoin7836024621501473773 as (
with aggView4842521338950445771 as (select v22, MIN(v43) as v43, MIN(v45) as v45, MIN(v44) as v44 from aggJoin5438132333996278354 group by v22,v43,v44,v45)
select v43, v45, v44 from aggJoin8291991249089183111 join aggView4842521338950445771 using(v22));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin7836024621501473773;
