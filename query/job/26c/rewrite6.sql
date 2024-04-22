create or replace view aggView5266863696745120032 as select name as v10, id as v9 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%'));
create or replace view aggJoin7266273279086984632 as (
with aggView8217954825215753655 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView8217954825215753655 where mi_idx.info_type_id=aggView8217954825215753655.v23);
create or replace view aggView3854140298907917633 as select v33, v47 from aggJoin7266273279086984632 group by v33,v47;
create or replace view aggJoin520765316828957840 as (
with aggView6242301451567564813 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView6242301451567564813 where t.kind_id=aggView6242301451567564813.v28 and production_year>2000);
create or replace view aggView8506926714308789700 as select v48, v47 from aggJoin520765316828957840 group by v48,v47;
create or replace view aggJoin5976276097766952213 as (
with aggView5978507931537709511 as (select v9, MIN(v10) as v59 from aggView5266863696745120032 group by v9)
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView5978507931537709511 where ci.person_role_id=aggView5978507931537709511.v9);
create or replace view aggJoin6665726751516289224 as (
with aggView6040694727222579820 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v47, subject_id as v5 from complete_cast as cc, aggView6040694727222579820 where cc.status_id=aggView6040694727222579820.v7);
create or replace view aggJoin2851801806612169599 as (
with aggView7560060192666934151 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47 from aggJoin6665726751516289224 join aggView7560060192666934151 using(v5));
create or replace view aggJoin1985540216097210676 as (
with aggView4790791406218493367 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v47 from movie_keyword as mk, aggView4790791406218493367 where mk.keyword_id=aggView4790791406218493367.v25);
create or replace view aggJoin1719114214419029793 as (
with aggView3991610854019274743 as (select v47 from aggJoin1985540216097210676 group by v47)
select v47 from aggJoin2851801806612169599 join aggView3991610854019274743 using(v47));
create or replace view aggJoin2888808397298983415 as (
with aggView6572315507916808485 as (select v47 from aggJoin1719114214419029793 group by v47)
select v38, v47, v59 as v59 from aggJoin5976276097766952213 join aggView6572315507916808485 using(v47));
create or replace view aggJoin2887797841050221157 as (
with aggView4089320582249192325 as (select id as v38 from name as n)
select v47, v59 from aggJoin2888808397298983415 join aggView4089320582249192325 using(v38));
create or replace view aggJoin2776603320661697173 as (
with aggView4362801495058247951 as (select v47, MIN(v59) as v59 from aggJoin2887797841050221157 group by v47,v59)
select v48, v47, v59 from aggView8506926714308789700 join aggView4362801495058247951 using(v47));
create or replace view aggJoin4466457408910368811 as (
with aggView2855810923595416856 as (select v47, MIN(v59) as v59, MIN(v48) as v61 from aggJoin2776603320661697173 group by v47,v59)
select v33, v59, v61 from aggView3854140298907917633 join aggView2855810923595416856 using(v47));
select MIN(v59) as v59,MIN(v33) as v60,MIN(v61) as v61 from aggJoin4466457408910368811;
