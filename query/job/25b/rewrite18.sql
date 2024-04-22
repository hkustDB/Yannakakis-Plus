create or replace view aggView1309844753751007335 as select id as v28, name as v29 from name as n where gender= 'm';
create or replace view aggJoin3999680233881647185 as (
with aggView3077320760577280273 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView3077320760577280273 where mi.info_type_id=aggView3077320760577280273.v8 and info= 'Horror');
create or replace view aggView6327235758331194296 as select v18, v37 from aggJoin3999680233881647185 group by v18,v37;
create or replace view aggJoin6443510193961252096 as (
with aggView4778559389098973032 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select movie_id as v37 from movie_keyword as mk, aggView4778559389098973032 where mk.keyword_id=aggView4778559389098973032.v12);
create or replace view aggJoin491511208942764257 as (
with aggView6419135078922883825 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView6419135078922883825 where mi_idx.info_type_id=aggView6419135078922883825.v10);
create or replace view aggView7633700331434062800 as select v23, v37 from aggJoin491511208942764257 group by v23,v37;
create or replace view aggJoin3550992797681412790 as (
with aggView5946527514112185346 as (select v37 from aggJoin6443510193961252096 group by v37)
select id as v37, title as v38, production_year as v41 from title as t, aggView5946527514112185346 where t.id=aggView5946527514112185346.v37 and production_year>2010 and title LIKE 'Vampire%');
create or replace view aggView7377641308078674852 as select v38, v37 from aggJoin3550992797681412790 group by v38,v37;
create or replace view aggJoin6006547648891683288 as (
with aggView7141023905329259103 as (select v37, MIN(v18) as v49 from aggView6327235758331194296 group by v37)
select v38, v37, v49 from aggView7377641308078674852 join aggView7141023905329259103 using(v37));
create or replace view aggJoin6095744763066317526 as (
with aggView591157086396581616 as (select v37, MIN(v23) as v50 from aggView7633700331434062800 group by v37)
select v38, v37, v49 as v49, v50 from aggJoin6006547648891683288 join aggView591157086396581616 using(v37));
create or replace view aggJoin3265966089062793391 as (
with aggView7550896761923794670 as (select v28, MIN(v29) as v51 from aggView1309844753751007335 group by v28)
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView7550896761923794670 where ci.person_id=aggView7550896761923794670.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin7115060659420885402 as (
with aggView2711455345441066668 as (select v37, MIN(v51) as v51 from aggJoin3265966089062793391 group by v37,v51)
select v38, v49 as v49, v50 as v50, v51 from aggJoin6095744763066317526 join aggView2711455345441066668 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v38) as v52 from aggJoin7115060659420885402;
