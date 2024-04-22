create or replace view aggView8947015424376382445 as select id as v28, name as v29 from name as n where gender= 'm';
create or replace view aggJoin4705708999623275292 as (
with aggView3285745366965295177 as (select title as v38, id as v37 from title as t where production_year>2010)
select v37, v38 from aggView3285745366965295177 where v38 LIKE 'Vampire%');
create or replace view aggJoin4640280078055583901 as (
with aggView1957455337166719138 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView1957455337166719138 where mi.info_type_id=aggView1957455337166719138.v8 and info= 'Horror');
create or replace view aggView6281092148953940961 as select v18, v37 from aggJoin4640280078055583901 group by v18,v37;
create or replace view aggJoin3013076089883720402 as (
with aggView7312554389442921517 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView7312554389442921517 where mi_idx.info_type_id=aggView7312554389442921517.v10);
create or replace view aggView4237953896091503312 as select v23, v37 from aggJoin3013076089883720402 group by v23,v37;
create or replace view aggJoin4500181439650228956 as (
with aggView207637048597397126 as (select v37, MIN(v18) as v49 from aggView6281092148953940961 group by v37)
select person_id as v28, movie_id as v37, note as v5, v49 from cast_info as ci, aggView207637048597397126 where ci.movie_id=aggView207637048597397126.v37 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin9174564664215675685 as (
with aggView8619936337736885067 as (select v37, MIN(v38) as v52 from aggJoin4705708999623275292 group by v37)
select v23, v37, v52 from aggView4237953896091503312 join aggView8619936337736885067 using(v37));
create or replace view aggJoin2365909310572193846 as (
with aggView5072083335548425731 as (select v37, MIN(v52) as v52, MIN(v23) as v50 from aggJoin9174564664215675685 group by v37,v52)
select v28, v37, v5, v49 as v49, v52, v50 from aggJoin4500181439650228956 join aggView5072083335548425731 using(v37));
create or replace view aggJoin7902378661831471613 as (
with aggView2693333768309876960 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select movie_id as v37 from movie_keyword as mk, aggView2693333768309876960 where mk.keyword_id=aggView2693333768309876960.v12);
create or replace view aggJoin8850029933764959610 as (
with aggView7199992212734029284 as (select v37 from aggJoin7902378661831471613 group by v37)
select v28, v5, v49 as v49, v52 as v52, v50 as v50 from aggJoin2365909310572193846 join aggView7199992212734029284 using(v37));
create or replace view aggJoin5344777731736299911 as (
with aggView8183392794340040702 as (select v28, MIN(v49) as v49, MIN(v52) as v52, MIN(v50) as v50 from aggJoin8850029933764959610 group by v28,v50,v52,v49)
select v29, v49, v52, v50 from aggView8947015424376382445 join aggView8183392794340040702 using(v28));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v29) as v51,MIN(v52) as v52 from aggJoin5344777731736299911;
