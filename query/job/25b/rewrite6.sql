create or replace view aggView3393511492761398999 as select id as v28, name as v29 from name as n where gender= 'm';
create or replace view aggJoin6297603777264018297 as (
with aggView5615286226197090537 as (select title as v38, id as v37 from title as t where production_year>2010)
select v37, v38 from aggView5615286226197090537 where v38 LIKE 'Vampire%');
create or replace view aggJoin6967295853887630250 as (
with aggView5771555667353130140 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView5771555667353130140 where mi.info_type_id=aggView5771555667353130140.v8 and info= 'Horror');
create or replace view aggView1579852307301408607 as select v18, v37 from aggJoin6967295853887630250 group by v18,v37;
create or replace view aggJoin6669528607184032848 as (
with aggView7902660328825038572 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView7902660328825038572 where mi_idx.info_type_id=aggView7902660328825038572.v10);
create or replace view aggView5790163207041908208 as select v23, v37 from aggJoin6669528607184032848 group by v23,v37;
create or replace view aggJoin4599981369011394012 as (
with aggView3470420762460797512 as (select v37, MIN(v23) as v50 from aggView5790163207041908208 group by v37)
select person_id as v28, movie_id as v37, note as v5, v50 from cast_info as ci, aggView3470420762460797512 where ci.movie_id=aggView3470420762460797512.v37 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin3621115318288025822 as (
with aggView6154396000874625364 as (select v37, MIN(v38) as v52 from aggJoin6297603777264018297 group by v37)
select v18, v37, v52 from aggView1579852307301408607 join aggView6154396000874625364 using(v37));
create or replace view aggJoin3235798908234689145 as (
with aggView3515963202933240198 as (select v37, MIN(v52) as v52, MIN(v18) as v49 from aggJoin3621115318288025822 group by v37,v52)
select v28, v37, v5, v50 as v50, v52, v49 from aggJoin4599981369011394012 join aggView3515963202933240198 using(v37));
create or replace view aggJoin4534093077459546131 as (
with aggView5590824797108047022 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select movie_id as v37 from movie_keyword as mk, aggView5590824797108047022 where mk.keyword_id=aggView5590824797108047022.v12);
create or replace view aggJoin5100412565766218813 as (
with aggView427500083331954752 as (select v37 from aggJoin4534093077459546131 group by v37)
select v28, v5, v50 as v50, v52 as v52, v49 as v49 from aggJoin3235798908234689145 join aggView427500083331954752 using(v37));
create or replace view aggJoin8515752654917542272 as (
with aggView4646700392518029823 as (select v28, MIN(v50) as v50, MIN(v52) as v52, MIN(v49) as v49 from aggJoin5100412565766218813 group by v28,v50,v52,v49)
select v29, v50, v52, v49 from aggView3393511492761398999 join aggView4646700392518029823 using(v28));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v29) as v51,MIN(v52) as v52 from aggJoin8515752654917542272;
